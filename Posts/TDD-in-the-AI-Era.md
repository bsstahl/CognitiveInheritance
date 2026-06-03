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

Before AI-assisted tools, typing was often the rate-limiting step, or at least, a significant bottleneck. We understood the problem, we knew what to write, and we sat down and typed it. AI has largely eliminated that chokepoint. Code that used to take hours to produce can now be generated in seconds.

But according to the Theory of Constraints, removing one bottleneck simply reveals the next one. The new bottlenecks are:

- **Understanding the problem** — Spec quality and the ability to decompose large problems into testable units now drive progress more than implementation speed. While this has *always* been a key constraint in our processes, it is now, by far, the primary concern. This includes:
  - **Verification** — Plausible output is cheap. Trustworthy output is not. The cost of confidence has not gone down just because the cost of generation has.
  - **Decomposition** — Large problems still need to be sliced carefully into units small enough to reason about, test, and hand to an AI with a crisp boundary.
- **Comprehension** — When code generation is fast, it is easy to produce more code than any developer fully understands. Maintaining a clear mental model of how a system works — and recovering it when it is lost — is expensive. The larger and faster a codebase grows, the harder this becomes.

TDD addresses these issues directly.

## Capability Is Not Permission

AI can generate an entire working implementation from a well-formed specification. That is a real capability, and it is genuinely useful — for the right class of problems.

The judgment call is not "can we?" It is "should we in this context?"

Throwing a spec over the wall and accepting whatever comes back is appropriate in limited situations: disposable code, or permanently black-boxed services with stable, well-understood contracts. For shared code, long-lived systems, or anything where humans need to understand and evolve the implementation, you need to keep humans in the loop at every step of the development cycle. That loop is Red-Green-Refactor.

## Tests Matter More Than the Code

This is the most important shift in mindset for AI-assisted development: **implementations are disposable; tests are not**.

A correct test suite means any agent — human or AI — can refactor or replace the implementation ruthlessly and know immediately whether behavior was preserved. If the tests are right, the code can be anything. If the tests are wrong or missing, the code cannot be trusted regardless of how it was generated.

This is not a new insight. It has always been true. But AI makes it urgent in a way it wasn't before, because the cost of throwing away and regenerating an implementation is now nearly zero. The tests are the specification that survives. Any agent reading them — human or machine — can understand what the system is supposed to do and verify that it actually does it.

This also makes tests the primary comprehension artifact of the system. When AI generates hundreds of lines in seconds, the tests — written by a human, grounded in intent, and validated by watching them fail before they pass — are what allow any future reader to reconstruct a true understanding of what the system does and why. Code describes *how*. Tests describe *what* and *why*. In an AI-assisted workflow, the *how* is cheap and disposable. The *what* and *why* are not.

## AI as a Pairing Partner

The most productive mental model I have found is to treat AI as a pairing partner rather than a code generator. The distinction matters.

A code generator takes input and produces output. A pairing partner is part of a dialogue. You discuss the problem, propose approaches, push back on each other's ideas, and converge on a solution together. AI tools, used well, can do all of this. They generate options quickly, adapt to feedback without ego, and are available any time. They are patient in a way human pairing partners sometimes are not.

What they cannot do is own the architecture, the design boundaries, or the acceptance criteria. Human judgment still controls those. What AI changes is the cost of exploring the solution space.

## The Loop Stays the Same

Red-Green-Refactor remains the control system. What changes is who does the typing and what each step involves.

### Red: Establish Constraints Before Writing Code

The Red step is where the work of AI-assisted TDD actually happens. Before any implementation, use the AI as a thinking partner to surface and externalize your assumptions:

- What are the inputs and outputs?
- What invariants must always hold?
- What external calls and dependencies are in scope?
- What is explicitly out of scope?

Once those constraints are clear, write the minimum failing test that enforces the scope boundary. A useful prompt pattern at this stage is: *"Strict TDD mode; no behavior yet."*

If you find yourself writing more than one or two failing tests before any implementation exists, treat that as a scope smell. The loop is designed to be narrow. Wide red phases usually mean the behavior being tested needs to be broken down further.

### Green: Implement the Minimum, No More

With a failing test in hand, ask the AI to propose the simplest implementation that makes the test pass — and nothing more. Prompt pattern: *"Strict TDD mode; satisfy tests only."*

