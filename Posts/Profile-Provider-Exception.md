---
tags:
- provider
- profile
- framework
- asp.net
menuorder: 0
id: 34335f38-c0b5-4ad4-b7a7-e3d3ec0dc382
author: bsstahl
title: Profile Provider Exception
description: 
ispublished: true
showinlist: false
publicationdate: 2006-10-07T18:00:00
lastmodificationdate: 0001-01-03T04:00:00
slug: Profile-Provider-Exception
categoryids:
- categoryid: da73f25e-343d-4a0e-9b28-1d76e8fd99bf

---

While working on a custom Profile provider, I needed to set the values in a SettingPropertyValuesCollection object to pass to the SetPropertyValues method of the provider. Using the code below, I was always getting a NullReferenceException when the provider attempted to read the values out of the collection.

Dim objProperties As New System.Configuration.SettingsPropertyValueCollection  
	Dim objProperty As New System.Configuration.SettingsProperty"BirthDate")  
	objProperty.PropertyValue = #2/14/2004#  
	Dim objPropertyValue As New System.Configuration.SettingsPropertyValue(objProperty)  
	objProperties.Add(objPropertyValue)

The problem occurs because the collection doesn't know what type to assign the value to coming out of the collection. By modifying the code as follows, I specify the type of the property, and the process executes as expected.

Dim objProperties As New System.Configuration.SettingsPropertyValueCollection  
	Dim objProperty As New System.Configuration.SettingsProperty("BirthDate")  
	objProperty.PropertyValue = #2/14/2004#  
objProperty.PropertyType = GetType(System.DateTime)  
	Dim objPropertyValue As New System.Configuration.SettingsPropertyValue(objProperty)  
	objProperties.Add(objPropertyValue)

