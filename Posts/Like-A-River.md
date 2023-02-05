---
author: bsstahl
tags:
- architecture
- corporate culture
- enterprise
- ethics
- opinion
categories:
- Development
menuorder: 0
id: 472f33ba-2519-4fa0-84c1-f1dc869d4cba
title: Like a River
description: The life cycle of a software-intensive system is like a river, and we, as developers, are but captains of the boats that ply its waters and dredge its channels. - Grady Booch
ispublished: false
showinlist: false
publicationdate: 2023-02-06T07:00:00Z
lastmodificationdate: 2023-02-06T07:00:00Z
slug: like-a-river

---
We all understand to some degree, that the metaphor comparing the design and construction of software to that of a building is flawed at best. That isn't to say it's useless of course, but it seems to fail in at least one critical way; it doesn't take into account that creating software should be solving a business problem that has never been solved before. Sure, there are patterns and tools that can help us with technical problems similar to those that have been solved in the past, but we should not be solving the same business problem over and over again. If we are, we are doing something very wrong. Since our software cannot simply follow long-established plans and procedures, and can evolve very rapidly, even during construction, the over-simplification of our processes by excluding the innovation and problem-solving aspects of our craft, feels rather dangerous.

#### Like Constructing a Building

It seems to me that by making the comparison to building construction, we are over-emphasizing the scientific aspects of software engineering, and under-emphasizing the artistic ones. That is, we don't put nearly enough value on innovation such as designing abstractions for testability and extensibility. We also don't emphasize enough the need to understand the distinct challenges of our particular problem domain, and how the solution to a similar problem in a different domain may focus on the wrong features of the problem. As an example, let's take a workforce scheduling tool. The process of scheduling baristas at a neighborhood coffee shop is fundamentally similar to one scheduling pilots to fly for a small commercial airline. However, I probably don't have to work too hard to convince you that the two problems have very different characteristics when it comes to determining the best solutions. In this case, the distinctions are fairly obvious, but in many cases they are not.

Where the architecture metaphor makes the most sense to me is in the user-facing aspects of both constructions. The physical aesthetics, as well as the experience humans have in their interactions with the features of the design are critical in both scenarios, and in both cases will cause real problems if ignored or added as an afterthought. Perhaps this is why the architecture metaphor has become so prevalent in that it is easy to see the similarities between the aesthetics and user-experience of buildings and software, even for a non-technical audience. However, most software built today has a much cleaner separation of concerns than software built when this metaphor was becoming popular in the 1960s and 70s, rendering it mostly obsolete for the vast majority of our systems and sub-systems.

When we consider more technical challenges such as design for reliability and resiliency, the construction metaphor fails almost completely. Reliability is far more important in the creation of buildings than it is in most software projects, and often very different. While it is never ok for the structure of a building to fail, it can be perfectly fine, and even expected, for most aspects of a software system to fail occasionally, as long as those failures are well-handled. Designing these mechanisms is a much more flexible and creative process in building software, and requires a large degree of innovation to solve these problems in ways that work for each different problem domain. Even though the two problems can share the same name in software and building construction, and have some similar characteristics, they are ultimately very different problems and should be seen as such. The key metaphors we use to describe our tasks should reflect these differences.

#### Like a River

For more than a decade now, I've been fascinated by Grady Booch's suggestion that a more apt metaphor for the structure and evolution of the software within an enterprise is that of a river and its surrounding ecosystem [G. Booch, "Like a River" in IEEE Software, vol. 26, no. 03, pp. 10-11, 2009](https://www.computer.org/csdl/magazine/so/2009/03). In this abstraction, bank-to-bank slices represent the current state of our systems, while upstream-downstream sections represent changes over time. The width and depth of the river represent the breadth and depth of the structures involved, while the speed of the water, and the differences in speed between the surface (UI) and depths (back-end) represent the speed of changes within those sub-systems.

> The life cycle of a software-intensive system is like a river, and we, as developers, are but captains of the boats that ply its waters and dredge its channels. - Grady Booch

I will not go into more detail on Booch's analogy, since it will be far better to read it for yourself, or [hear it in his own voice](https://www.computer.org/publications/tech-news/on-architecture/like-a-river). I will however point out that, in his model, Software Engineers are "…captains of the boats that ply the waters and dredge the channels". It is in this context, that I find the river metaphor most satisfying.

As engineers, we:

* Navigate and direct the flow of software development, just as captains steer their boats ina particular direction.
* Make decisions and take action to keep the development process moving forward, similar to how captains navigate their boats through obstacles and challenges.
* Maintain a highly-functional anomaly detection and early-warning system to alert us of upcoming obstacles such as attacks and system outages, similar to the way captains use sonar to detect underwater obstacles and inspections by their crew, to give them useful warnings.
* Use ingenuity and skill, while falling back on first-principles, to know when to add abstractions or try something new, in the same way that captains follow the rules of seamanship, but know when to take evasive or unusual action to protect their charge.
* Maintain a good understanding of the individual components of the software, as well as the broader architecture and how each component fits within the system, just as captains need to know both the river and its channels, and the details of the boat on which they travel.
* Are responsible for ensuring the software is delivered on time and within budget, similar to how captains ensure their boats reach their destination on schedule.
* May be acting on but one small section at a time of the broader ecosystem. That is, an engineer may be working on a single feature, and make decisions on how that element is implemented, while other engineers act similarly on other features. This is akin to the way many captains may navigate the same waters simultaneously on different ships, and must make decisions that take into account the presence, activities and needs of the others.

This metaphor, in my opinion, does a much better job of identifying the critical nature of the software developer in the design of our software than then that of the creation of a building structure. It states that our developers are not merely building walls, but they are piloting ships, often through difficult waters that have never previously been charted. These are not laborers, but knowledge-workers whose skills and expertise need to be valued and depended on.

Unfortunately this metaphor, like all others, is imperfect. There are a number of elements of software engineering where no reasonable analog exists into the world of a riverboat captain. One example is the practice of pair or mob programming. I don't recall ever hearing of any instances where a pair or group of ships captains worked collaboratively, and on equal footing, to operate a single ship. Likewise, the converse is also true. I know of no circumstances in software engineering where split-second decisions can have life-or-death consequences. That said, I think the captain metaphor does a far better job of describing the skill and ingenuity required to be a software engineer than that of building construction.

To be very clear, I am not saying that the role of a construction architect, or even construction worker, doesn't require skill and ingenuity, quite the contrary. I am suggesting that the types of skills and the manner of ingenuity required to construct a building, doesn't translate well in metaphor to that required of a software engineer, especially to those who are likely to be unskilled in both areas. It is often these very people, our management and leadership, whom these metaphors are intended to inform. Thus, the construction metaphor represents the job of a software developer ineffectively.

#### Conclusion

The comparisons of creating software to creating an edifice is not going away any time soon. Regardless of its efficacy, this model has come to be part of our corporate lexicon and will likely remain so for the foreseeable future. Even the title of "Software Architect" is extremely prevalent in our culture, a title which I currently hold, and am rather proud of. That said, it could only benefit our craft to make more clear the ways in which that metaphor fails. This clarity would benefit not just the non-technical among us who have little basis to judge our actions aside from these metaphors, but also us as engineers. It is far too easy for anyone to start to view developers as mere bricklayers, rather than the ships captains we are. This is especially true when generations of engineers have been brought up on and trained on the architecture metaphor. If they think of themselves as just workers of limited, albeit currently valuable skill, it will make it much harder for them to challenge those things in our culture that need to be challenged, and to prevent the use of our technologies for nefarious purposes.