Then watch the test actually pass. Do not skip this step. AI can produce plausible-looking code that passes a test in a trivially wrong way — returning a hardcoded value, short-circuiting a check, or satisfying the letter of the assertion without the intent behind it. The red-to-green transition is your primary signal that the implementation is honest.

Keep documentation aligned during this step. If behavior is clear enough to test, it is clear enough to document briefly.

### Refactor: Prove and Improve

The Refactor step is where AI-assisted development offers some of its most powerful new capabilities.

**Structural improvements** — better names, cleaner decomposition, appropriate abstractions — are the traditional content of this step. AI can accelerate all of them. Prompt pattern: *"Strict TDD mode; refactor only; preserve behavior."*

**Mutation testing** is now practical inside normal development loops in a way it simply was not before. AI agents can generate realistic code mutations — boundary condition flips, arithmetic operator changes, null path inversions, return value swaps — run the test suite against each mutation, and report surviving mutants. Surviving mutants expose weak assertions or missing test cases. Tightening those before moving to the next behavior makes the test suite progressively more trustworthy.

Use coverage during this step as well, but use it as a confidence gate rather than a trophy metric. Uncovered code after a green step is a signal: Is there a missing test? Is the implementation doing something that was not intended? Is this an intentional scope boundary? Classify the gap, then decide whether to proceed.

## What AI Should Not Do

A few patterns to watch for and avoid:

**AI-generated tests accepted without the red phase.** If you ask an AI to write tests for an existing implementation, those tests are likely to describe what the code does rather than what it *should* do. This is the same problem as test-later development, and it defeats most of the benefits of TDD. Always own the tests. Always watch them fail for the right reason before trusting the green.

**Scope creep via generation.** Because adding a new feature costs almost nothing when AI is doing the typing, the temptation to build things that are not yet needed is stronger than ever. The TDD discipline of writing a test for each behavior before implementing it is the check on this. No test, no feature.

**White-box, implementation-coupled tests.** AI tends to generate tests that mirror the structure of the implementation it just wrote. Those tests are brittle. They will break during refactoring even when behavior is preserved. Favor behavior-level assertions through interfaces and boundaries, not structural assertions about internals.

**Generating faster than you can comprehend.** When AI produces code at high speed and developers accept it wholesale, the result can be a system that works but that no one on the team fully understands. That understanding is expensive to recover — often more expensive than the time saved by generating quickly in the first place. Each TDD gate — writing the test, watching it fail, watching it pass, refactoring — is a forced comprehension checkpoint. It ensures that someone understood the behavior well enough to specify it before the implementation existed. Bypass enough of these gates and the codebase becomes, in practice, as opaque as a black box you didn't write yourself.

## Starting Your Own Workflow

The simplest AI-assisted TDD workflow requires no special tooling beyond whatever AI chat tool you have access to. You can start right now:

1. Describe your problem to the AI. Discuss constraints, boundaries, and what done looks like.
2. Ask the AI to help you write the first failing test. Review it. Make sure it fails for the right reason.
3. Ask the AI to implement only what is needed to pass that test.
4. Watch the test pass. Refactor together.
5. Add the next test. Repeat.

From there, you can layer in IDE-integrated tools, agent-based workflows, and mutation testing as your confidence and the risk profile of the work warrant. The baseline — Red-Green-Refactor, with human judgment owning the boundaries and the tests — stays constant regardless of which tools you add.

## The Discipline Is the Point

AI lowers the cost of generating code. It does not lower the cost of generating *correct* code, and it does not preserve your understanding of the system you are building. The Red-Green-Refactor loop addresses both. It forces you to define what correct means before you produce anything, gives you an automated, repeatable way to verify that what you produced is actually correct, and — critically — it keeps you engaged with the system at each step, maintaining the comprehension that makes confident change possible.

Comprehension is not a soft concern. A codebase that no one fully understands is a liability regardless of how well it performs today. A codebase where the tests were written by humans before the implementation existed — where every behavior was specified before it was built — is a codebase that any developer, or any AI, can reason about, extend, and improve with confidence.

That discipline has always mattered. In an era when the temptation to generate first and understand later has never been stronger, it matters more than ever.
