---
tags:
- ai
- tdd
- coding-practices
- testing
- unit testing
- development
menuorder: 0
id: 3199ad7e-cd0f-440e-8cd1-e00081770c4f
author: bsstahl
title: TDD in the AI Era
description: AI changes where the hard work happens in software development, but it does not change the Red-Green-Refactor discipline. If anything, TDD becomes more important — and the loop becomes a more powerful tool — when an AI is your pairing partner.
ispublished: false
showinlist: false
buildifnotpublished: true
publicationdate: 2026-06-03T00:00:00.000+00:00
lastmodificationdate: 2026-06-03T00:00:00.000+00:00
slug: TDD-in-the-AI-Era
categories:
- Development

---

AI-assisted development tools are changing the way we write software. What they are not changing is what good software development looks like. The discipline of Test-Driven Development — Red, Green, Refactor — is not obsoleted by AI. It is validated by it, and in several important ways it becomes more valuable.

This post is grounded in the ideas I explore in my workshop, [TDD in the AI Era]({PathToRoot}/Presentations/ShortWorkshop/TDDInTheAIEra/index.html). It is also the extended version of the answer to the AI-related question in my {PageLink:Unit-Testing-and-TDD-FAQ|TDD FAQ}.

## The Bottleneck Has Moved

Before AI-assisted tooling, implementation throughput was often constrained by typing speed and mechanical coding effort. We understood the requirement, translated intent into code, and paid the time cost at the keyboard. With modern LLM-based tooling, that constraint has been drastically reduced. Work that previously took hours to type can be generated in seconds.

From a Theory of Constraints perspective, this was predictable: when one bottleneck is removed, the next constraint becomes visible. In AI-assisted delivery, the constraints that dominate are now:

- **Problem framing and decomposition** — The quality of your specification, plus your ability to partition behavior into small testable units, now matters more than raw implementation speed.
  - **Verification** — Plausible output is cheap; trustworthy output is not. The cost of confidence has not declined at the same rate as the cost of generation.
  - **Decomposition** — Large concerns must still be split into coherent units with explicit boundaries and a clear execution context.
  - **Comprehension** — Fast generation can outpace human understanding. Reconstructing a lost mental model is expensive, especially in distributed systems with asynchronous flows.

TDD is one of the few practices that directly addresses all three.

TDD addresses these issues directly.

## Capability Is Not Permission

An AI can produce an end-to-end implementation from a well-formed prompt. That is genuine capability. The architectural question, however, is not "can we generate this?" but "should we accept this implementation path in this lifecycle context?"

There are scenarios where a prompt-and-accept model is perfectly rational: throwaway scripts, temporary migration utilities, or intentionally black-boxed components behind stable contracts. But for shared libraries, long-lived product code, and systems with non-trivial operational characteristics, human ownership cannot be delegated away. Someone still owns correctness, observability, and evolution.

That is why Red-Green-Refactor remains essential. It keeps humans in control of behavior boundaries while still exploiting AI for acceleration.

## Tests Matter More Than the Code

The most important mindset shift is this: **implementations are increasingly disposable; tests are durable assets**.

If your tests are sound, any contributor, human or AI, can refactor aggressively and still preserve behavior. If your tests are weak, missing, or mis-specified, no amount of elegant generated code makes the result trustworthy.

None of this is new in principle. What changed is urgency. In the AI era, regeneration is almost free, so the surviving artifact is the behavioral contract encoded in tests. That contract is what future engineers rely on to reason about changes, prevent regressions, and avoid accidental dual-writes across boundaries.

Practically, tests also become your best comprehension artifact. Generated code explains one possible *how*. Well-designed tests, written by humans from intent, explain *what* and *why*. In fast-moving systems, that distinction is not philosophical; it is operational.

## AI as a Pairing Partner

The most productive model I have found is to treat AI as a pairing partner, not as an autonomous code fountain.

A generator accepts input and emits output. A pairing partner participates in a design conversation: challenge assumptions, compare alternatives, discuss trade-offs, and iterate quickly. Used this way, AI is exceptionally valuable. It can produce candidate designs rapidly, adapt to feedback without defensiveness, and help you explore option space that might otherwise be ignored.

