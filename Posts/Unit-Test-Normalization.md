---
tags:
- tdd
- testing
- assert
menuorder: 0
id: e203ddde-e61f-4d1d-bf55-9749f9e8c3c6
author: bsstahl
title: Unit Test "Normalization"
description: 
ispublished: true
showinlist: false
publicationdate: 2007-07-07T08:03:00
lastmodificationdate: 2010-10-22T18:11:36
slug: Unit-Test-Normalization
categories:
- Development

---

In a recent conversation about Unit Tests, I was asked about how many asserts I would put into a single test, since some feel that there should only be one Assert per test. My answer was, that I look at it like database normalization with the test name serving as the primary key; that is, the asserts in the test should relate directly and only to that key. This analogy is also appropriate because DB normalization is a good thing within reason, but can definately be overdone. Unit test "normalization" can also be overdone if we try to break-out each assert into its own test.

An example of where multiple asserts might be put into one test is a test of the Add method of a collection object which inherits from System.Collection.CollectionBase. When an item is added, it is appropriate to test for the proper index of that item to be returned from the method, as well as to test that the collection is holding the correct number of items after the Add is done. Both tests relate directly to the Add method. An argument could be made that the count of items relates to the Count property of the collection and therefore that assert doesn't relate only to the Add method, but since we are usually not coding the count property (because it was coded for us in CollectionBase), we don't need to test the Count property on its own, and it should be tested as part of the Add test.

