---
tags:
- testing
- database
- architecture
menuorder: 0
id: 7ca6c1bf-2566-434d-8382-33680f1b0d70
author: bsstahl
title: Unit Testing the Data Tier
description: 
ispublished: true
showinlist: false
publicationdate: 2007-08-23T12:33:00.000+00:00
lastmodificationdate: 2010-10-22T18:11:27.000+00:00
slug: Unit-Testing-the-Data-Tier
categories:
- Development

---
Recently, both [Jeffrey Polermo](https://web.archive.org/web/20130906034419/http://codebetter.com/jefferypalermo/2007/06/29/levels-of-automated-testing-within-a-single-application/) and [Scott Bellware](https://web.archive.org/web/20130906034419/http://codebetter.com/jefferypalermo/2007/06/29/levels-of-automated-testing-within-a-single-application/) have written posts on [codebetter.com](http://www.codebetter.com/) positing that testing the Database should be avoided when doing unit testing. Specifically, Polermo points out that

> Unit testing, by common definition, excludes external dependencies. It's not a unit test if we reach out and touch things.

While this may be a nice ideal, in reality it simply does not turn out to be the best way to do things in the majority of situations. Of course, to be fair, every situation is different and I'm sure there are many circumstances where it is better to pull-out database testing into integration tests or similar. In fact, there are perfectly valid reasons why we might not want to call it a unit-test if we test the database. However, for the majority of software projects (i.e. the 80% use-case), I belive it is not only legitimate, but best-practice, to test the database with our unit tests.

To understand the primary reasoning here, we need to go back to the fundamentals and look at our logical view of this 80% use-case software system.

![Logical View of a Typical 3-Tiered Software System]({PathToRoot}/Images/SoftwareSystemLogicalView_small.png)

The drawing illustrates many of the systems we create today in .NET. Of course, not all systems will fit into this model, but it certainly represents the classic 3-tier architecture used by so many of our projects. As this drawing shows, our data-access objects, which are often just thin wrappers over stored procedures, perhaps containing some ORM logic, are really part of the data-services layer. Even though these objects may physically reside alongside the business-layer objects, they really belong to the data-services. Thus, the assertion that we cross boundaries by testing the database when we test the data-services "unit" is not, in my mind, a valid concern. Yes, the tests will make out-of-process calls in getting to the database, and we will suffer a performance penalty as a result, but the fact remains that the database is not a dependency of the data-access objects, it is an integral part of that layer. Thus, in order to test that layer, we must test the database.

From a practical standpoint, this view of the application works out best in terms of testing it since the data-access objects are generally so thin. What is the point of testing those objects in isolation since they are basically wrappers most of the time? It is sometimes appropriate to write some tests for these objects on their own if they contain ORM type logic that can be tested as a unit, but for the most part, when we test the data-layer, what we want to test is that the proper data is returned. Validating that the proper data is returned from the data-tier requires testing the entire layer, including the database. Another factor here is that the database itself cannot generally be tested without some form of .NET object interface. As an example, if we were to try and write a unit test for a stored procedure in nUnit or VS Team System, we would need to have the same data-access code in our test, as we have in our data-tier object. Thus, it only makes sense to test those items as one unit. Perhaps down the road, since SQL server now has its own CLR, we may be able to do more testing of the database objects at that level and not need data-access objects. When that occurs, we should definately revisit our best-practices. But for now it is clear that the best way to test data-access is to test the data-services layer as a unit.

Please do not think that in any way I am suggesting we need to test the database in the same tests that are used for the business-layer objects. That would be a clear violation of the separation-of-concerns discussed by both Polermo and Bellware as well as many others and would best be described as an integration test because it crosses the boundaries in the diagram above. We should definately isolate the layers of our applications from each other in order to accurately test them. What I am saying is that the isolation of the data-tier should occur between the business-tier and the data-tier on the diagram. Thus, testing of the data-access objects includes testing of the database objects. The question then really becomes, how do we unit-test the data-services layer so that the tests execute as quickly as possible, do not have dependancies on existing data so that changes to the data cause tests to fail, yet still accurately and completely test that unit. I am attempting to put together a list of best-practices in this area and will make that the subject of a future post.