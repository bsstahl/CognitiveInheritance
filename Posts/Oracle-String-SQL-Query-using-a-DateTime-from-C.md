---
tags:
- csharp
- oracle
- sql
- .net
- datetime
- format
- select
menuorder: 0
id: 6d2efe42-e15b-45ae-bbca-f20e1beec3cf
author: bsstahl
title: Oracle String SQL Query using a DateTime from C#
description: 
ispublished: true
showinlist: false
publicationdate: 2009-03-07T12:32:00
lastmodificationdate: 2011-03-14T17:32:27
slug: Oracle-String-SQL-Query-using-a-DateTime-from-C
categoryids:
- da73f25e-343d-4a0e-9b28-1d76e8fd99bf

---

The following statement builds a C# string containing an Oracle SQL query that uses a DateTime specified in the .NET code.  It uses the Oracle TO\_DATE function to convert the string date to an oracle date object and specifies the format of the string date for both the C# output and the Oracle input. Using this statement, there can never be a date format mismatch since the same format is specified at both ends.

string sql = string.Format("select \* from MyDB.MyTable t where t.MyDate &gt;   
	     TO\_DATE('{0:MM/dd/yyyy hh:mm}', 'MM/dd/yyyy HH24:mi')", DateTime.Now);

I have found myself using this type of statement fairly often to create tools that help me do my job.  For what it's worth, I wouldn't put this type of code in production since you rarely want to execute a query from a string in a production environment.

