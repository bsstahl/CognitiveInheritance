---
tags:
- enterprise library
- exception handling
- catch
- throw
menuorder: 
id: 3273c985-8281-4366-91fa-4143851a2b99
author: bsstahl
title: Exception Handling Block
description: ''
ispublished: true
showinlist: false
publicationdate: 2006-05-08T12:57:00.000+00:00
lastmodificationdate: 0001-01-02T02:03:00.000+00:00
slug: Exception-Handling-Block
categoryids:
- categoryid: da73f25e-343d-4a0e-9b28-1d76e8fd99bf

---
Rob Bagby continued his outstanding presentations with not just an overview of the Exception Handling Block, but a full-blown strategy for handling exceptions. Rob had 5 goals for the session which I have paraphrased below:

* Understand when and why to catch an exception
  1. To Recover from the error (or attempt to)
  2. To Add Context 
  3. To Clean up (close connections, etc) 
  4. To Log or Notify 
  5. To hide the details of an exception

* Understand the categories of exceptions
  1. Business
  2. Technical 
  3. Security

* Understand what is truly an exception
  1. Don't use exceptions for flow-control
  
* Understand Exception Propagation Options
  1. Automatic Propagation (bubbling)
  2. Catch & Rethrow (Clean, Resolve, Log) 
  3. Catch, Wrap & Throw Wrapped
  
* Understand Custom Exceptions and When to Use Them
  1. When an appropriate exception doesn't already exist
  2. To add discreet handling
  3. To add a specific behavior or information

Rob went into quite a few specifics on exactly how this information could be utilized which is in the slide decks that I will link to asap.

This session got my vote as the most useful session of the day. Thanks Rob!