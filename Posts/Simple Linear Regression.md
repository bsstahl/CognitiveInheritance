---
tags:
- ai
- algorithms
- ml
- optimization
- presentation
menuorder: 0
id: 18a693d3-448c-4477-b4e2-7193e896a2b6
author: bsstahl
title: Simple Linear Regression
description: The Connection Between Simple Neural Networks and Linear Regression
ispublished: true
showinlist: false
buildifnotpublished: true
publicationdate: 2023-02-13T07:00:00.000+00:00
lastmodificationdate: 2023-02-13T07:00:00.000+00:00
slug: simple-linear-regression
categories:
- Development

---
My high-school chemistry teacher, Mrs. J, had a name for that moment when she could see the lightbulb go on over your head. You know, that instant where realization hits and a concept sinks-in and becomes part of your consciousness. The moment that you truly "Grok" a principle. She called that an "aha experience".

One of my favorite "aha experiences" from my many years as a Software Engineer, is when I realized that the simplest neural network, a model with one input and one output, was simply modeling a line, and that training such a model, was just performing a linear regression. Mind. Blown.

In case you haven't had this particular epiphany yet, allow me to go into some detail. I also discuss this in my conference talk, [A Developer's Introduction to Artificial Intelligences](https://cognitiveinheritance.com/Pages/Speaking-Engagements.html#ai-talks).

#### Use Case: Predict the Location of a Train

Let's use the example of predicting the location of a train. Because they are on rails, trains move in 1-dimensional space. We can get a good approximation of their movement, especially between stops, by assuming they travel at a consistent speed. As a result, we can make a reasonably accurate prediction of a train's distance from a particular point on the rail, using a linear equation.

If we have sensors reporting the location and time of detection of our train, spread-out across our fictional rail system, we might be able to build a graph of these reports that looks something like this:

{ImageLink:Positive Only Linear Data.png|A plot of data points that, while noisy, clearly start from the origin at the bottom-left and moves in a line toward the top-right}

I think it is clear that this data can be represented using a "best-fit line". Certainly there is some error in the model, perhaps due to sensor or reporting errors, or maybe just to normal variance of the data. However, there can be no doubt that the best fit for this data would be represented as a line. In fact, there are a number of tools that can make it very easy to generate such a line. But what does that line really represent? To be a "best-fit", the line needs to be drawn in such a way as to minimize the differences between the values found in the data and the values on the line. Thus, the total error between the values predicted by our best-fit line, and the actual values that we measured, is as small as we can possibly get it.

#### A Linear Neural Network

A simple neural network, one without any hidden layers, consists of one or more input nodes, connected with edges to one or more output nodes. Each of the edges has a weight and each output node has a bias. The values of the output nodes are calculated by summing the product of each input connected to it, along with its corresponding weight, and adding in the output node's bias. Let's see what our railroad model might look like using a simple neural network.

{ImageLink:Simplest Neural Network.png|The simplest neural network; 1 input node, connected to 1 output node via 1 edge}

Ours is the simplest possible neural network, one input connected to one output, where our **X** value (time) is the input and the output **Y** is our prediction of the distance the train has traveled in that time. To make the best prediction we need to determine the values for the weight of the edge **m** and the bias of the output node **b** that produce the output that minimizes the errors in the model.

The process of finding the weights and biases values for a neural network that minimize the error is know as *Training* the model. Once these values are determined, we use the fact that we multiply the weight by the input (m * X) and add in the bias. This gives us an equation in the form:

> Y = mX + b

You may recognize this as the **slope-intercept** form of the equation for a line, where the slope **m** represents the speed of the train, and the bias **b** represents the starting distance from the origin. Once our training process gives us values for **m** and **b**, we can easily plug-in any value for **X** and get a prediction for the location of our train.

#### Training a Model

Training an AI model is simply finding the set of parameters that minimize the difference between the predicted output and the actual output. This is key to understanding AI - it's all about minimizing the error. Error minimization is the exact same goal as we have when performing a linear regression, which makes sense since these regressions are predictive models on their own, they just aren't generally depicted as neural networks.

There are many ways to perform the error-minimization process. Many more complicated models are trained using an iterative optimization routine called **Gradient Descent**. Extremely simple models like this one often use a less complicated process such as **Ordinary Least Squares**. The goals are the same however, values for weights and biases in the model are found that minimize the error in the output, resulting in a model can make the desired predictions based on known inputs.

Regardless of the method used, the realization that training the simplest neural network results in a model of a line provided the "aha experience" I needed as the foundation for my understanding of Machine Learning models. I hope, by publishing this article, that others may also benefit from this recognition.
