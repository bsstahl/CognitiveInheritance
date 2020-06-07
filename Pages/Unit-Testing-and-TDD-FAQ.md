---
tags: []
menuorder: 15
id: f4d1c45a-7853-461e-a3a7-1c4405a647fc
author: 
title: FAQ
description: Frequently asked questions about unit testing and Test-Driven Development (TDD).
ispublished: true
showinlist: true
publicationdate: 2010-01-01T00:00:00
lastmodificationdate: 0001-01-01T00:00:00
slug: Unit-Testing-and-TDD-FAQ
categories: []

---

The following are some questions that have been commonly asked of me regarding unit testing and TDD. Please submit questions or comments on this FAQ via [Twitter](https://twitter.com/intent/tweet?screen_name=bsstahl) or using the [Contact](../contact.html) page.

#### Q: What is the primary goal/benefit of unit testing?

A: Having solid unit tests allows the developers to refactor without fear. That is, they can much more easily maintain and extend the application. Since the majority of an application’s cost is in maintenance and extension, helping to reduce those costs can significantly impact the total cost of ownership (TCO) of an application.

* * *

#### Q: What does TDD give us that we can’t get by building tests “after the fact”?

A: I can think of five main advantages to doing test-driven development over “test-later”. Please let me know if you come up with others:

1. **To make sure the tests get done** – It is very easy to forget important business rules when building tests after the code has been written. TDD helps to guarantee that all of the important features have valid tests written for them.
2. **To help define the problem before solving it** – Stopping before building and defining the problem in terms of a test is very helpful for gaining insight into the problem. Often, I have eliminated what would have likely been some significant rework by building my tests first.
3. **To force “design for testability”** – One of the worst things about writing tests is having to go back and change working code because it isn’t testable. By doing the tests up-front, we guarantee that our code is testable before we even write it. In addition, since testable code is generally decoupled code, TDD helps to enforce a good standard that also helps reduce TCO.
4. **To help validate your tests** – When you follow the results of tests through from throwing a *NotImplementedException* to returning invalid results, to returning correct results, you have the most confidence that your test is doing what it is supposed to do.
5. **To help prevent scope creep** – It is often easy to creep the scope of a development effort by including features that are not currently required, because they seem easy when doing the development. If, however, you require yourself to build tests for each feature first, you are more likely to reconsider adding features that are not currently necessary.


* * *

#### Q: What part of my application do I NOT need to test?

A: This answer is quite simple: you don't need to test the parts of the application that your users DON'T care about.  Of course, since we [remove all code that our users don't care about](../Posts/Remove-Any-Code-Your-Users-Dont-Care-About.html) from our applications,  what we are really saying here is that we should be testing all of our application, and therefore approach 100% code coverage in our apps (although we should never be using code coverage as a metric, just as an indicator). On a fun note, the rule that you don't need to test the parts of your appliations that your user's don't care about was eponymously named "The Stahl Standard" by my friend, [Jeremy Clark](http://jeremybytes.blogspot.com/2015/02/unit-test-coverage-what-parts-of-your.html)

* * *

#### Q: What are some of the common pitfalls of TDD/Unit Testing?

A: Some of the pitfalls I have discovered over the years are listed below along with some suggestions for avoiding or overcoming them:

1. **Brittle tests** – It is easy to create tests that break when later functionality is added. Newer versions of mocking frameworks have helped with this problem by introducing mock types that demand that stated expectations are met on mocked dependencies, but don’t fail when additional interactions with those dependencies occur. As an example, in Rhino Mocks, you should use a DynamicMock object when it makes sense, rather than a StrictMock because the tests created with a DynamicMock are less brittle.
2. **Missed features** – I highly recommend creating a specific test for each feature, even if the test is an exact duplicate of another test. The reason for this is that, in the future, those features may evolve independently, and it is likely that the one test shared by both will be modified to fit the first feature that changes, leaving the second untested.
3. **DateTimes don’t validate well** – When comparing DateTime types, it is often difficult to get accurate results due to the rapid change in the current time and the varying degrees of precision of different time types. I have found it best to use a tolerance wherever possible in my DateTime testing. For example, I have created a custom Constraint for Rhino Mocks called a DateTimeConstraint that allows me to specify the tolerance that I will allow in my tests. That tolerance could be to the millisecond, the second, the minute, or whatever makes sense for that test.
4. **Type specific values don’t compare well** – An Int32 with a value of 12345 is not the same as an Int64 with the same value. Be careful when comparing data types, even if the value in those types should be the same. It is often best to cast or convert the value with the lesser precision, to the other type.
5. **Testing using shared resources is difficult** – While there is much discussion about what you call a test that touches the database, or another external resource such as a message queue, there is no doubt that interactions with those types of resources must still be tested. If the database or queue you are using is shared, it is possible that data can be manipulated during your tests, making these tests imprecise at best. Whenever possible, you should isolate these tests by using local resources if possible, or by creating the resources specifically for the test. That is, if in your test you create a message queue using a GUID defined in your test as the name of the queue, then use that for your tests and destroy the queue at the end of the test, you can be reasonably confident that no other user will be manipulating the data in that queue during the test.


* * *

#### Q: Should unit-tests touch the database or anything out-of-process?

A: In my opinion, yes. I realize that there are many who disagree with me on this point, but the fact remains that you cannot test an object which has a primary function of loading data from (or saving data to) a database without checking if it in fact, loads (or saves) said data correctly. The most important boundary not to cross in our unit tests is the one between application layers. Don't test the database logic with the business logic; each of these layers should be tested in isolation. For a more detailed explanation, see [Unit Testing the Data Tier](../Posts/Unit-Testing-the-Data-Tier.html) that I wrote years ago. While some of the technologies described have changed since that article, the fundamental idea has not.

* * *

#### Q: Should there be specific tests for logging in my application?

A: That depends on your business requirements. If there are specific, measurable business requirements for logging in your application, then yes, it should be tested. If not, as in the case of most applications, logging should probably be used simply for what it is, a diagnostic tool. I use logging to help me build my tests by redirecting my logging to the Test Context using a TestContext Logging Provider that I wrote, and which can be seen in the sample code for my [.NET TDD Kickstart](../Posts/Code-Sample-for-My-TDD-Kickstart-Sessions.html) session. This allows me to use my logging to help develop the system, gives me insight into how the logging will look when I actually use the system, and doesn't require me to make-up any fake "requirements" for logging. By the way, if anyone knows of any specific, testable requirements for logging other than, "...the system must log something…", please let me know.

* * *

#### Q: Do all unit test libraries have to be in every solution?

A: I don't believe so. I only bring the unit-test library for a project into a solution if I am modifying that project. Many times I am reusing existing libraries, such as a logging library, without modifying it. In that case, there is no need to include the unit-tests for the logging library in the solution. Since we should never be modifying any code without first creating a test for it, there should be no risk of ever accidentally modifying code for which we have not included the test library in the solution.

[Edit 2016-06]: Now that more and more of our dependencies are being handled using packages, we are having to include far fewer dependent projects in our solution.  This fact makes it more common to include all of the test libraries for the projects in every solution since, in most cases, we wouldn't have the project in a solution if we weren't going to modify it, we'd just include the dependency using a package.

* * *

#### Q: Do I need to have a reusable interface on all of my objects?

A: All objects where public functionality is exposed (objects that perform a public service) should implement a reusable interface. If the object exposes public methods, and those methods really should be public, that interface should be reusable so that tests can be mocked against the service provider. If you don't feel like the methods belong on a reusable interface, you might want to revisit making them public in the first place.

One example of where not putting a reusable interface on a public object has hurt us is the Thread object in the System.Threading namespace. The Sleep method can be viewed as a delay provider. Had a reusable interface been implemented that included this method, it would have simplified testing in many situations where a timed delay is needed. Instead of simply testing the call to the Sleep method on the reusable interface, we have to wrap that method into a separate delay provider that exposes a reusable interface, to do our testing. This moves the testing of the actual delay functionality to us, rather than to Microsoft (the code provider) where it belongs. If Microsoft had provided this interface, it would leave us free to simply verify that we properly call the delay provider.

Note: Remember, all .NET CLR objects expose an interface, but not all of them make that interface reusable.

* * *

#### Q: Whenever I change anything in my code I break my tests. Is there a way to make my unit tests less brittle?

A: Writing black-box style tests can help to reduce the brittleness of unit tests. Since there is no need for the test to have     any awareness of the structure or implementation of the code when black-box testing, the tests are less likely to break when     a change to the code structure or implementation is made.

There are some abstraction patterns that I find particularly helpful in building code that is testable using black-box methods.     The *Repository* pattern is a great way to abstract a data store from its implementation. Likewise, the *Strategy* pattern is an equivalent abstraction for algorithms.  When combined with a *Service Locator* methodology such as *Dependency Injection*,     these patterns can allow more of the testing to be done without knowledge of anything but the interfaces of the object under test.

It should be noted that not all testing can be done with black box methods. There are some use-cases which require knowledge of the      implementation to validate the test.  Data storage and retrieval is one such situation.  In these cases it is important to do as much     of the testing as possible using abstractions and then only validate the implementation using white-box testing as close to the metal     of the implementation as possible.

* * *

#### Q: In one of your talks, you showed some demo code with helper extension methods that made testing a lot easier, can I have access to that code?

A: The TestHelperExtensions have been released as a Free, Open-Source tool on      [NuGet](https://www.nuget.org/packages/TestHelperExtensions) and      [GitHub](https://github.com/bsstahl/TestHelperExtensions).      Documentation for its use can be found [here](http://testhelperextensions.cognitiveinheritance.com).

