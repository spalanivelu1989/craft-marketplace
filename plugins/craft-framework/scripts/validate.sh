#!/usr/bin/env bash
# C.R.A.F.T. artifact validator.
# Deterministic, text-only checks on a project's specs/<name>/ artifacts:
# required sections, spec semver + change log, R/AC IDs, AC->R traceability,
# task coverage matrix (no gaps, no failures, no untraceable tasks), and the
# review report's acceptance-criteria coverage. No model judgment involved.
#
# Usage:
#   validate.sh <project-name | path-to-specs-dir>
#   validate.sh                 # auto-detects a single specs/*/ directory
#
# Exit codes: 0 = no FAILs, 1 = one or more FAILs, 2 = usage / dir error.

set -uo pipefail

PASS_COUNT=0
FAIL_COUNT=0
WARN_COUNT=0

pass() {
  printf 'PASS  %s\n' "$1"
  PASS_COUNT=$((PASS_COUNT + 1))
}
fail() {
  printf 'FAIL  %s\n' "$1"
  FAIL_COUNT=$((FAIL_COUNT + 1))
}
warn() {
  printf 'WARN  %s\n' "$1"
  WARN_COUNT=$((WARN_COUNT + 1))
}
info() { printf 'INFO  %s\n' "$1"; }

# --- Resolve the specs directory -------------------------------------------
resolve_dir() {
  local arg="${1:-}"
  if [[ -z "$arg" ]]; then
    local dirs=(specs/*/)
    if [[ ${#dirs[@]} -eq 1 && -d "${dirs[0]}" ]]; then
      printf '%s' "${dirs[0]%/}"
      return 0
    fi
    echo "error: no project given and could not auto-detect a single specs/*/ directory" >&2
    return 2
  fi
  if [[ -d "$arg" ]]; then
    printf '%s' "${arg%/}"
    return 0
  fi
  if [[ -d "specs/$arg" ]]; then
    printf '%s' "specs/$arg"
    return 0
  fi
  echo "error: no such directory: '$arg' or 'specs/$arg'" >&2
  return 2
}

DIR="$(resolve_dir "${1:-}")" || exit 2

BRIEF="$DIR/brief.md"
SPEC="$DIR/spec.md"
PLAN="$DIR/plan.md"
TASKS="$DIR/tasks.md"
REVIEW="$DIR/review-report.md"

# --- Helpers ----------------------------------------------------------------

# heading_present <file> <heading-text> : heading STARTS with the text
heading_present() {
  grep -qiE "^#{1,6}[[:space:]]+$2([[:space:](]|$)" "$1"
}

# heading_contains <file> <text> : text appears anywhere in a heading line
heading_contains() {
  grep -qiE "^#{1,6}[[:space:]].*$2" "$1"
}

# require_headings <file> <label> <heading...>
require_headings() {
  local file="$1" label="$2"
  shift 2
  local h missing=()
  for h in "$@"; do
    heading_present "$file" "$h" || missing+=("$h")
  done
  if [[ ${#missing[@]} -eq 0 ]]; then
    pass "$label: all required sections present"
  else
    fail "$label: missing section(s): ${missing[*]}"
  fi
}

# section_body <file> <heading-text> : prints lines until the next heading
section_body() {
  awk -v pat="$2" '
    $0 ~ ("^#+[[:space:]]+" pat) { insec = 1; next }
    insec && /^#+[[:space:]]/    { insec = 0 }
    insec                        { print }
  ' "$1"
}

# ids_in_first_column <file> <PREFIX> : IDs like R1/AC1 used as a row's 1st cell
ids_in_first_column() {
  grep -oE "^\|[[:space:]]*$2[0-9]+" "$1" 2>/dev/null \
    | grep -oE "$2[0-9]+" | sort -u
}

# --- brief.md ---------------------------------------------------------------
validate_brief() {
  [[ -f "$BRIEF" ]] || {
    info "brief.md not present — skipping (Stage 1 not started)"
    return
  }
  require_headings "$BRIEF" "brief.md" \
    "Problem" "Business goal" "Why now" "Audience" "Success" \
    "Constraints" "Out of scope" "Risks"
}

# --- spec.md ----------------------------------------------------------------
validate_spec() {
  [[ -f "$SPEC" ]] || {
    info "spec.md not present — skipping (Stage 2 not started)"
    return
  }
  require_headings "$SPEC" "spec.md" \
    "Requirements" "Scenarios" "Constraints" "Dependencies" \
    "Success metrics" "Acceptance criteria" "Out of scope" \
    "Future vision" "Open questions" "Change log"

  # User experience is recommended but not required (some specs have no UI).
  if heading_present "$SPEC" "User experience"; then
    pass "spec.md: user experience section present"
  else
    warn "spec.md: no User experience section (omit only if truly no user-facing UX)"
  fi

  # Version: present and semver (optional leading v).
  local ver
  ver="$(grep -iE '^[-*][[:space:]]*\*\*Version:\*\*' "$SPEC" | head -1 \
    | grep -oE 'v?[0-9]+\.[0-9]+\.[0-9]+' | head -1)"
  if [[ -n "$ver" ]]; then
    pass "spec.md: version is semver ($ver)"
  else
    fail "spec.md: Version field missing or not semver (expected vX.Y.Z)"
  fi

  # Change log has at least one version row.
  if section_body "$SPEC" "Change log" | grep -qE '^\|[[:space:]]*v?[0-9]+\.[0-9]+\.[0-9]+'; then
    pass "spec.md: change log has at least one version entry"
  else
    warn "spec.md: change log has no version rows yet"
  fi

  # Requirements and acceptance criteria exist.
  local reqs acs
  reqs="$(ids_in_first_column "$SPEC" R)"
  acs="$(ids_in_first_column "$SPEC" AC)"
  if [[ -n "$reqs" ]]; then
    pass "spec.md: $(wc -w <<<"$reqs" | tr -d ' ') requirement ID(s) defined"
  else
    fail "spec.md: no requirements (R#) defined"
  fi
  if [[ -n "$acs" ]]; then
    pass "spec.md: $(wc -w <<<"$acs" | tr -d ' ') acceptance criterion ID(s) defined"
  else
    fail "spec.md: no acceptance criteria (AC#) defined"
  fi

  # Traceability: every requirement is referenced by at least one AC.
  if [[ -n "$reqs" ]]; then
    local ac_refs missing=()
    ac_refs="$(section_body "$SPEC" "Acceptance criteria" | grep -oE 'R[0-9]+' | sort -u)"
    local r
    for r in $reqs; do
      grep -qx "$r" <<<"$ac_refs" || missing+=("$r")
    done
    if [[ ${#missing[@]} -eq 0 ]]; then
      pass "spec.md: every requirement is verified by an acceptance criterion"
    else
      fail "spec.md: requirement(s) with no acceptance criterion: ${missing[*]}"
    fi
  fi

  # Outcome metrics: at least one M# must be defined ("we shipped" isn't success).
  local metrics
  metrics="$(ids_in_first_column "$SPEC" M)"
  if [[ -n "$metrics" ]]; then
    pass "spec.md: $(wc -w <<<"$metrics" | tr -d ' ') outcome metric(s) defined"
  else
    fail "spec.md: no outcome metrics (M#) defined in Success metrics"
  fi
}

# --- plan.md + tasks.md -----------------------------------------------------
validate_plan() {
  [[ -f "$PLAN" ]] || {
    info "plan.md not present — skipping (Stage 3 not started)"
    return
  }
  require_headings "$PLAN" "plan.md" \
    "Approach" "Architecture" "Key decisions" "Risks" "Requirements coverage"
}

validate_tasks() {
  [[ -f "$TASKS" ]] || {
    info "tasks.md not present — skipping (Stage 3 not started)"
    return
  }
  require_headings "$TASKS" "tasks.md" "Task list" "Coverage matrix"

  # No failed/incomplete rows in the coverage matrix.
  if section_body "$TASKS" "Coverage matrix" | grep -q '❌'; then
    fail "tasks.md: coverage matrix contains an uncovered (❌) requirement"
  else
    pass "tasks.md: coverage matrix has no ❌ rows"
  fi

  # Coverage gap: every spec requirement must appear in the matrix.
  if [[ -f "$SPEC" ]]; then
    local reqs matrix_reqs missing=()
    reqs="$(ids_in_first_column "$SPEC" R)"
    matrix_reqs="$(ids_in_first_column "$TASKS" R)"
    local r
    for r in $reqs; do
      grep -qx "$r" <<<"$matrix_reqs" || missing+=("$r")
    done
    if [[ ${#missing[@]} -eq 0 && -n "$reqs" ]]; then
      pass "tasks.md: every requirement appears in the coverage matrix"
    elif [[ ${#missing[@]} -gt 0 ]]; then
      fail "tasks.md: coverage gap — requirement(s) not in matrix: ${missing[*]}"
    fi
  else
    warn "tasks.md: spec.md absent — cannot cross-check requirement coverage"
  fi

  # Untraceable tasks: every defined task must declare what it Covers.
  local task_ids
  task_ids="$(grep -oE '^#{2,4}[[:space:]]+T[0-9]+' "$TASKS" | grep -oE 'T[0-9]+' | sort -u)"
  if [[ -n "$task_ids" ]]; then
    local empties
    empties="$(grep -cE '^\*\*Covers:\*\*[[:space:]]*(—|-)?[[:space:]]*$' "$TASKS")"
    if [[ "$empties" -gt 0 ]]; then
      fail "tasks.md: $empties task(s) have an empty Covers field (untraceable / scope creep)"
    else
      pass "tasks.md: every task declares the requirement(s) it covers"
    fi
  else
    warn "tasks.md: no task definitions (### T#) found"
  fi
}

# --- review-report.md -------------------------------------------------------
validate_review() {
  [[ -f "$REVIEW" ]] || {
    info "review-report.md not present — skipping (Stage 5 not started)"
    return
  }
  require_headings "$REVIEW" "review-report.md" \
    "Verdict summary" "Issues by severity" "Recommendation"
  local layer miss=()
  for layer in Function Quality Alignment; do
    heading_contains "$REVIEW" "$layer" || miss+=("$layer")
  done
  if [[ ${#miss[@]} -eq 0 ]]; then
    pass "review-report.md: all three review layers present"
  else
    fail "review-report.md: missing review layer(s): ${miss[*]}"
  fi

  # Every spec acceptance criterion must be checked in the review.
  if [[ -f "$SPEC" ]]; then
    local acs review_acs missing=()
    acs="$(ids_in_first_column "$SPEC" AC)"
    review_acs="$(ids_in_first_column "$REVIEW" AC)"
    local ac
    for ac in $acs; do
      grep -qx "$ac" <<<"$review_acs" || missing+=("$ac")
    done
    if [[ ${#missing[@]} -eq 0 && -n "$acs" ]]; then
      pass "review-report.md: every acceptance criterion is verified"
    elif [[ ${#missing[@]} -gt 0 ]]; then
      fail "review-report.md: acceptance criteria not verified: ${missing[*]}"
    fi
  else
    warn "review-report.md: spec.md absent — cannot cross-check AC coverage"
  fi

  # A recommendation must be selected.
  if grep -qE '^[-*][[:space:]]*\[[xX]\]' "$REVIEW"; then
    pass "review-report.md: a recommendation is selected"
  else
    fail "review-report.md: no recommendation selected (no checked [x] box)"
  fi
}

# --- Run --------------------------------------------------------------------
echo "C.R.A.F.T. validation — $DIR"
echo "---------------------------------------------"
validate_brief
validate_spec
validate_plan
validate_tasks
validate_review
echo "---------------------------------------------"
printf 'Summary: %d passed, %d failed, %d warning(s)\n' \
  "$PASS_COUNT" "$FAIL_COUNT" "$WARN_COUNT"

[[ "$FAIL_COUNT" -eq 0 ]] || exit 1
exit 0
