---
author: bsstahl
tags:
- development
- testing
- code-coverage
- tdd
- quality
categories:
- Development
menuorder: 0
id: 7e8f5a3d-9b12-4f8a-b6e7-c5d9e2a3f4b1
title: When Code Coverage Catches Bugs - A Case for Complete Coverage
description: 
teaser: 
ispublished: false
showinlist: false
buildifnotpublished: true
publicationdate: 2025-03-07T07:00:00Z
lastmodificationdate: 2025-03-07T08:00:00Z
slug: when-code-coverage-catches-bugs

---
The debate around code coverage metrics has been ongoing in the software development community for years. While some argue that pursuing 100% code coverage is a waste of resources, I recently had an experience that reinforces the value of complete coverage as a tool for quality improvement, not just a vanity metric.

#### The Uncovered Branch

While adding a feature to a product in development, I noticed an uncovered branch in a validation method. This method was responsible for validating input parameters before they were processed by our business logic. The coverage report showed that while most of the method was covered by our tests, however one particular conditional remained partially untested.

My initial reaction was straightforward since it was a logical branch that should reasonbly have coverage: "Let's write a test to cover this branch." However, as I began crafting the test, I encountered an unexpected challenge.

#### The Discovery

The validation method in question was a utility method designed to validate enum parameters:

```csharp
public static void ThrowIfInvalidEnum<T>(T value)
{
    ArgumentNullException.ThrowIfNull(value);

    if (!Enum.IsDefined(typeof(T), value))
    {
        throw new ArgumentOutOfRangeException($"{value} is not a valid {typeof(T)}");
    }

    if (value.Equals(default(T))) // <-- Incompletely covered block
    {
        throw new ArgumentOutOfRangeException($"{value} is not a valid {typeof(T)}");
    }
}
```

The uncovered branch was the check for whether the value equals the default value for the enum type. When I tried to write a test to cover this branch, I realized something important: the method had a logical flaw.

For many enum types in our codebase, the default value (typically 0) was a valid, defined value. For example:

```csharp
public enum TaskStatus
{
    Draft = 0,
    NotDone = 1,
    Done = 2,
    Skipped = 3,
    Cancelled = 4
}
```

In this case, `TaskStatus.Draft` is both a defined enum value AND equal to the default value of the enum (0) because it is the logical default state of the entity. The validation method would first check if the value is defined (it is), but then incorrectly throw an exception because it equals the default value.

This wasn't just a matter of incomplete test coverage—it was a functional bug that would reject valid enum values in certain cases.

#### The Hidden Danger

Without the pursuit of complete code coverage, this validation bug could have remained dormant in our codebase indefinitely. Consider what would have happened:

* **Selective Testing**: Our existing tests only verified enum values that weren't the default (0), which passed validation without issue. Without coverage metrics highlighting the untested branch, we had no reason to specifically test default enum values.

* **Intermittent Production Failures**: In production, any component using this validation method with enums where the default value was valid (like our `TaskStatus.Draft`) would experience seemingly random validation failures. These would only occur for the default value—a specific edge case that might represent a common state in our domain model.

* **Difficult Diagnosis**: The error message would indicate an invalid enum value, but inspection would show a perfectly valid enum value being rejected. This contradiction would make the issue particularly confusing to diagnose, especially since the value would pass the first validation check (`Enum.IsDefined`).

* **Inconsistent Behavior**: Most troubling, the bug would manifest inconsistently across different enum types. Enums where the default value wasn't explicitly defined would correctly fail validation, while enums with meaningful default values would incorrectly fail—creating a pattern that wouldn't immediately suggest a common root cause.

Without the coverage report highlighting this untested branch, we might only have discovered this issue after users encountered validation errors in production—potentially misinterpreting them as data corruption or user error rather than a flaw in our validation logic.

#### Two Birds, One Stone

I wrote tests that exposed the error by verifying both the acceptance of valid default values and the rejection of default values that should have been valid.

Once I had tests that were failing appropriately, I then updated the validation method to fix this logical issue:

```csharp
public static void ThrowIfInvalidEnum<T>(T value)
    where T : Enum
{
    ArgumentNullException.ThrowIfNull(value);

    // If the value is not defined in the enum it's invalid
    if (!Enum.IsDefined(typeof(T), value))
        throw new ArgumentOutOfRangeException($"{value} is not a valid {typeof(T)}");
}
```

This not only achieved 100% code coverage for the method but also fixed a bug that might have caused problems in production.

#### The Value of Complete Coverage

This experience highlights several important points about code coverage:

1. **Coverage as a Discovery Tool**: Pursuing complete coverage forces us to examine all code paths, which can reveal logical inconsistencies or gaps in our understanding of requirements.

2. **Uncovered Code Often Hides Bugs**: Code that remains untested is more likely to contain bugs. In this case, the uncovered branch contained a validation rule that was too restrictive.

3. **Quality Beyond Metrics**: While achieving 100% coverage was satisfying, the real value came from improving the correctness of our code and preventing potential user frustration.

4. **Test-Driven Refinement**: The process of writing tests to cover untested code often leads to refinements in the implementation, making the code more robust and aligned with actual requirements.

#### Conclusion

Code coverage shouldn't be pursued blindly as a metric, but it can serve as a valuable tool for discovering potential issues. In this case, the pursuit of complete coverage led to the discovery and correction of a bug that might have otherwise gone unnoticed until it affected users in production.

While 100% code coverage doesn't guarantee bug-free code, it does ensure that every line and branch has been executed at least once during testing. This basic level of verification can catch many issues early in the development process, especially subtle logic errors that might escape even careful code reviews.

The next time you see an uncovered branch in your code, don't just write a test to cover it—take a moment to question why it's uncovered. You might find, as I did, that there's more to the story than just missing test cases. The uncovered paths in your code may be hiding bugs that would be particularly difficult to diagnose in production environments.
