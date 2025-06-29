---
author: bsstahl
tags:
- development
- ai
categories:
- Tools
menuorder: 0
id: 37f405ce-7cf9-4aa1-810c-9793f3a1acd7
title: Types of AI Models
description: 
teaser: 
ispublished: false
showinlist: false
buildifnotpublished: true
publicationdate: 2025-07-01T08:00:00Z
lastmodificationdate: 2017-10-18T07:00:00Z
slug: types-of-ai-models
---
TODO: It is a common misconception that to have an Artificial Intelligence you must have some form of machine learning.  

TODO: AI != ML

# What is AI

### 'An AI is a computational system that behaves rationally.'

TODO: Turn into prose

1. Makes decisions
1. Attempts to make the best decision
    1. Best available understanding (model)
    1. Best available information (data)
1. May act on those decisions (automation)

The key difference between an AI and a decision support system (DSS) is that the DSS aggregates and presents data such that the user can make the best decision whereas the AI attempts to make the decision itself.

I have found it useful to consider AIs as falling into 3 different categories of models. These are:

1. Logical
1. Probabilistic/Learning
1. Optimization/Search

Let's take a look at each of these model types and consider, for each, what... TODO: complete

### Logical
TODO: 

Reducible to conditionals
1. Object Oriented (everything we’ve ever done before)
1. Rules Engine

#### Features
* Results Explainable: Generally - Code is highly imperative
* Correctness Understood: Generally - Code is highly imperative
* Solution Discoverability: Low - Code is highly imperative


### Probabilistic/Learning
TODO: 

Results in a prediction of best solution often derived from earlier data

#### Examples
1. Neural/Bayesian Networks
1. Genetic Algorithms

#### Features
* Results Explainable: Rarely
* Correctness Understood: Somewhat - Unknown at design time, Known at runtime
* Solution Discoverability: High - Solutions may surprise the implementers


### Optimization/Search
TODO: 

Based on reducing and searching the Solution Space
1. Dynamic Programming
1. Linear Programming

#### Features
* Results Explainable: Sometimes - dependent on implementation
* Correctness Understood: Somewhat - dependent on implementation
* Solution Discoverability: Limited - solutions will likely be limited by the implementations


### Hybrid Models
TODO: reference previous articles


TODO: Summarize