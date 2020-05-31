---
tags:
- class
- coding practices
- csharp
- development
- encapsulation
- entity
- generics
- inheritance
- list
- visual studio
- yagni
menuorder: 0
id: 88da0d75-ea12-4eb5-ac5c-0b197dd8bc48
author: bsstahl
title: No More Collection Objects
description: 
ispublished: true
showinlist: false
publicationdate: 2015-10-27T06:43:22.000+00:00
lastmodificationdate: 2015-10-27T06:43:22.000+00:00
slug: No-More-Collection-Objects
categories:
- Development

---
I don't create collection objects anymore.

I know, I know. I was they guy always preaching that every entity that was being collected had to have its own collection object. It was the right thing at the time; if you needed to take an action on an enumeration or list of objects, those actions needed to be done within a strongly-typed collection object to maintain encapsulation. Even if all that was happening was that an inherited `List<T>` function was being called, that functionality needed to be called on the \`TCollection\` object because, if it wasn't, it was likely that the next time logic needed to be performed on the collection, there wouldn't be a place to put it. Collection logic would end up being spread-out around your code rather than encapsulated in the collection. It was also possible that the implementation might change and need to be updated everywhere, instead of in one place.

Today however, that has all changed. Extension methods now allow us, at any time, to add functionality to `ICollection<T>`, `IList<T>`, `IEnumerable<T>` or any other interface or class. We can attach our list or enumeration based actions directly to the list or enumeration class, and do so at any time, since the methods appear the same to the developer as methods directly on the collection type. Thus, the "no place to put it" fear no longer exists. I've even started using this technique for my factory methods to make it clear that what I am creating is, in fact, an `IEnumerable<T>`, as in this example. 

```
var stations = (null as IEnumerable<Station>).Create();     
var localStations = stations.GetNearby(currentLocation);
```

In this example, both the **Create** and **GetNearby** methods are extension methods found in a static class called **StationExtensions**.

So, the big advantage here is that these methods can be added anytime, meaning we don't need to create an object that we MAY need in the future. This is better adherence to the [YAGNI]({PathToRoot}/Search/yagni.html) principle so it is a better pattern to follow. But what about disadvantages? Does it hurt us in any way to perform our collection actions this way? I'm not comfortable answering that question with an absolute "no" yet because I don't think I've been using this technique long enough to have covered enough ground with it, but I can certainly say that I haven't found any disadvantages yet. It seems like these extension methods are basically perfect for this type of activity. These methods do everything that the methods of a collection object do, can (and should) be put in a separate module to keep the code together, can be navigated to by Visual Studio in the same way as other methods, and have the same access (`private`, `internal`, `public`) restrictions that collection objects have. About the only thing I can say that is not 100% positive about using these techniques is that the `(null as IEnumerable<T>)` syntax to create a local variable instance to call the class factory from is not quite as elegant as I'd like it to be.

So you tell me, do you still create collection objects? Have you found any reason why using extension methods in this way is not as good as putting those methods into a strongly-typed collection? Sound off on Twitter {TwitterLink} and let's talk about it.