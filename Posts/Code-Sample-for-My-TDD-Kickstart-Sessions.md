---
tags:
- abstraction
- agile
- assert
- code camp
- coding practices
- community
- conference
- csharp
- development
- di
- event
- framework
- ioc
- tdd
- testing
- unit testing
- visual studio
menuorder: 0
id: 36949ad5-1066-4686-81b2-ce7e5c4d8bcc
author: bsstahl
title: Code Sample for My TDD Kickstart Sessions
description: 
ispublished: true
showinlist: false
publicationdate: 2012-02-13T13:25:00
lastmodificationdate: 2012-02-13T17:16:08
slug: Code-Sample-for-My-TDD-Kickstart-Sessions
categoryids:
- da73f25e-343d-4a0e-9b28-1d76e8fd99bf

---

The complete, working application for my [.NET TDD Kickstart](/post/NET-TDD-Kickstart.aspx) sessions can be found [here](http://docs.cognitiveinheritance.com/tddkickstart.zip).

Unzip the files into a solution folder and open the **Demo.sln** solution in a version of Visual Studio 2010 that has Unit Testing capability (Professional, Premium or Ultimate).  Immediately, you should be able to compile the whole solution, and successfully execute the tests in the **Bss.QueueMonitor.Test** and **Bss.Timing.Test** libraries.

To get the tests in the other two test libraries (**Bss.QueueMonitor.Data.EF.Test** & **Bss.QueueMonitor.IntegrationTest**) to pass, you will need to create the database used to store the monitored data in the data-tier and integration tests, and enable MSMQ on your system so that a queue to be monitored can be created for the Integration test.

The solution is configured to use a SQLExpress database called **TDDDemo**.  You can use any name or SQL implementation you like, you’ll just need to update the configuration of all of the test libraries to use the new connection.  The script to execute in the new database to create the table needed to run the tests can be found in the Bss.QueueMonitor.Data.EF library and is called **QueueDepthModel.edmx.sql**.

You can install Message Queuing on computers running Windows 7 by using **Programs and Features** in the **Control Panel**.  You do not need to create any specific queue because the integration test creates a queue for each test individually, then deletes the queue when the test is complete.

If you have any questions or comments about this sample, please start a conversation on [Twitter](http://twitter.com/bsstahl) or [Contact Me](/Contact.aspx).

