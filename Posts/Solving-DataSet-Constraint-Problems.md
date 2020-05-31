---
tags:
- troubleshooting
- data structures
menuorder: 0
id: 8e142988-0bff-4d11-b40b-823985a5f6e1
author: bsstahl
title: Solving DataSet Constraint Problems
description: 
ispublished: true
showinlist: false
publicationdate: 2006-08-31T17:35:00.000+00:00
lastmodificationdate: 2010-10-22T18:11:27.000+00:00
slug: Solving-DataSet-Constraint-Problems
categories:
- Development

---
Roy Osherove, and one of his commenters on [his blog](https://osherove.com/blog/), explains how to find out the source of a constraint problem in a DataSet. To do so, simply set the **DataSet.EnforceConstraints** property to false, then load your data. Once everything is loaded, set the **EnforceConstraints** property back to True, while trapping for the error. Once the error occurs, you can iterate through the Tables, testing the **HasErrors** property. For each table with errors, iterate through its rows testing the same property. Rows that have errors will have a property called **RowError** that describes the specific problem with that row.

Roy's original article is: [DataSet hell - "Failed to enable constraints. One or more rows contain values...."](https://osherove.com/blog/2004/10/3/dataset-hell-failed-to-enable-constraints-one-or-more-rows-c.html?rq=DataSet%20hell%20-%20%22Failed%20to%20enable%20constraints).