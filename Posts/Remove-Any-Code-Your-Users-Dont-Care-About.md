---
tags:
- code coverage
- testing
- tdd
- unit testing
- yagni
- agile
menuorder: 0
id: 496f2d62-3c89-46fc-b04d-5cf5f81fa82d
author: bsstahl
title: Remove Any Code Your Users Don't Care About
description: 
ispublished: true
showinlist: false
publicationdate: 2015-09-28T18:01:02.000+00:00
lastmodificationdate: 2015-09-29T08:33:20.000+00:00
slug: Remove-Any-Code-Your-Users-Dont-Care-About
categories:
- Development

---
Code Coverage has been the topic of a number of conversations lately, most recently after the last [Southeast Valley .NET User Group](http://www.meetup.com/sevdnug/events/223863304/) meeting where [Jeremy Clark](http://www.twitter.com/jeremybytes) presented his great talk, [Unit Testing Makes Me Faster](http://jeremybytes.com/Demos.aspx#UTMMF).  During this presentation, Jeremy eponymized, on my behalf, something I've been saying for a while, that [the part of an application that you don't need to test is the part that your users don't care about](http://jeremybytes.blogspot.com/2015/02/unit-test-coverage-what-parts-of-your.html). That is, if your users care about something in your application, you should be writing tests that ensure that the users' needs are fulfilled by your code. This has never really been a controversial statement, just one that sometimes gets lost in the myriad of information about unit testing and test driven development.

Where the conversation got really interesting was when we started discussing what should happen if you decide that a piece of code really isn't important to your users.  It is my assertion that code which is deemed unimportant enough to the user that it might not be tested, should be removed from the project, even if is part of a standard implementation.  I will attempt to justify this assertion by using the example of a property implementation that supports the *INotifyPropertyChanged* interface.
 
![Code Coverage Results -- Standard Property Implementation]({PathToRoot}/Images/CodeCoverageDemoProperty_2.png)

**A visualization of the results of Code Coverage analysis on a typical property implementation. The blue highlights represent code that is covered by tests, the red highlights represent code that is NOT covered by tests.**

In this example, we have a property getter and setter. The getter simply returns the value stored in the internal member. However the setter holds some actual logic.  In this case, the new value being set is compared to the current value of the property.  If the property value is changing, the update is made and a method called that fires a notification event indicating that the value of the property has changed.  This is a fairly common implementation, especially for View-Model layer code.

**Decision: Do my users care about this feature?**

The conditional in this code is designed to skip the assignment and the change notification if the property value is not really changing.  If we were to eliminate the conditional, it would impact the users of this code in the following ways?

1. A few CPU cycles may be wasted on an assignment that isn't doing anything
2. An event indicating the property was changed would fire incorrectly


In the vast majority of cases, the performance hit from item 1 is trivial and can be ignored.  Item 2 however is a bit more complicated.  Unless I know for certain that firing the event when the property is not really changing isn't a problem, I have to assume it is a problem, since there are any number of things that could happen as a result of having an event fire.  Often, when this event fires it will cause a refresh of the bound data to the UI elements.  This may have a significant impact on performance, or it may not.  There may also be additional actions taken by the programmers of this event client that may not be foreseeable when designing this layer.  If the circumstances are such that I know there will be no problems if the event fires more often than it should, then I can probably conclude that my users don't care about this code.  In all other circumstances, I should probably conclude that they do.

**Decision: Should I remove this code?**

If I have concluded that my users care about the code, then my path is clear, I should leave the code in place and write tests to make sure that *the event fires when it should, and only when it should*.  However, if I have concluded that my users don't care about this particular code, then I have another decision to make.  I need to decide if I should leave the code untested but in place, remove the code from my project, or leave it in and write tests for it anyway.

If the feature is not important to the users and there is no likelihood that the feature will become important to the users in the future, then the code should not be there. Period.  We cannot waste time and effort supporting code that our users will not need. Scope-creep is a real danger to any project and should be avoided at all costs, even on the small stuff.  Lots of small stuff adds up to big stuff, especially over the lifespan of any non-trivial application.

So, if the features are important to the users, we test them, if they are unimportant to the users, we remove them. No controversy here. The questions come in when there is a likelihood that the feature could become important in the future, or if the feature is important to someone other than the users, such as the developers.

Suppose we decide that the users are likely to request this feature in the future.  Wouldn't it be easier just to implement the feature now, when we are already in the code and familiar with it?  My answer to this is to fall back on **YAGNI**. *You Ain't Gonna Need It*, has proven itself a valuable principal for preventing scope-creep. Even if you think it is pretty likely that you'll need something later, the reality is that you probably won’t. Based on this principal, we should not be putting features into our projects that are not needed right now.

But what about the situation where code is important to someone other than the users, for example, the developers?  In this case, we have to decide if the code really is important, or is it just another case where the YAGNI principal should be applied.  Technical requirements can be legitimate, but any requirement that is not directly in support of the user's needs is a smell that should be investigated.  In the case of our property setter, saying that standardization is important and using that logic to make standardization a requirement sounds a lot like saying "I think this feature may be important someday" and it probably falls to YAGNI to keep it out of our code.  That being said, if there is a technical requirement that is truly needed, it should be tested like any other important requirement. For a little more information on this, see my earlier analysis [Conflict of Interest: Yagni vs. Standardization]({PathToRoot}/Posts/Conflict-of-Interest-YAGNI-vs-Standardization.html).

**How About we Leave It and Just Don't Test It?**

It is important to remember that we shouldn't simply leave code untested in our production code, even if the users don't really care about it right now. If we do so, and the feature becomes important in the future, we will almost certainly end up with code that is important to our users, but is untested and therefore at-risk.  We are unlikely to go back into an application and just add tests for a feature that already exists simply because that feature is now important when it wasn't earlier.  We'd like to think we would, but the fact is that we won't. No, leaving the code in the application, but untested, is not an option.

**The Case for 100% Code Coverage**

So, we want to remove any code that is not currently required by our users, and test all code that is truly needed. If you have come along with me on this you may now realize that **100% code coverage is actually a reasonable goal**, since that would be the result of removing all unneeded code and testing all needed code.  This is not to say that it is reasonable to use Code Coverage as a metric with which to judge a development team, but instead it should be considered as a tool that can help identify scope-creep and missing tests.  Since we are testing all code that our users care about, and not adding any code that the users don't care about, we should expect to approach 100% code coverage in order to have a good chance of producing well-tested, maintainable code that gives us the flexibility and confidence to refactor ruthlessly.

Code Coverage sometimes gets a bad reputation because it can be easy to game. That is, it is not a good metric of success for a development team. However, it is a *magnificent*tool to help you identify places where tests are missing.  It won't tell you where your tests are not doing what they need to do, but it will tell you when you have a piece of code that is not exercised by any tests. If you are a TDD (Test-Driven-Development) practitioner, as I am, Code Coverage will tell you when you’ve gotten ahead of yourself and written code before writing a test for it.  This is especially valuable for those who are just learning TDD, but never loses its value no matter how experienced you are at TDD.

**Continue the Conversation**

How do you feel about this logic? Did I miss something critical in this analysis? Have you found something different in your experience? Let's keep this conversation going on Twitter. Tweet me [@bsstahl](http://www.twitter.com/bsstahl) with your comments, or post on your blog and tweet me the link.