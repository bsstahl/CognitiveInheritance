---
tags:
- troubleshooting
- ado.net
- dataset
- enforceconstraints
- haserrors
- rowerror
menuorder: 0
id: 8e142988-0bff-4d11-b40b-823985a5f6e1
author: bsstahl
title: Solving DataSet Constraint Problems
description: 
ispublished: true
showinlist: false
publicationdate: 2006-08-31T17:35:00
lastmodificationdate: 2010-10-22T18:11:27
slug: Solving-DataSet-Constraint-Problems
categories:
- Development

---

Roy Osherove, and one of his commenters on his [ISerializable](http://weblogs.asp.net/rosherove/default.aspx) blog, explains how to find out the source of a constraint problem in a DataSet. To do so, simply set the **DataSet.EnforceConstraints** property to false, then load your data. Once everything is loaded, set the **EnforceConstraints** property back to True, while trapping for the error. Once the error occurs, you can iterate through the Tables, testing the **HasErrors** property. For each table with errors, iterate through its rows testing the same property. Rows that have errors will have a property called **RowError** that describes the specific problem with that row.

Roy's original article is: [DataSet hell - "Failed to enable constraints. One or more rows contain values...."](http://weblogs.asp.net/rosherove/archive/2004/10/03/237260.aspx).

