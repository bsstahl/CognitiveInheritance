---
tags:
- testing
- code coverage
- development
- di
- ioc
- microsoft
- xunit
- moq
- mocks
- professional development
- tdd
- unit testing
- visual studio
- dotnet
menuorder: 0
id: 8d08d120-ece8-47d2-b6be-0bd5416d5c90
author: bsstahl
title: Testing a .NET Core Library in VS2015
description: 
ispublished: true
showinlist: false
publicationdate: 2017-01-09T19:32:03.000+00:00
lastmodificationdate: 2017-01-09T19:32:03.000+00:00
slug: Testing-a-NET-Core-Library-in-VS2015
categories:
- Development

---
I really enjoy working with .NET Core.  I like the fact that my code is portable to many platforms and that the footprint is so much smaller than with traditional .NET applications.  Unfortunately, the tooling has not quite reached the level that we expect from a Microsoft finished product (which it isn’t – yet). As a result, there are some additional actions we need to take when setting up our solutions in Visual Studio 2015 to allow us to unit test our code properly.  The following are the steps that I currently take to setup and test a .NET Core library using XUnit and Moq.  I know that a number of these steps will be done for us, or at least made much easier, by the tooling in the coming months, either by Visual Studio 2017, or by enhancements to the Visual Studio 2015 environments.

1. Create the library to be tested in Visual Studio 2015
    1. File &gt; New Project &gt; .Net Core &gt; Class Library
    2. Notice that this project is created in a solution folder called ‘src’
2. Create a solution folder named ‘test’ to hold our test projects
    1. Right-click on the Solution &gt; Add &gt; New Solution Folder
3. Add a new console application to the test folder as our test project
    1. Right-click on the ‘test’ folder &gt; Add &gt; New Project &gt; .Net Core &gt; Console Application
4. Add a reference to the library being tested in the test project
    1. Right-click on the test project &gt; Add &gt; Reference &gt; Select the library to be tested
5. Install packages needed for unit testing from NuGet to the test project
    1. Right-click on the test project &gt; Manage NuGet Packages &gt; Browse
    2. Install ‘xunit’ as our unit test runner
        1. The current version for .Net Core is ‘2.2.0-beta4-build3444’
    3. Install ‘dotnet-test-xunit’ to integrate xunit with the Visual Studio test tools
        1. The current version for .Net Core is ‘2.2.0-preview2-build1029’
    4. Install ‘Moq’ as our mocking library
        1. The current version for .Net Core is ‘4.6.38-alpha’
6. Edit the project.json of the test library
    1. Change the “EmitEntryPoint” option to false
    2. Add “testrunner” : “xunit” node


Some other optional steps include:

- Install the ‘Microsoft.CodeCoverage’ package from NuGet to enable the code coverage tooling
- Install the ‘Microsoft.Extension.DependencyInjection’ package from NuGet to enable DI
- Install the ‘TestHelperExtensions’ package from NuGet to add extensions that assist with writing good unit tests
- Add any additional runtimes that might be needed. Some options are:
    - win10-x86
    - win10-x64
    - win7-x86
    - win7-x64
- Set ‘Run tests after build’ in Visual Studio so tests run automatically


There will likely be better ways to do many of these things shortly, but if you know a better way now, please let me know {TwitterLink}.
