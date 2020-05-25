---
tags:
- tdd
- testing
- nunit
- mstest
menuorder: 0
id: 9e81f613-52ca-4108-acb4-f0f2ad3d36dc
author: bsstahl
title: nUnit vs. VSTS
description: 
ispublished: true
showinlist: false
publicationdate: 2006-10-07T05:42:00
lastmodificationdate: 0001-01-03T00:00:00
slug: nUnit-vs-VSTS
categoryids:
- categoryid: da73f25e-343d-4a0e-9b28-1d76e8fd99bf

---

Mark Michaelis posted a hitlist of things to do to convert from nUnit to VSTS tests in his article [Converting a class library to a VSTS Test Project](http://mark.michaelis.net/Blog/ConvertingAClassLibraryToAVSTSTestProject.aspx). A big part of this process is understanding the attribute translation:
  




| nUnit | VSTS |
| --- | --- |
| [TestFixture] | [TestClass] |
| [TestFixtureSetUp] | [ClassInitialize] |
| [TestFixtureTearDown] | [ClassCleanup] |
| [SetUp] | [TestInitialize] |
| [TearDown] | [TestCleanup] |
| [Test] | [TestMethod] |