But architecture ownership does not transfer. AI does not own your bounded contexts, integration strategy, reliability posture, or acceptance criteria. Those remain human responsibilities. AI changes velocity; it does not change accountability.

## The Loop Stays the Same

Red-Green-Refactor remains the control system. What changes is who does the typing and what each step involves.

### Red: Establish Constraints Before Writing Code

Red is where the most valuable work happens in AI-assisted TDD. Before implementation, use the AI dialogue to force assumptions into the open:

- What are the inputs, outputs, and failure modes?
- Which invariants are non-negotiable?
- Which dependencies are in scope, and which are intentionally excluded?
- What idempotent behavior is required if retries occur?

Then write the smallest failing test that encodes that boundary. A reliable prompt pattern here is: *"Strict TDD mode; no implementation yet."*

If you accumulate multiple failing tests before producing any working behavior, treat that as a decomposition signal. The behavior is likely too large for one loop iteration.

### Green: Implement the Minimum, No More

With one failing test in place, request the smallest implementation that makes that test pass and no more. Prompt pattern: *"Strict TDD mode; satisfy current tests only."*

Then execute the tests and verify the red-to-green transition explicitly. Do not infer success from code appearance. AI can satisfy assertions in shallow ways: hard-coded constants, short-circuit logic, or path-specific hacks that are technically passing but behaviorally incorrect.

Also keep docs and intent notes synchronized. If behavior is concrete enough to test, it is concrete enough to describe.

### Refactor: Prove and Improve

Refactor is where AI can deliver outsized value when bounded by tests.

**Structural refactoring** (naming, extraction, abstraction boundaries) remains the classic objective. AI can accelerate this safely when constrained by: *"Strict TDD mode; refactor only; preserve behavior."*

**Mutation testing** has moved from theoretical nice-to-have to practical workflow component. Agents can introduce realistic mutations (boundary flips, operator substitutions, null-path inversions, return-value swaps), run the suite, and flag surviving mutants. Surviving mutants are not trivia; they identify weak assertions and blind spots.

Use coverage as a diagnostic signal, not as a vanity metric. Uncovered paths after green are questions to answer: missing test, unintended behavior, or intentional boundary?

## What AI Should Not Do

A few patterns to watch for and avoid:

**AI-authored tests accepted without a genuine red phase.** If tests are synthesized from existing implementation, they often encode current behavior, not intended behavior. That is test-after development wearing a new label.

**Scope creep through cheap generation.** When implementation cost approaches zero, overbuilding risk increases. TDD provides the governor: no test, no feature.

**Implementation-coupled white-box tests.** AI frequently mirrors internals in test shape. Those tests are brittle and fail during valid refactors. Prefer behavior-based assertions at boundaries.

**Throughput beyond comprehension.** Shipping code faster than humans can understand it creates latent operational risk. TDD gates are forced comprehension checkpoints that keep teams from accumulating opaque behavior.

## Starting Your Own Workflow

The simplest AI-assisted TDD workflow requires no special tooling beyond whatever AI chat tool you have access to. You can start right now:

1. Describe the problem and explicitly define boundaries, success criteria, and non-goals.
2. Co-author one failing test and verify it fails for the expected reason.
3. Request the minimal implementation required to pass that test.
4. Verify green, then refactor for clarity and maintainability.
5. Repeat with the next behavior.

From there, layer in richer workflows as needed: IDE agents, mutation pipelines, coverage gates, and architecture checks. The foundation does not change. Human judgment owns test intent and boundary decisions; AI amplifies execution.

## The Discipline Is the Point

AI reduces the marginal cost of producing code. It does not reduce the cost of producing correct, maintainable, comprehensible systems. Red-Green-Refactor addresses that gap directly by enforcing pre-implementation intent, executable verification, and continuous design improvement.

Comprehension is not optional polish. It is an engineering control. A codebase that "works" but cannot be reasoned about is operational debt waiting to mature.

A codebase where behavior is specified through tests before implementation exists is different. It is explainable, evolvable, and safer to change. That was true before AI. In an era of near-zero generation cost, it is even more true now.
