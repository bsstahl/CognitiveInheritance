---
tags:
- agile
- coding practices
- development
- skill
menuorder: 0
id: d9257fea-1c85-4820-9080-4f711ba8b08e
author: bsstahl
title: Continuous Improvement as a Developer
description: 
ispublished: true
showinlist: false
publicationdate: 2011-04-29T12:19:29
lastmodificationdate: 2011-04-29T12:19:29
slug: Continuous-Improvement-as-a-Developer
categories:
- Development

---

In a [video interview about storytelling](https://www.youtube.com/watch?v=X2wLP0izeJE) for currentTV, Ira Glass, the host of “This American Life”, details the lengthy process that he, and all creative people go through to close the quality gap between the work they are trying to produce, and what they are actually producing.

> All of us who do creative work, we get into it, and we get into it because we have good taste… So you’ve got really good taste and you get into this thing that I don’t even know how to describe but it’s like there’s a gap. That for the first couple of years that you’re making stuff, what you’re making isn’t so good, ok, it’s not that great, it’s really not that great. It’s trying to be good, it has ambition to be good, but it’s not quite that good. But your taste, the thing that got you into the game, your taste is still killer. Your taste is still good enough that you can tell that what you’re making is kind of a disappointment to you…you can tell that it’s still sort-of crappy. A lot of people never get past that phase, a lot of people, at that point, they quit. And the thing that I would say to you with all my heart is that most everybody I know who does interesting, creative work, they went through a phase of years where they had really good taste, they could tell that what they were making wasn’t as good as they wanted it to be, they knew it fell short. Some of us can admit that to ourselves and some of us are a little less able to admit that to ourselves. But we knew it didn’t have this special thing we wanted it to have. And the thing I’d say to you is, everybody goes through that, and for you to go through it, if you’re going through it right now, if you’re just getting out of that phase, or if you’re just starting off and you’re entering into that phase, you gotta know, it’s totally normal and the most important possible thing you could do is do a lot of work. Do a huge volume of work…

While Ira is specifically talking about TV and radio production, his statements also hold true for more analytic pursuits including software development. There have been many occasions during my career as a developer where I knew that the work I had done did not meet my own lofty expectations. There are a number of reasons for this, several of which I have detailed below:

1. **Ran out of time/money** – We often take shortcuts while building a solution that we never get back to fixing because we ran out of time or money.  This is sometimes fine, and other times not.  It is important to know when it is acceptable to take shortcuts, and how to be certain to get back to them before they cause problems down the road.
2. **Techniques not yet defined/available** – Often, when new technologies are released, the best practices for using those technologies are not known.  Sometimes, things that are best-practices with older technologies, or older versions of technologies, are no longer the right things to do with the current state-of-affairs.  There are times that you will need to develop those best practices, which can usually only be done through experimentation.
3. **Misunderstanding of best practices** – Sometimes, we simply don’t know or misunderstand the best practices.  Occasionally, we will think we are using the best-known-method for dealing with a problem, only to find that we were mistaken, or misunderstood the problem or the solution.  Either way, we have to choose between fixing the problem through refactoring, scrapping our code and starting over, or accepting the less-than-optimal code.


Fortunately, the solutions to these problems are generally the same as Ira’s, that is, to keep doing it.  Keep building things, refining your skills, and techniques, and bringing in new tools and technologies to continually close the gap between the work you expect to be doing, and the work you are doing.  Continuously refactor your code to improve it, and to search for the best ways of solving the problems we face.  Build light frameworks when appropriate to help solve repeat problems, and keep those frameworks abstract and loosely-coupled enough so that when the technologies change, the solutions can change accordingly.  Finally, and most importantly, never stop learning.  Our industry is one where if you stop, or even slow your learning process, you are very quickly going to be left stuck with antiquated tools and techniques.  Always keep reading new articles and trying new things.  You are unlikely to ever reach the point where you are completely happy with all of your code, but by continuously learning and striving to improve, you can definitely reach the point that you understand your failings and know what you need to do to make things better whenever your work is not what you hoped for.  Then, armed with that knowledge, you have what you need to decide if it is worth it to make the code better, or if is it more valuable to move on to the next thing.

