---
tags:
- coding practices
- development
- enterprise
- responsibility
- testing
- ai
- algorithms
menuorder: 0
id: 686f1de9-562f-4ef5-a3ac-4a75da9373f8
author: bsstahl
title: Programmers -- Take Responsibility for Your AI’s Output
description: 
ispublished: true
showinlist: false
publicationdate: 2018-03-16T03:22:42.000+00:00
lastmodificationdate: 2018-03-16T03:22:42.000+00:00
slug: Programmers-Take-Responsibility-for-Your-AIe28099s-Output
categories:
- Development

---
> **plus ça change, plus c'est la même chose** – **The more that things change, the more they stay the same**. – Rush (and others ![Winking smile]({PathToRoot}/Images/wlEmoticon-winkingsmile.png) )


In 2013 I {PageLink:Programmers-Take-Responsibility-for-Your-Programe28099s-Output|wrote} that programmers needed to take responsibility for the output of their computer programs.  In that article, I advised developers that the output of their system, no matter how “random” or “computer generated”, was still their responsibility. I suggested that we cannot cop out by claiming  that the output of our programs is not our fault simply because we didn’t directly instruct the computer to issue that specific result.

Today, we have a similar problem, only the stakes are much, much, higher.

In the world of 2018, our algorithms are being used in police work and inside other government agencies to know where and when to deploy resources, and to decide who is and isn’t worthy of an opportunity. Our programs are being used in the private sector to make decisions from trading stocks to hiring, sometimes at a scale and speed that puts us all at risk of economic events. These tools are being deployed by information brokers such as Facebook and Google to make predictions about how best to steal the most precious resource we have, our time.  Perhaps scariest of all, these algorithms may be being used to make decisions that have permanent and irreversible results, such as with drone strikes.  We  simply have no way of knowing the full breadth of decisions that AIs are making on our behalf today.  If those algorithms are biased in any way, the decisions made by these programs will be biased, potentially in very serious ways and with serious results.


> If we take all available steps to recognize and eliminate the biases in our systems, we can minimize the likelihood of our tools producing output that we did not expect or that violates our principles.


All of the machines used to execute these algorithms are bias-free of course.  A computer has no prejudices and no desires of its own.  However, as we all know, decision-making  tools learn what we teach them.  We cannot completely teach these algorithms free of our own biases.  It simply cannot be done since all of our data is colored by our existing biases.  Perhaps the best known example of bias in our data is in crime data used for policing. If we send police to where there is most often crime, we will be sending them to the same places we’ve sent them in the past, since generally, crime involves having a police office in the location to make an arrest. Thus, any biases we may have had in the past about where to send police officers, will be represented in our data sets about crime.

While we may never be able to eliminate biases completely, there are things that we can do to minimize the impact of the biases we are training into our algorithms.  If we take all available steps to recognize and eliminate the biases in our systems, we can minimize the likelihood of our tools producing output that we did not expect or that violates our principles.

### Know that the algorithm is biased

We need to accept the fact that there is no way to create a completely bias-free algorithm.  Any dataset we provide to our tools will inherently have some bias in it.  This is the nature of our world.  We create our datasets based on history and our history, intentionally or not, is full of bias.  All of our perceptions and understandings are colored by our cognitive biases, and the same is true for the data we create as a result of our actions.  By knowing and accepting this fact, that our data is biased, and therefore our algorithms are biased, we take the first step toward neutralizing the impacts of those biases.

### Predict the possible biases

We should do everything we can to predict what biases may have crept into our data and how they may impact the decisions the model is making, even if that bias is purely theoretical.  By considering what biases could potentially exist, we can watch for the results of those biases, both in an automated and manual fashion.

### Train “fairness” into the model

If a bias is known to be present in the data, or even likely to be present, it can be accounted for by defining what an unbiased outcome might look like and making that a training feature of the algorithm.  If we can reasonably assume that an unbiased algorithm would distribute opportunities among male and female candidates at the same rate as they apply for the opportunity, then we can constrain the model with the expectation that the rate of  accepted male candidates should be within a statistical tolerance of  the rate of male applicants.  That is, if half of the applicants are men then men should receive roughly half of the opportunities.  Of course, it will not be nearly this simple to define fairness for most algorithms, however every effort should be made.

### Be Open About What You’ve Built

The more people understand how you’ve examined your data, and the assumptions you’ve made, the more confident they can be that anomalies in the output are not a result of systemic bias. This is the most critical when these decisions have significant consequences to peoples’ lives.  A good example is in prison sentencing. It is unconscionable to me that we allow black-box algorithms to make sentencing decisions on our behalf.  These models should be completely transparent and subject to our analysis and correction.  That they aren’t, but are still being used by our governments, represent a huge breakdown of the system, since these decisions MUST be made with the trust and at the will of the populace.

### Build AIs that Provide Insight Into Results (when possible)

Many types of AI models are completely opaque when it comes to how decisions are reached.  This doesn’t mean however that all of our AIs must be complete black-boxes.  It is true that  most of the common machine learning methods such as Deep-Neural-Networks (DNNs) are extremely difficult to analyze.  However, there are other types of models that are much more transparent when it comes to decision making.  Some model types will not be useable on all problems, but when the options exist, transparency should be a strong consideration.

There are also techniques that can be used to make even opaque models more transparent.  For example, a hybrid technique ({PageLink:AI-That-Can-Explain-Why|AI That Can Explain Why} & {PageLink:An-Example-of-a-Hybrid-AI-Implementation|An Example of a Hybrid AI Implementation}) can be used to run opaque models iteratively.  This can allow the developer to log key details at specific points in the process, making the decisions much more transparent.  There are also techniques to manipulate the data after a decision is made, to gain insight into the reasons for the decision.

### Don’t Give the AI the Codes to the Nukes

Computers should never be allowed to make automated decisions that cannot be reversed by a human if necessary. Decisions like when to attack a target, execute a criminal, vent radioactive waste, or ditch an aircraft are all decisions that require human verification since they cannot be undone if the model has an error or is faced with  a completely unforeseen set of conditions. There are no circumstances where machines should be making such decisions for us without the opportunity for human intervention, and it is up to us, the programmers, to make sure that we don’t give them that capability.

### Don’t Build it if it Can’t be Done Ethically

If we are unable to come up with an algorithm that is free from bias, perhaps the situation is not appropriate for an automated decision making process.  Not every situation will warrant an AI solution, and it is very likely that there are decisions that should always be made by a human in totality.  For those situations, a decision support system may be a better solution.

## The Burden is Ours

As the creators of automated decision making systems, we have the responsibility to make sure that the decisions they make do not violate our standards or ethics.  We cannot depend on our AIs to make fair and reasonable decisions unless we program them to do so, and programming them to avoid inherent biases requires an awareness and openness that has not always been present.  By taking the steps outlined here to be aware of the dangers and to mitigate it wherever possible, we have a chance of making decisions that we can all be proud of, and have confidence in.