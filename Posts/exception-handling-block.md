---
tags:
- enterprise library
- exception handling
- catch
- throw
menuorder: 0
id: 3273c985-8281-4366-91fa-4143851a2b99
author: bsstahl
title: Exception Handling Block
description: ''
content: ''
ispublished: true
showinlist: false
publicationdate: 2006-05-08T19:57:00Z
lastmodificationdate: 0001-01-02T09:30:00Z
slug: Exception-Handling-Block
categoryids:
- categoryid: da73f25e-343d-4a0e-9b28-1d76e8fd99bf
byline: Posted by bsstahl

---
Rob Bagby continued his outstanding presentations with not just an overview of the Exception Handling Block, but a full-blown strategy for handling exceptions. Rob had 5 goals for the session which I have paraphrased below:

* Understand when and why to catch an exception

    To Recover from the error (or attempt to)
    To Add Context
    To Clean up (close connections, etc)
    To Log or Notify
    To hide the details of an exception

* Understand the categories of exceptions

    Business
    Technical
    Security

* Understand what is truly an exception

    Don't use exceptions for flow-control

* Understand Exception Propagation Options

    Automatic Propogation (bubbling)
    Catch & Rethrow (Clean, Resolve, Log)
    Catch, Wrap & Throw Wrapped

* Understand Custom Exceptions and When to Use Them

    When an appropriate exception doesn't already exist
    To add discreet handling
    To add a specific behavior or information 

Rob went into quite a few specifics on exactly how this information could be utilized which is in the slide decks that I will link to asap.

This session got my vote as the most useful session of the day. Thanks Rob!