---
tags:
- coding-practices
- development
- enterprise
- responsibility
- testing
menuorder: 0
id: 20380740-06e6-4b0a-82ea-2d7ae4f368bc
author: bsstahl
title: Programmers -- Take Responsibility for Your Program’s Output
description: 
ispublished: true
showinlist: false
publicationdate: 2013-03-03T10:19:18.000+00:00
lastmodificationdate: 2013-03-03T10:19:18.000+00:00
slug: Programmers-Take-Responsibility-for-Your-Programe28099s-Output
categories:
- Development

---
You have probably seen the discussion of the “Keep Calm and Rape a Lot” T-Shirts that were made available, for a time, by an Amazon reseller.  These shirts were one of several thousand computer-generated designs offered for sale on Amazon, to be printed and shipped if anyone cared to buy one.  At first blush, and as some have pointed-out, it seems like a simple error. A verb list that contained the word “rape” was not properly vetted and therefore the offensive shirt promoting violent crime was offered for sale by mistake. No offense was intended, so, as long as the company takes the proper action of [apologizing and removing the offending item](https://web.archive.org/web/20130429232420/http://www.solidgoldbomb.com/pages/our-apology), all is well.  This sentiment seems to be summed-up by the [well-read post by Pete Ashton](https://web.archive.org/web/20130305012153/http://iam.peteashton.com/keep-calm-rape-tshirt-amazon/) on the subject:

> Because these algorithms generally mimic decisions that used to be made directly by people we have a tendency to humanise the results and can easily be horrified by what we see. But some basic understanding of how these systems work can go a long way to alleviating this dissonance.

However, I believe it is not nearly this simple.  For one thing, I wonder about how this offensive shirt was “discovered”.  Did somebody really stumble across it in the Amazon store, or, was its existence “leaked” to generate publicity.  I don’t know the answer to this question, but if it were the case that someone at the company knew it was there, and either did nothing or worse, used it for marketing purposes, that would invalidate the “…it was computer generated” defense.  However, in my mind, that defense doesn’t hold water for another reason.  That is, we know this can happen and have the responsibility to make sure it doesn’t.

**The companies that use our software are responsible for the output of our programs**.  If we are using a sequence of characters that could potentially form a word, those companies are responsible for the message that word conveys.  If our programs output a sequence of words that could potentially form a sentence, they are responsible for that message as well.  If the reasonable possibility exists that a message generated by these algorithms would be offensive, and visible to the public, failure to properly vet the message makes that company responsible for it.

This fact is made even more critical when our customers are enterprise scale clients and we are building software for use by the general public. As an example, lets look at one of the common systems for creating airline reservations which has been in operation for decades.  This system presents to the consumer a six-character alphanumeric code known as the Record Locator Number. This identifier is used for the reservation by both automated and manual systems. What do you think would happen if you were making an airline reservation, and the response, either verbally, or in text, came back with the Record Locator “FATASS”?  How about “FUKOFF” or “UBITCH”?  If the programmers who created this system had just coded a random (or incrementing) set of any 6 characters, these letter combinations would have come up, probably multiple times by now because of the sheer volume of use.  However, the system creators knew this could happen and did what needed to be done to prevent sequences with meaning from being used.  As language changes and different letter combinations have different meanings, these policies need to be reviewed and amended to include additional letter combinations. Problems like this are not new and have been solved many times before, when the clients wanted them to be solved.

Knowing that random combinations of words can result in meaningful, and potentially offensive sentences, we are responsible for the failure when they actually do, whether they happened “intentionally” or not.