---
tags:
- agile
- community
- development
- framework
- open source
- tdd
- testing
- unit testing
- using
- visual studio
menuorder: 0
id: 69eed32b-9eeb-43df-908d-29b3eae4a395
author: bsstahl
title: Introducing TestHelperExtensions
description: 
ispublished: true
showinlist: false
publicationdate: 2015-08-26T07:24:55
lastmodificationdate: 2015-08-26T07:24:55
slug: Introducing-TestHelperExtensions
categories:
- Development

---

## TL;DR Version

I've released a new Open-Source library of extension methods that can be used to create more effective unit and integration tests. This library is called TestHelperExtensions. The source code is available on [GitHub](http://github.com/bsstahl/testhelperextensions) (pull requests welcome), a .NET 4 package is available via [NuGet](http://www.nuget.org/packages/TestHelperExtensions/), and the documentation is available [here](http://testhelperextensions.cognitiveinheritance.com). The goal is to allow anyone to have access to the same set of test helpers I have been using, and building up, for many years.

## The Story

I have been giving Test Driven Development (TDD) sessions at code camps and conferences for a number of years. During those sessions, I spend a lot of time in code, building up a test suite for a production application, and demonstrating the process I use for TDD. Part of this process is using a set of extension methods to perform common tasks, such as generating test data, and doing comparisons of DateTime values. Many people have asked for access to this library during these sessions and my answer has always been the same, "you can grab it from the sample code". Now, I've decided to make it easier for anyone to include it in their projects via NuGet, and to allow the community the opportunity to extend and modify the library on GitHub.

## Going Forward

I still have a small backlog of features I'd like to add to this tool. After that, It's up to you what happens with it. If you have a feature suggestion, please let me know. [Twitter](http://twitter.com/bsstahl) is the best place to start a conversation about this, or any development topic with me. You can also create an [issue on GitHub](https://github.com/bsstahl/TestHelperExtensions/issues), or simply submit a pull request. I'd love to hear how you are using this library, and anything that can be done to make it more effective for you.

