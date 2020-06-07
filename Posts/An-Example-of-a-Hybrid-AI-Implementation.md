---
tags:
- ai
- algorithms
- code camp
- code sample
- coding practices
- conference
- open source
- optimization
- presentation
menuorder: 0
id: 0b7c5603-2835-4539-93ea-ecb309eab0fb
author: bsstahl
title: An Example of a Hybrid AI Implementation
description: 
ispublished: true
showinlist: false
publicationdate: 2017-10-13T04:13:13.000+00:00
lastmodificationdate: 2017-10-13T04:18:10.000+00:00
slug: An-Example-of-a-Hybrid-AI-Implementation
categories:
- Development

---
I {PostLink:AI-That-Can-Explain-Why|previously} wrote about a Hybrid AI system that combined logical and optimization methods of problem solving to identify the best solution to an employee shift assignment problem. This implementation was notable in that a hybrid approach was used so that the optimal solution could be found, but the system could still indicate to the users why a particular assignment was, or wasn’t, included in the results.

I recently published to [GitHub](https://github.com/bsstahl/AIDemos) a demo of a similar system. I use this demo in my presentation {PageLink:Speaking-Engagements.html|Building AI Solutions that can Reason Why}. The code demonstrates the hybridization of multiple AI techniques by creating a solution that iteratively applies a combinatorial optimization engine. Different results are obtained by varying the methods of applying the constraints in that model. In the final (4th) demo  method, an iterative process is used to identify what the shortcomings of the final product are, and why they are necessary.

These demos use the [Conference Scheduler](https://github.com/bsstahl/ConferenceScheduler) AI project to build a valid schedule.

There are 4 examples, each of which reside in a separate test method:

### ScheduleWithNoRestrictions()

The 1st method in **BasicExamplesDemo.cs** shows an unconstrained model where only the hardest of constraints are excluded. That is, the only features of the schedule that are considered by the scheduler are those that are absolute **must-haves**.  Since there are fewer hard constraints, it is relatively easy to satisfy all the requirements of this model.

### ScheduleWithHardConstraints()

The 2nd method in **BasicExamplesDemo.cs** shows a fully constrained model where  all constraints are considered **must-haves**. That is, the only schedules that will be considered for our conference are those that meet **all** of the scheduling criteria. As you might imagine, this can be difficult to do, in this case resulting in **No Feasible Solution** being found. Because we use a combinatorial optimization model, the system gives us no clues as to  which of the constraints cause the infeasibility, or what to do that might allow it to find a solution.

### ScheduleWithTimePreferencesAsAnOptimization()

The 3rd method in **BasicExamplesDemo.cs** shows the solution when the true **must-haves** are considered hard constraints but preferences are not. The AI attempts to optimize the solution by satisfying as many of the soft constraints (preferences) as possible. This results in an imperfect, but possibly best case schedule, but one where we have little insight as to what preferences were not satisfied, and almost no insight as to why.

### AddConstraintsDemo()

The final demo, and the only method in **AddConstraintsDemo.cs**, builds on the 3rd demo, where the true **must-haves** are considered hard constraints but preferences are not. Here however, instead of attempting to optimize the soft constraints, the AI iteratively adds the preferences as hard constraints, one at a time, re-executing the solution after each to make sure the problem has not become infeasible. If the solution has become infeasible, that fact is recorded along with what was being attempted. Then that constraint is removed and the process continues with the remaining constraints. This **Hybrid** process still results in an imperfect, but best-case schedule. This time however, we not only know what preferences could not be satisfied, we have a good idea as to why.

### The Hybrid Process

The process of iteratively executing the optimization, adding constraints one at a time, is show in the diagram below.  It is important to remember that the order in which these constraints are added here is critical since constraining the solution in one way may limit the feasibility of the solution for future constraints.  Great care must be taken in selecting the order that constraints are added in order to obtain the best possible solution.

{ImageLink:Hybrid%20Conference%20Optimization%20Process_thumb.png|Hybrid Conference Optimization Process}

The steps are as follows:

1. Make sure we can solve the problem without any of the soft constraints.  If the problem doesn’t have any feasible solutions at the start of the process, we are certainly not going to find any by adding constraints.
2. Add a constraint to the solution. Do so by selecting the next most important constraint in order.  In the case of our conference schedule, we are adding in speaker preferences for when they speak. These preferences are being added in the order that they were requested (first-come first-served).
3. Verify that there is still at least 1 feasible solution to the problem after the constraint is added.  If no feasible solutions can be found:
    1. Remove the constraint.
    2. Record the details of the constraint.
    3. Record the current state of the model.
4. Repeat steps 2 & 3 until all constraints have been tried.
5. Publish the solution
    1. The resulting schedule
    2. The constraints that could not be added.  This tells us what preferences could not be accommodated.
    3. The state of the model at the time the failed constraints were tried.  This give us insight as to why the constraints could not be satisfied.


*Note*: The sample data in these demos is **very** loosely based on SoCalCodeCamp San Diego from the summer of 2017. While some of the presenters names and presentations come roughly from the publicly available schedule, pretty much everything else has been fictionalized to make for a compelling demo, including the appearances by some Microsoft rock stars, and the "requests" of the various presenters.

If you have any questions about this code, or about how Hybrid AIs can be used to provide more information about the solutions to problems than strictly optimization or probabilistic models, please contact me on Twitter {TwitterLink}.