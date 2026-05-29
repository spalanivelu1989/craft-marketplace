#!/usr/bin/env bash
# C.R.A.F.T. implementation gate — PreToolUse hook on Edit|Write.
#
# Makes "you can't skip to implementation, you earn it" a HARD STOP instead of
# an instruction. Blocks edits to implementation files until a project has an
# approved plan.md + tasks.md (i.e. the Assemble gates were passed).
#
# Decisions:
#   ALLOW (exit 0):
#     - the repo isn't using C.R.A.F.T. (no specs/<project>/brief.md exists), or
#     - the edit targets a C.R.A.F.T. artifact (anything under specs/, or a
#       Memory file at the project root), or
#     - some project already has plan.md AND tasks.md marked Status: Approved.
#   BLOCK (exit 2): a C.R.A.F.T. project is underway but no approved plan+tasks
#     exist, and the edit targets implementation. The reason on stderr is fed
#     back to the agent so it can self-correct.
#
# Bypass deliberately (e.g. an unrelated hotfix) with: CRAFT_GATE_OFF=1
#
# Note: this gate is intentionally conservative — it only activates inside a
# repo that has actually started a C.R.A.F.T. project, so a global plugin
# install never blocks edits in unrelated projects.

set -uo pipefail

# --- Escape hatch -----------------------------------------------------------
[[ -n "${CRAFT_GATE_OFF:-}" ]] && exit 0

# --- Parse the hook payload -------------------------------------------------
input="$(cat)"
fp="$(printf '%s' "$input" | jq -r '.tool_input.file_path // empty' 2>/dev/null)"
cwd="$(printf '%s' "$input" | jq -r '.cwd // empty' 2>/dev/null)"
[[ -z "$cwd" ]] && cwd="$PWD"
[[ -z "$fp" ]] && exit 0 # nothing to evaluate

# Normalize the target to an absolute path.
case "$fp" in
  /*) abs="$fp" ;;
  *) abs="$cwd/$fp" ;;
esac

specs_dir="$cwd/specs"

# --- Only activate inside a C.R.A.F.T. project ------------------------------
[[ -d "$specs_dir" ]] || exit 0
shopt -s nullglob
have_project=0
for b in "$specs_dir"/*/brief.md; do
  have_project=1
  break
done
[[ "$have_project" -eq 1 ]] || exit 0

# --- Always allow edits to C.R.A.F.T.'s own artifacts -----------------------
# Planning stages must be able to write their deliverables and Memory files.
case "$abs" in
  */specs/*) exit 0 ;;
esac
case "$(basename "$abs")" in
  CONSTITUTION.md | CONTEXT.md | STATE.md | LEARNINGS.md | implementation-notes.md) exit 0 ;;
esac

# --- Implementation edit: is the gate earned? -------------------------------
# Earned when any project has BOTH plan.md and tasks.md at Status: Approved.
is_approved() {
  grep -qiE '^[-*][[:space:]]*\*\*Status:\*\*[[:space:]]*Approved' "$1" 2>/dev/null
}
for plan in "$specs_dir"/*/plan.md; do
  tasks="$(dirname "$plan")/tasks.md"
  if is_approved "$plan" && [[ -f "$tasks" ]] && is_approved "$tasks"; then
    exit 0
  fi
done

# --- Blocked ----------------------------------------------------------------
proj="$(for b in "$specs_dir"/*/brief.md; do basename "$(dirname "$b")"; done | head -1)"
cat >&2 <<EOF
C.R.A.F.T. gate: implementation is blocked — you have not earned it yet.

Target of this edit:
  $abs

No project has passed the Assemble gates: there is no plan.md + tasks.md marked
"Status: Approved". The framework's whole point is that you cannot skip to
implementation — you pass through the gates first, and that friction is the value.

Earn it instead:
  1. Finish the stages for "${proj:-<project>}":  clarify → (shape) → record → assemble
  2. Get plan.md AND tasks.md to "Status: Approved" (pass both Assemble gates)
  3. Then /craft-framework:forge to build

To bypass deliberately (e.g. an unrelated hotfix): set CRAFT_GATE_OFF=1
EOF
exit 2
