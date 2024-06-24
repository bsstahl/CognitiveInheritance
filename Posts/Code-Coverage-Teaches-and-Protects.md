---
tags:
- abstraction
- agile
- assert
- code analysis
- code coverage
- coding-practices
- csharp
- ioc
- testing
- unit testing
- dotnet
menuorder: 0
id: 68269657-e0c9-430d-acd4-9b4cc211fcc7
author: bsstahl
title: Code Coverage Teaches and Protects
description: 
ispublished: true
showinlist: false
publicationdate: 2016-10-14T18:56:54.000+00:00
lastmodificationdate: 2016-10-15T12:18:08.000+00:00
slug: Code-Coverage-Teaches-and-Protects
categories:
- Development

---
I often hail code coverage as a great tool to help improve your code base.  Today, my use of Code Coverage taught me something about the new .NET Core tooling, and helped protect me from having to support useless code for the lifespan of my project.

In the code below, I used a common dependency injection pattern. That is, an IServiceProvider object holding my dependencies is passed-in to my object and stored as a member variable.  When a dependency is needed, I retrieve that dependency from the service provider, and then take action on it.  Since there is no guarantee that the dependency I need will have been placed in the container, I use some common guard logic to protect my code.

```csharp
templates = _serviceProvider.GetService<IEnumerable<Template>>();
if ((templates==null) || (!templates.Any(s => s.TemplateType==ContactPage)))
     throw new TemplateNotFoundException(TemplateType.ContactPage, string.Empty);
```

In this code, I first test that I was able to retrieve a collection of Template objects from the service provider, then verify that the type of Template I need is present in the collection.  If either is not the case, an exception is thrown.

I had two tests that covered this section of code, one where the collection was not added to the service provider, the other where an empty collection was added.  Both tests passed, however, it wasn't until I looked at the results of the Code Coverage that I realized that the 1st test wasn't doing what I thought it was doing.  It turns out that there is actually no way to get a null collection object out of the Microsoft.Extensions.DependencyInjection.ServiceProvider object I am using for my .NET Core apps. That provider simply returns an empty collection if there isn't one in the container.  Thus, my check for null was never matched and that branch of code was never executed.

Based on this new knowledge of the behavior of the IServiceProvider, I had a few options.  I could:

1. Rewrite my test to check for an empty collection.  This option seems redundant to me since my check to see if the container holds the template I need is really what I care about.
2. Leave the code as-is just in case the behavior of the container changes, accepting that I have what is currently unnecessary and untestable code in my application.  I considered this option but it seems to me that a better defense against the unlikely event of a breaking change in the IServiceProvider implementation is described below in option 3.
3. Create a new test that verifies the behavior on the ServiceProvider that an empty collection is returned if no collection is supplied to the container.  I am not a big fan of this option since it requires me to test OPC (other people's code), and because the risk of this type of breaking change is, in my opinion, extremely low.
4. Remove the guard code that tests for null and the test that supports it.  Since the code is completely unnecessary, the test itself is redundant because it is, essentially identical to the test verifying that the template I need is in the collection.

I'm sure you've guessed by now that I selected option 4.  I removed the guard code and the test from my solution.  In doing so, I removed dead code that served no purpose, but would have to be supported through the life of the project.  

For those who might be thinking something similar to, "It's nice that the coverage tooling helped you learn about your code, but using Code Coverage as a metric is actually a bad idea so I won't use Code Coverage at all", I'd like to remind you that any tool, such as a hammer or a car, can be abused. That doesn't mean we don't continue to use them, we just make certain that we use them properly.  Code Coverage is a horrible way to measure a development team or effort, but it is an outstanding tool and should be used by the development team whenever possible to discover things about the code base.
