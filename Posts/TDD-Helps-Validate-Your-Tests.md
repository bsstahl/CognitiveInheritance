---
tags:
- code analysis
- code coverage
- coding practices
- tdd
- testing
- unit testing
menuorder: 0
id: 7de3f401-e11b-4170-b1fe-d3b3f71c303d
author: bsstahl
title: TDD Helps Validate Your Tests
description: 
ispublished: true
showinlist: false
publicationdate: 2016-03-05T12:55:28
lastmodificationdate: 2016-03-05T12:55:28
slug: TDD-Helps-Validate-Your-Tests
categoryids:
- da73f25e-343d-4a0e-9b28-1d76e8fd99bf

---

One of the reasons to use TDD over test-later approaches is that you get a better validation of your tests.

When the first thing you do with a test or series of tests is to run them against code that does nothing but throw a *NotImplementedException*, you know exactly what to expect. That is, all tests should fail because the code under test threw a *NotImplementedException*. After that, you can take iterative steps to implement the code. Along the way, you should always see your tests fail in appropriate ways.  Eventually, all of your tests should pass when the code is complete.

If tests start passing before they should, continue to fail when they shouldn’t, or fail for reasons that are different than what you’d expect at that point in the development process, you have a good indication that the test may not be doing what you want it to be doing.  This additional information about the tests can be very helpful in making sure your unit tests are properly testing your code.

Think about what happens when you add tests after the code has already been written.  Suppose you write a test for existing code, and it passes.  What do you really know about the test?  Is it working because it is adequately exercising your code? Did you forget to do an assert? Is it even testing the  proper bit of code? Code coverage tools can help with some of this but they can only help if the code under test is not already touched by other tests.  Stepping through the code in debug mode is another possibility, a third option is to comment out the code as if you were starting from scratch, effectively doing a TDD process without any of the other [benefits of TDD](http://www.cognitiveinheritance.com/page/Unit-Testing-and-TDD-FAQ.aspx).

What about when you write a test for previously written code, and the test fails?  At this point, there are 2 possibilities:

1. The code-under-test is broken
2. The test is broken


You now have 2 variables in the equation, the code and the test, when you could have had only 1.  To eliminate 1 of the variables, you have to again perform the TDD process without most of its benefits by commenting out the code and starting from ground zero.

Following a good TDD process is the best way to be confident that any test failures indicate problems in the code being tested, instead of the tests themselves.

