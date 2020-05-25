---
tags:
- pdc
- winfx
- longhorn
- indigo
- winfs
- avalon
- yukon
- whidbey
- orpheus
- services
- sql
menuorder: 0
id: 3aafd970-63fc-4772-a50c-e4500d96fbfc
author: bsstahl
title: Dictionary of PDC ‘03 Terms
description: 
ispublished: true
showinlist: false
publicationdate: 2003-11-02T16:48:00
lastmodificationdate: 2010-10-22T18:11:36
slug: Dictionary-of-PDC-e2809803-Terms
categoryids:
- categoryid: da73f25e-343d-4a0e-9b28-1d76e8fd99bf
- categoryid: 527f404c-3f34-4377-91c9-443f2eedf0b9

---
Instead of posting a summary of the last 2 days of the PDC, I decided to summarize the entire PDC as best I can by creating a glossary of terms. These terms came out of the PDC as either new, having a modified meaning, or greater importance than before.   
  
  
WinFX – The code-name for the next generation of the .NET Framework. Key features of WinFX include [Indigo](http://74.125.95.132/search?q=cache:8hANgX_2q08J:www.cognitiveinheritance.com/%3Ftag%3D/pdc+site:cognitiveinheritance.com&amp;hl=en&amp;ct=clnk&amp;cd=38&amp;gl=us#Indigo), [Avalon](http://74.125.95.132/search?q=cache:8hANgX_2q08J:www.cognitiveinheritance.com/%3Ftag%3D/pdc+site:cognitiveinheritance.com&amp;hl=en&amp;ct=clnk&amp;cd=38&amp;gl=us#Avalon) and [WinFS](http://74.125.95.132/search?q=cache:8hANgX_2q08J:www.cognitiveinheritance.com/%3Ftag%3D/pdc+site:cognitiveinheritance.com&amp;hl=en&amp;ct=clnk&amp;cd=38&amp;gl=us#WinFS).   
  
 Longhorn – The code-name for the next generation of Windows built on, and to work with, [WinFX](http://74.125.95.132/search?q=cache:8hANgX_2q08J:www.cognitiveinheritance.com/%3Ftag%3D/pdc+site:cognitiveinheritance.com&amp;hl=en&amp;ct=clnk&amp;cd=38&amp;gl=us#WinFX). Longhorn provides the user interface features of [Avalon](http://74.125.95.132/search?q=cache:8hANgX_2q08J:www.cognitiveinheritance.com/%3Ftag%3D/pdc+site:cognitiveinheritance.com&amp;hl=en&amp;ct=clnk&amp;cd=38&amp;gl=us#Avalon), the file-system improvements of [WinFS](http://74.125.95.132/search?q=cache:8hANgX_2q08J:www.cognitiveinheritance.com/%3Ftag%3D/pdc+site:cognitiveinheritance.com&amp;hl=en&amp;ct=clnk&amp;cd=38&amp;gl=us#WinFS), and the service support of [Indigo](http://74.125.95.132/search?q=cache:8hANgX_2q08J:www.cognitiveinheritance.com/%3Ftag%3D/pdc+site:cognitiveinheritance.com&amp;hl=en&amp;ct=clnk&amp;cd=38&amp;gl=us#Indigo).   
  
Indigo – The code-name for a set of managed services in the .NET Framework created to support a unified coding structure for applications developed using the services model. In a very-real sense, Indigo makes the SOAP implementation available to all types of services, not just web services and unifies the three main development standards for architecting solutions using the services model, Web Services, .NET Remoting, and Enterprise Services, under one set of managed objects.   
  
WinFS – Vast improvements in the Windows File System that take us closer to being able to view the file system as a relational database. The addition of extensible metadata schema on top of NTFS will allow users to view data in various ways without having to physically reorganize the data. For example, you could view documents by project first, then author, or author first, then project, without having to change the underlying structure of the file system. Currently, with folders, we can only choose one way or the other.   
  
Avalon – The code-name for the next generation of graphics processing engines in Windows which, among many other things, will put much of the graphics processing burden where it belongs, in the GPU (graphics processing unit) rather than using standard CPU cycles. This will allow for vast improvements in application graphics without impacting performance.   
  
Yukon – The code-name for the next generation of SQL Server. Yukon runs in-process with the Common Language Runtime allowing queries to be executed using any CLR language. Yukon also provides support for XQuery allowing procedures to return query results from XML data which was returned as a result of a T-SQL query. Yukon also provides full support for [SQL Cache Invalidation](http://74.125.95.132/search?q=cache:8hANgX_2q08J:www.cognitiveinheritance.com/%3Ftag%3D/pdc+site:cognitiveinheritance.com&amp;hl=en&amp;ct=clnk&amp;cd=38&amp;gl=us#SQLCacheInvalidation).   
  
Whidbey – The code-name for the next generation of the Visual Studio.NET IDE. Whidbey provides developers with the language tools that help create applications that take advantage of the new features of [WinFX](http://74.125.95.132/search?q=cache:8hANgX_2q08J:www.cognitiveinheritance.com/%3Ftag%3D/pdc+site:cognitiveinheritance.com&amp;hl=en&amp;ct=clnk&amp;cd=38&amp;gl=us#WinFX) and aid in the development of applications that utilize the [Services Model](http://74.125.95.132/search?q=cache:8hANgX_2q08J:www.cognitiveinheritance.com/%3Ftag%3D/pdc+site:cognitiveinheritance.com&amp;hl=en&amp;ct=clnk&amp;cd=38&amp;gl=us#ServicesModel).   
  
Orpheus – The code-name for the next generation of Visual Studio.NET after Whidbey.   
  
Services Model – The design philosophy in which application tiers are divided into services by functionality. Often, these tiers are divided into Presentation Services, Business Services (Business Logic) and Data Services. [Indigo](http://74.125.95.132/search?q=cache:8hANgX_2q08J:www.cognitiveinheritance.com/%3Ftag%3D/pdc+site:cognitiveinheritance.com&amp;hl=en&amp;ct=clnk&amp;cd=38&amp;gl=us#Indigo) is designed to support the creation and interaction of these services.   
  
SQL Cache Invalidation – The interaction between SQL Server and ASP.NET that allows the database to invalidate HTML stored in the IIS cache when the data that the page is based on becomes stale. This ability exists, using new utilities from Microsoft at a table level from SQL Server versions 7 and 2000 and is available to the row level in SQL Server [Yukon](http://74.125.95.132/search?q=cache:8hANgX_2q08J:www.cognitiveinheritance.com/%3Ftag%3D/pdc+site:cognitiveinheritance.com&amp;hl=en&amp;ct=clnk&amp;cd=38&amp;gl=us#Yukon).  
