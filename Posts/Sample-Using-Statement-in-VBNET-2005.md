---
tags:
- vb.net
- code sample
menuorder: 0
id: 12361edd-560a-4532-bec9-53b11dc3767e
author: bsstahl
title: Sample Using Statement in VB.NET 2005
description: 
ispublished: true
showinlist: false
publicationdate: 2006-04-28T20:33:00.000+00:00
lastmodificationdate: 2010-10-22T18:11:36.000+00:00
slug: Sample-Using-Statement-in-VBNET-2005
categories:
- Development

---
For future reference, here is a sample using statement in VB.NET 2005.

```vb
Using wsBlogService As New BlogService.Blog  
      Try  
           Me.Text = wsBlogService.DisplayBlog("BlogName", 0)  
      Catch objException As System.Exception  
           Me.Text = String.Format("", objException.Message, wsBlogService.url)  
      End Try  
 End Using
 ```
