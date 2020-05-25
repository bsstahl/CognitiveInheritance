---
tags:
- vb.net
- code sample
- using
menuorder: 0
id: 12361edd-560a-4532-bec9-53b11dc3767e
author: bsstahl
title: Sample Using Statement in VB.NET 2005
description: 
ispublished: true
showinlist: false
publicationdate: 2006-04-28T20:33:00
lastmodificationdate: 2010-10-22T18:11:36
slug: Sample-Using-Statement-in-VBNET-2005
categoryids:
- categoryid: da73f25e-343d-4a0e-9b28-1d76e8fd99bf

---
Using wsBlogService As New BlogService.Blog  
      Try  
           Me.Text = wsBlogService.DisplayBlog("BlogName", 0)  
      Catch objException As System.Exception  
           Me.Text = String.Format("", objException.Message, wsBlogService.url)  
      End Try  
 End Using  
