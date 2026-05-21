#!/usr/bin/env bash
# Runs as a Stop hook. Reflects on the session and proposes CLAUDE.md updates.
set -euo pipefail

PAYLOAD=$(cat)
SESSION_ID=$(echo "$PAYLOAD" | jq -r '.session_id // "unknown"')
TRANSCRIPT_PATH=$(echo "$PAYLOAD" | jq -r '.transcript_path // ""')

REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null) || exit 0
TIMESTAMP=$(date +"%Y-%m-%d-%H%M%S")
PROPOSALS_DIR="$REPO_ROOT/.claude/proposals"
mkdir -p "$PROPOSALS_DIR"
OUTPUT="$PROPOSALS_DIR/session-${TIMESTAMP}.md"

# --- Gather context ---
GIT_DIFF=$(git -C "$REPO_ROOT" diff HEAD 2>/dev/null | head -c 6000)
GIT_LOG=$(git -C "$REPO_ROOT" log --oneline -10 2>/dev/null)
CLAUDE_MD=$(head -c 3000 "$REPO_ROOT/CLAUDE.md" 2>/dev/null)

TRANSCRIPT_EXCERPT=""
if [[ -n "$TRANSCRIPT_PATH" && -f "$TRANSCRIPT_PATH" ]]; then
  TRANSCRIPT_EXCERPT=$(jq -r '
    select(.type == "message") |
    .role + ": " + (
      .content | if type == "array"
      then map(select(.type == "text") | .text) | join(" ")
      else tostring
      end
    )
  ' "$TRANSCRIPT_PATH" 2>/dev/null | tail -c 8000 || true)
fi

# --- Build reflection prompt ---
PROMPT=$(cat <<PROMPT
You are reviewing a Claude Code session for the project rooted at: $REPO_ROOT

Your task: identify new conventions, constraints, or rules that emerged this session and are NOT already captured in CLAUDE.md. Consider patterns in file edits, decisions made, errors avoided, and structural choices.

## Current CLAUDE.md
$CLAUDE_MD

## Git Changes This Session
${GIT_DIFF:-No uncommitted changes detected.}

## Recent Commits (last 10)
$GIT_LOG

## Session Transcript (tail)
${TRANSCRIPT_EXCERPT:-Not available — transcript path not exposed by harness.}

---
Output ONLY ready-to-paste CLAUDE.md markdown. Lead each proposed addition with a **bold rule** followed by one sentence of rationale. Group related rules under a heading. If nothing meaningful emerged, output exactly the line: No updates needed.
PROMPT
)

# --- Run reflection via claude CLI (non-interactive) ---
if command -v claude &>/dev/null; then
  PROPOSAL=$(echo "$PROMPT" | claude --print 2>/dev/null) \
    || PROPOSAL="claude --print failed. Check that the CLI is authenticated and on PATH."
else
  PROPOSAL="claude CLI not found on PATH. Install Claude Code CLI to enable AI reflection."
fi

# --- Write proposal file ---
cat > "$OUTPUT" <<MARKDOWN
# CLAUDE.md Proposals — ${TIMESTAMP}

_Session: \`${SESSION_ID}\`_

---

${PROPOSAL}
MARKDOWN

printf '{"systemMessage":"Session reflection saved → .claude/proposals/session-%s.md — review before applying."}' "$TIMESTAMP"
