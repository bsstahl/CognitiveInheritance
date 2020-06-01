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
publicationdate: 2006-10-07T05:42:00.000+00:00
lastmodificationdate: 0001-01-03T00:00:00.000+00:00
slug: nUnit-vs-VSTS
categories:
- Development

---
Mark Michaelis posted a hit list of things to do to convert from nUnit to VSTS tests in his article [Converting a class library to a VSTS Test Project](https://web.archive.org/web/20080708110723/http://mark.michaelis.net:80/Blog/ConvertingAClassLibraryToAVSTSTestProject.aspx). A big part of this process is understanding the attribute translation:

| nUnit | VSTS |
| --- | --- |
| TestFixture | TestClass |
| TestFixtureSetUp | ClassInitialize |
| TestFixtureTearDown | ClassCleanup |
| SetUp | TestInitialize |
| TearDown | TestCleanup |
| Test | TestMethod |