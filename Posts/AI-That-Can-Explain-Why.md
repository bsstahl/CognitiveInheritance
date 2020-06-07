---
tags:
- ai
- algorithms
- decision
- optimization
- solution
menuorder: 0
id: d990a323-9bd0-45fb-893b-70f930977fbc
author: bsstahl
title: A.I. That Can Explain "Why"
description: 
ispublished: true
showinlist: false
publicationdate: 2016-12-15T21:29:09.000+00:00
lastmodificationdate: 2016-12-15T21:47:51.000+00:00
slug: AI-That-Can-Explain-Why
categories:
- Development

---
One of my favorite authors among Software Architects, IBM Fellow Grady Booch, made this reference to [AlphaGo](https://en.wikipedia.org/wiki/AlphaGo), IBM’s program built to play the board game *[Go](https://en.wikipedia.org/wiki/Go_%28game%29)*, in April of 2016:


> "...there are things neural networks can't easily do and likely never will. AlphaGo can't reason about why it made a particular move." – Grady Booch

 
Grady went on to refer to the concept of “Hybrid A.I.” as a means of developing systems that can make complex decisions requiring the processing of huge datasets, while still being able to explain the rationale behind those decisions.

While not exactly the type of system Grady was describing, it reminded me of a solution I was involved with creating that ultimately became a hybrid of an iterative, imperative system and a combinatorial optimization engine.  The resulting solution was able to both determine the optimum solution for a problem with significant data requirements, while still being able to provide information to support the decision, both to prove it was correct, and to help the users learn how to best use it.

The problem looked something like this:

{ImageLink:Ideal%20Solution%20Space_thumb.png|Ideal Solution Space}

There are many possible ways to allocate work assignments among employees.  Some of those allocations would not be legal, perhaps because the employee is not qualified for that assignment, or because of time limits on how much he or she can work.  Other options may be legal, but are not ideal.  The assignment may be sub-optimal for the employee who may have a schedule conflict or other preference against that particular assignment, or for the company which may not be able to easily fill the assignment with anyone else.

The complexity in this problem comes from the fact that this diagram is different for each employee to be assigned.  Each employee has their own set of preferences and legalities, and the preferences of the company are probably different for each employee.  It is likely that many employees will not be able to get an assignment that falls into the “Ideal Solution” area of the drawing.  If there were just a few employees and a supervisor was making these decisions, that person would have to explain his or her rationale to the employees who did not get the assignments they wanted, or to the bosses if company requirements could not be met. If an optimization solution made the decisions purely on the basis of a mathematical model, we could be guaranteed the best solution based on our criteria, but would have no way to explain how one person got an assignment that another wanted, or why company preferences were ignored in any individual case.

The resulting hybrid approach started by eliminating illegal options, and then looking at the most important detail and assigning the best fit for that detail to the solution set.  That is, if the most important feature to the model was the wishes of the most senior employee, that employee’s request would be added to the solution. The optimization engine would then be run to be sure that a feasible solution was still available.  As long as an answer could still be found that didn’t violate any of the hard constraints, the selection was fixed in the solution and the next employee’s wishes addressed.  If a feasible solution could not be found using the selected option, that selection would be recorded along with the result of the optimization and the state of the model at the time of processing.  This allows the reasoning behind each decision to be exposed to the users.

A very simplified diagram of the process is shown below.

{ImageLink:Hybrid%20Decision%20Making_thumb.png|Hybrid Decision Making}

Each time the green diamond testing “Is the solution still feasible?” is hit, the optimization model is run to verify that a solution can be found.  It is this hybrid process, the iterative execution of a combinatorial solution engine, that gives this tool its ability to both answer the question of *how to do things*, while also being able to answer the question of *why it needs to be done this way*.

Like Grady, I expect we will see many more examples of these types of hybrids in the very near future.