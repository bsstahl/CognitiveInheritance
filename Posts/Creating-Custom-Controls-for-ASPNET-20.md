---
tags:
- controls
- asp.net
- controlstate
- viewstate
- reflector
menuorder: 0
id: 77c8094b-6a05-483c-8381-787e218075bb
author: bsstahl
title: Creating Custom Controls for ASP.NET 2.0
description: 
ispublished: true
showinlist: false
publicationdate: 2006-05-08T18:59:00
lastmodificationdate: 2010-10-22T18:11:36
slug: Creating-Custom-Controls-for-ASPNET-20
categories:
- Development
- Event

---
A number of new facts came out of the final talk I attended on the day, Mickey Williams' discussion of ASP.NET 2.0 custom controls. These key facts for me were:   
  

- Embedded resources can be used in 2.0 controls (i.e. graphics)
- ControlState can be used for critical data rather than ViewState. ControlState can't be turned off (be sure to use this for good and not for evil)
- SmartTags can be easily created to expose the most common elements of a control to the page developer for easy modification and configuration
- Controls can now inherit from CompositeControl or CompositeDataBoundControl
- Mickey highly reccomends [Reflector](http://www.aisto.com/roeder/dotnet/) as a class browser, explorer, analyzer and documentation viewer for .NET


I'm sure the slide-decks and samples will be posted soon.

