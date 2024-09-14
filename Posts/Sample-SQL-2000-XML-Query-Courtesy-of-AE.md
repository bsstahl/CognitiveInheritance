---
tags:
- xml
- sql
- code sample
menuorder: 0
id: ebfc5816-e855-47dd-898b-8163932d85ef
author: bsstahl
title: Sample SQL 2000 XML Query Courtesy of AE
description: 
ispublished: true
showinlist: false
publicationdate: 2006-05-25T18:53:00.000+00:00
lastmodificationdate: 2010-10-22T18:10:06.000+00:00
slug: Sample-SQL-2000-XML-Query-Courtesy-of-AE
categories:
- Development

---
Here are some Sample SQL 2000 XML Queries.

```sql
DECLARE @sxml varchar(8000)  
 SET @sxml = '&lt;?xml version="1.0" encoding="UTF-8"?&gt;  
 &lt;Change xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" Version="1.0"&gt;  
 &lt;SourceApplication&gt;&lt;Name&gt;Intranet&lt;/Name&gt;&lt;/SourceApplication&gt;  
 &lt;DestinationApplication&gt;&lt;Name&gt;FundsDB&lt;/Name&gt;&lt;/DestinationApplication&gt;  
 &lt;UserName&gt;JDoe&lt;/UserName&gt;&lt;IPAddress&gt;192.168.101.2&lt;/IPAddress&gt;  
 &lt;BusinessEntity&gt;&lt;Name&gt;Fund&lt;/Name&gt;&lt;/BusinessEntity&gt;&lt;ChangeItems&gt;  
 &lt;ChangeItem&gt;&lt;OriginalData&gt;ABC Fund&lt;/OriginalData&gt;&lt;NewData&gt;123 Fund&lt;/NewData&gt;  
 &lt;DataID&gt;5&lt;/DataID&gt;&lt;Field&gt;&lt;Name&gt;Name&lt;/Name&gt;&lt;/Field&gt;&lt;/ChangeItem&gt;  
 &lt;ChangeItem&gt;&lt;OriginalData&gt;Type A&lt;/OriginalData&gt;&lt;NewData&gt;Type B&lt;/NewData&gt;  
 &lt;DataID&gt;5&lt;/DataID&gt;&lt;Field&gt;&lt;Name&gt;Type&lt;/Name&gt;&lt;/Field&gt;&lt;/ChangeItem&gt;  
 &lt;/ChangeItems&gt;&lt;ChangeDate&gt;2004-10-12T12:57:00-07:00&lt;/ChangeDate&gt;  
 &lt;CommandText&gt;s\_SaveFund&lt;/CommandText&gt;&lt;/Change&gt;'  
  
 --------------- ----------------------- -----------------------   
  
 DECLARE @ixml int  
  
 --------------- ----------------------- -----------------------   
  
 EXEC dbo.sp\_xml\_preparedocument @ixml OUTPUT, @sxml  
  
 --------------- ----------------------- -----------------------   
  
 SELECT x.\*  
 FROM OPENXML( @ixml, '/Change', 1)  
 WITH ( SourceApplication varchar(64) 'SourceApplication/Name',  
 DestinationApplication varchar(64) 'DestinationApplication/Name',  
 UserName varchar(64) 'UserName',  
 IPAddress varchar(23) 'IPAddress',   
 BusinessEntity varchar(64) 'BusinessEntity/Name',  
 ChangeDate varchar(16) 'ChangeDate',  
 CommandText varchar(128) 'CommandText' ) x  
  
 --------------- ----------------------- -----------------------   
  
 SELECT x.\*  
 FROM OPENXML( @ixml, '/Change/ChangeItems/ChangeItem', 1)  
 WITH ( OriginalData varchar(2000) 'OriginalData',  
 NewData varchar(2000) 'NewData',  
 DataID varchar(32) 'DataID',  
 Field sysname 'Field/Name' ) x  
  
 --------------- ----------------------- -----------------------   
  
 EXEC dbo.sp\_xml\_removedocument @ixml  
  
 --------------- ----------------------- -----------------------

```
