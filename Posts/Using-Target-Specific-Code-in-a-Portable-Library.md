---
tags:
- .net
- abstraction
- di
- portable
- pcl
- device
- phone
- win8
- wp8
menuorder: 0
id: bd40aaeb-c0af-43e4-badb-6b95327f8e9e
author: bsstahl
title: Using Target-Specific Code in a Portable Library
description: 
ispublished: true
showinlist: false
publicationdate: 2013-06-27T16:05:00
lastmodificationdate: 2013-06-27T16:51:31
slug: Using-Target-Specific-Code-in-a-Portable-Library
categoryids:
- da73f25e-343d-4a0e-9b28-1d76e8fd99bf

---

On at least 2 occasions recently, I have heard speakers tell their audience that you cannot reference a target-specific .NET library (such as a .NET Framework 4.5 library) from a Portable Class Library.  While this is technically true, it doesn't tell nearly the whole story.  Even though we can't reference target-specific libraries, we can still USE these libraries. We can call their methods and access their properties under the right circumstances. We can gain access to these libraries via an abstraction.  My preferred method of doing this is known as Dependency Injection.

I'm going to give some quick background on PCLs and DI before getting into the details of how they can be used in this context. If you are familiar with Dependency Injection and .NET Portable Class Libraries you can skip these sections.

### .NET Portable Class Libraries (PCLs)

Portable Class Libraries are .NET assemblies designed to be used by multiple target platforms in the .NET application space. You can specify which targets you want to be able to use, such as .NET 4.5, Silverlight 4, Windows Phone 8, etc.  The compiler then does the work to limit the APIs you have at your disposal in that library to only the intersection of all of the selected targets.  This guarantees that any code written in that library will work in all of those targets, but no target-specific (device-specific) functionality will be available.  These libraries are great for business-logic and other platform-independent services but are not useable for code that requires direct access to device features like the UI, camera, GPS, etc.  This code can be compiled and tested once, and then accessed from any of the selected target contexts.

### Dependency Injections (DI)

Dependency Injection is a way of maintaining loose-coupling between application components.  Instead of having a piece of code have a direct knowledge of one of its dependencies, the code only has knowledge of an abstraction of that dependency, usually an interface. Since the client is unaware of the implementation and only has knowledge of the abstraction, the implementation of the dependency can change, and as long as it maintains compliance to the interface, the client code is unaware of the change and continues to function normally.  The correct dependency must then be "injected" into the calling code prior to being used.  The client only knows that the dependency implements the needed interface, but is unaware of the actual implementation.  This becomes extremely useful in unit-testing since a fake dependency such as a mock data-provider can be injected by the test context, allowing the tests to focus on the layer being tested without having to test the dependencies as well.  While this is not nearly the only reason to use DI, it is an example of an excellent benefit of its use.

### Injecting Target-Specific Code into PCLs

Let's suppose we have a .NET Portable Class Library that implements the business logic of our application.  We want the application to be able to run on the web under ASP.NET, on Windows 8 as a Modern Windows Store App, and on Windows Phone 8.  We built the PCL using these specific targets so we know (the compiler guarantees) that this code will run in any of those platforms.  However, this code needs to get its data from somewhere, and that somewhere is different depending on what environment we are running in.  In ASP.Net for example, we may want to get the data from Session State, or from a back-end SQL Server, while in Windows Phone 8 and Windows 8 we want to use their (different) implementations of isolated storage.  We can accomplish this by defining an interface that is usable by all 3 targets in a PCL.  We can then create our 3 different implementations of the storage library using target-specific code and inject the appropriate one into the constructor of one or more of the classes in the business-logic PCL.  This injection can be done directly by the parent application, which is going to be target-specific so it would have knowledge of which target is needed, or it can be done indirectly using a DI Container such as Microsoft Unity.

A sample app that is available in the 3 targets previously described may look something like [this](https://skydrive.live.com/redir?resid=5D45DDF99C1E1BCC!144541&amp;authkey=!AHGsbXjaNpcRdvc).  The business-logic and domain layers (interfaces, exceptions, entities, etc) are both PCLs and exist for use in all 3 targets.  The UI layer and Infrastructure layers (in this case, storage) are target-specific and require a separate implementation for each target platform.  A system designed in this way can maximize the use of common, shared code while still making platform specific features available in a type-safe way.

If you are interested in seeing this implementation done live, you can come to one of my Code Camp talks on the subject, or request me as a speaker for your User Group via [Ineta](http://ineta.org/Speakers/SearchCommunitySpeakers.aspx?SpeakerId=4fdf7fc7-5cac-4842-acec-960815523108).

