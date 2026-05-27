---
name: clarify
description: >-
  Stage 1 of the C.R.A.F.T. Framework — Clarify. Use at the very start of any
  project to frame the problem: run a short interview and produce a one-page
  Brief. Trigger when the user wants to start something new, scope an idea,
  explore a request, or when a request is vague and needs sharpening.
---

# Stage 1 — CLARIFY (Frame the problem)

**Goal:** replace a fuzzy idea with a sharp, agreed understanding before any
work begins. **Deliverable:** a one-page Brief.

## How to run this stage

1. **Adopt the Interviewer role.** You are not building anything yet — your job
   is to make sure the right problem is being solved.
2. **Read the Memory files** if they exist (`CONSTITUTION.md`, `CONTEXT.md`) so
   your questions fit the project.
3. **Run a short interview — 5 to 10 questions.** Ask a few at a time, not all
   at once. Push back politely on vague answers. Cover:
   - **Problem** — what is the actual problem? Who feels it, how often?
   - **Business goal** — why does this matter to the business? What outcome does
     it drive, and how does it fit the bigger picture?
   - **Why now** — why is this worth doing now rather than later? Timing,
     urgency, cost of delay, the trigger or window.
   - **Audience** — who is this for? Who is affected? For a real product, sketch
     the persona and the job-to-be-done.
   - **Success** — how will we know it worked, at the outcome level? Which metric
     moves, by roughly how much? ("Done" alone isn't success.)
   - **Constraints** — limits: time, budget, tools, rules, must-nots.
   - **Out of scope** — what are we deliberately not doing now?
   - **Prior art** — has this been tried? What happened?
   - **Risks** — what could go wrong or make this harder than it looks?
4. **Stop and ask rather than guess.** If the request is ambiguous, present
   the possible interpretations and let the user choose.
5. **Write the Brief.** Use the template at `templates/brief-template.md` in
   this skill folder. Keep it to ONE page.
6. **Save it** to `specs/<project-name>/brief.md` in the user's project.

## Human Gate — stop here

Show the finished Brief and ask the user to approve it. Read it back: does it
match what they actually meant? Edit until yes. **Do not proceed to Stage 2
(Record) until the Brief is explicitly approved.**

When approved, update `STATE.md` with the decision and tell the user the next
step is `/craft-framework:record`.

## Red flags — stop and fix

- You started planning or building during this stage.
- "Success" is vague ("better", "faster") with no way to measure it.
- Nothing is listed as out of scope.
- The Brief grew past one page — trim it; it's becoming a Spec.
