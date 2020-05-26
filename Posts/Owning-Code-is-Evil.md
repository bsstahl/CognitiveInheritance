---
tags:
- coding practices
menuorder: 0
id: b1c44e28-3037-44b4-9f75-7223944d1cb0
author: bsstahl
title: Owning Code is Evil
description: 
ispublished: true
showinlist: false
publicationdate: 2007-06-14T11:45:00
lastmodificationdate: 2010-10-22T18:11:36
slug: Owning-Code-is-Evil
categories:
- Development

---

Commenting on a [Rich Skrenta](http://www.skrenta.com/2007/05/code_is_our_enemy.html) post, the point of which is that we should write as little code as possible, [Jeff Atwood](http://www.codinghorror.com/blog/archives/000878.html) writes:


> I couldn't agree more. I've given similar advice when I exhorted developers to Code Smaller. And I'm not talking about a [reductio ad absurdum](http://en.wikipedia.org/wiki/Reductio_ad_absurdum) contest where we use up all the clever tricks in our books to make the code fit into less physical space. I'm talking about practical, sensible strategies to reduce the volume of code an individual programmer has to read to understand how a program works. Here's a trivial little example of what I'm talking about:   
>   
> 
> - if (s == String.Empty)
> - if (s == "")
> 
>   
> It seems obvious to me that the latter case is better because it's just plain smaller. And yet I'm virtually guaranteed to encounter developers who will fight me, almost literally to the death, because they're absolutely convinced that the verbosity of String.Empty is somehow friendlier to the compiler. As if I care about that. As if anyone cared about that!

  

I certainly agree that we should endeavor to write as little code as we can, for all of the reasons spelled out in Rich’s post. The example that Jeff gives is however, in my opinion, totally contrary to the true intent. While he is correct that nobody should care about whether or not code is better for the compiler, String.Empty is generally better to use than double-quotes because it is explicit, and therefore much easier for a human to read. There can be no doubt what String.Empty means, and there can be no doubt about what value it holds. While most editors/compilers eliminate the worry about control characters between double-quotes, there is no easy way to be sure, especially if you are viewing the code in notepad. As a result, we are generally better off typing the few extra characters. Remember that the goals is to create code that is easier (and therefore cheaper) to create, edit and maintain. Saving a few typed characters here and there does not help achieve that goal, it is simplicity of the code that does. Since one of the key factors in achieving simplicity is clarity, we should do whatever we can to make our code as clear and explicit as possible. This usually includes things like avoiding the use of default values, even though explicitly defining those values will cost us extra keystrokes.

Far more important in terms of code-reduction than saving keystrokes is avoiding owning code that someone else, usually Microsoft, is willing to own for us. I don't know how many times I have seen developers create their own serialization mechanism when .NET serialization would have worked fine, or create their own collection implementation from scratch rather than inheriting from System.Collections.CollectionBase. Please don’t misunderstand me; there are times when it is appropriate to do these things, if the canned mechanisms truly won’t work for the use-case. If these already-existing frameworks will work however, it is imperative that we allow Microsoft to own that code, and allow the thousands of other .NET developers out there to test it for us.

