---
tags:
- agile
- coding practices
- professional development
- tdd
- testing
- unit testing
menuorder: 0
id: dade0093-4e08-4576-9ea3-b9fc326d6a81
author: bsstahl
title: Test-Driven Bug Fixes
description: 
ispublished: true
showinlist: false
publicationdate: 2016-02-27T10:44:33
lastmodificationdate: 2016-02-27T10:45:42
slug: Test-Driven-Bug-Fixes
categories:
- Development

---

I had an experience this past week that reminded me of both the importance of continuing the Test Driven Development process beyond the initial development phases of a application's life-cycle, and that not all developers have yet fully grasped the concepts behind Test Driven Development.

One of the development teams I work with had a bug come-up in a bit of complex logic that I designed. I was asked to pair-up with one of the developers to help figure out the bug since he had already spent several hours looking at it. When I asked him to show me the tests that were failing, there weren't any. The bug was for a situation that we hadn't anticipated during initial development (a common occurrence) and he had not yet setup any tests that exposed the bug.

We immediately set out to rectify the situation by creating tests that failed as a result of the bug. Once these tests were created, it was a fairly simple process to use those tests as a debug platform to step through the code, find the problem and correct the bug. As is sometimes the case, fixing that bug caused another test to fail, a situation that was easily remedied since we knew about it due to the failing test.

After the code was complete and checked-in for build, the developer I was working with remarked on how he now "got it". He had heard the words before, "…write a test to expose the bug, then fix the bug." but they were empty words until he actually experienced using a test to do the debugging, and then saw existing tests prevent a regression failure in other code due to our bug fix. It is an experience all TDD practitioners have at some point and it is easy to forget that others may not yet have grokked the concepts behind the process.

Coincidentally, that very night, I got a ping from my friend Jeremy Clark ([blog](https://jeremybytes.blogspot.com), [twitter](https://twitter.com/jeremybytes)) asking for comments on his latest [YouTube video on TDD](https://youtu.be/l4xhTq4qmC0). After watching it, I really couldn't offer any constructive criticism for him because there was absolutely nothing to criticize. As an introduction to the basics of TDD, I don't think it could have been done any better. If you are just getting started with TDD, or want to get started with TDD, or want a refresher on the basics of TDD, you need to watch this video.

Jeremy has indicated he will be doing more in this series in the future, delving deeper into the topic of TDD. Perhaps he will include an example of fixing a bug in existing code in a future video.
