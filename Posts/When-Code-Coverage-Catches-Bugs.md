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

During a routine review of our code coverage reports, I noticed an uncovered branch in a validation method. This method was responsible for validating input parameters before they were processed by our business logic. The coverage report showed that while most of the method was covered by our tests, one particular conditional branch remained untested.

My initial reaction was straightforward: "Let's write a test to cover this branch and get to 100% coverage." However, as I began crafting the test, I encountered an unexpected challenge.

#### The Discovery

The validation method looked something like this:

```csharp
public bool IsValid(string input)
{
    if (string.IsNullOrEmpty(input))
        return false;
    
    if (input.Length < 3 || input.Length > 50)
        return false;
    
    // The uncovered branch
    if (!input.All(c => char.IsLetterOrDigit(c) || c == '-' || c == '_'))
        return false;
    
    return true;
}
```

The uncovered branch was checking if all characters in the input were either alphanumeric, hyphens, or underscores. When I tried to write a test that would trigger this branch (by providing an input with invalid characters), I realized something important: our application actually needed to accept certain special characters that weren't included in the validation.

In our domain context, inputs like "Customer.Profile" or "Order#123" were perfectly valid and expected, but the validation method would reject them. This wasn't just a matter of incomplete test coverage—it was a functional bug that could potentially reject valid user inputs.

#### Two Birds, One Stone

I updated the validation method to include the additional valid characters:

```csharp
public bool IsValid(string input)
{
    if (string.IsNullOrEmpty(input))
        return false;
    
    if (input.Length < 3 || input.Length > 50)
        return false;
    
    // Updated to include additional valid characters
    if (!input.All(c => char.IsLetterOrDigit(c) || c == '-' || c == '_' || c == '.' || c == '#'))
        return false;
    
    return true;
}
```

Then I wrote tests that verified both the acceptance of valid special characters and the rejection of truly invalid ones. This not only achieved 100% code coverage for the method but also fixed a bug that might have caused problems in production.

#### The Value of Complete Coverage

This experience highlights several important points about code coverage:

1. **Coverage as a Discovery Tool**: Pursuing complete coverage forces us to examine all code paths, which can reveal logical inconsistencies or gaps in our understanding of requirements.

2. **Uncovered Code Often Hides Bugs**: Code that remains untested is more likely to contain bugs. In this case, the uncovered branch contained a validation rule that was too restrictive.

3. **Quality Beyond Metrics**: While achieving 100% coverage was satisfying, the real value came from improving the correctness of our code and preventing potential user frustration.

4. **Test-Driven Refinement**: The process of writing tests to cover untested code often leads to refinements in the implementation, making the code more robust and aligned with actual requirements.

#### Conclusion

Code coverage shouldn't be pursued blindly as a metric, but it can serve as a valuable tool for discovering potential issues. In this case, the pursuit of complete coverage led to the discovery and correction of a bug that might have otherwise gone unnoticed until it affected users in production.

While 100% code coverage doesn't guarantee bug-free code, it does ensure that every line and branch has been executed at least once during testing. This basic level of verification can catch many issues early in the development process.

The next time you see an uncovered branch in your code, don't just write a test to cover it—take a moment to question why it's uncovered. You might find, as I did, that there's more to the story than just missing test cases.
