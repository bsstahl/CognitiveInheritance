---
tags:
- abstraction
- apps
- coding practices
- development
- entity
- flexibility
- framework
- generics
- principle
- yagni
- interface
menuorder: 0
id: a9d7154a-2798-4a77-851b-0783b45bc1b4
author: bsstahl
title: Meta-Abstraction -- You Ain't Gonna Need It!
description: 
ispublished: true
showinlist: false
publicationdate: 2020-05-18T15:35:16.000+00:00
lastmodificationdate: 2020-05-18T15:35:16.000+00:00
slug: Meta-Abstraction-You-Aint-Gonna-Need-It!
categories:
- Development

---
> When we look at the abstractions in our applications, we should see a description of the capabilities of our applications, not the capabilities of the abstraction

Let’s start this discussion by looking at an example of a simple repository.

```csharp
public interface IMeetingReadRepository
{
    IEnumerable<Meeting> GetMeetings(DateTime start, DateTime end);
}
```

It is easy to see the capability being described by this abstraction – any implementation of this interface will have the ability to load a collection of Meeting objects that occur within a given timeframe. There are still some unknown details of the implementation, but the capabilities are described reasonably well.

Now let’s look at a different implementation of the Repository pattern.

```csharp
public interface IReadRepository<T>
{
    IEnumerable<T> Get(Func<T, bool> predicate);
}
```

We can still see that something is going to be loaded using this abstraction, we just don’t know what, and we don’t know what criteria will be used.

This 2nd implementation is a more flexible interface. That is, we can use this interface to describe many different repositories that do many different things. All we have described in this interface is that we have the ability to create something that will load an entity. In other words, we have described our abstraction but said very little about the capabilities of the application itself. In this case, we have to look at a specific implementation to see what it loads, but we still have no idea what criteria can be used to load it.

```csharp
public class MeetingReadRepository : IReadRepository<Meeting>
{
    IEnumerable<Meeting> Get(Func<Meeting, bool> predicate);
}
```

We could extend this class with a method that specifically loads meetings by start and end date, but then that method is not on the abstraction so it cannot be used without leaking the details of the implementation to the application.  The only way to implement this pattern in a way that uses the generic interface, but still fully describes the capabilities of the application is to use both methods described above. That is, we implement the specific repository, using the generic repository – layering abstraction on top of abstraction, as shown below.

```csharp
public interface IMeetingReadRepository : IReadRepository<Meeting>
{
    IEnumerable<Meeting> GetMeetings(DateTime start, DateTime end);
}

public class MeetingReadRepository : IMeetingReadRepository
{
    IEnumerable<Meeting> GetMeetings(DateTime start, DateTime end)
        => Get(m => m.Start >= start && m.Start < end)

    // TODO: Implement
    IEnumerable<Meeting> Get(Func<Meeting, bool> predicate)
        => throw new NotImplementedException();
}
```

Is this worth the added complexity? It seems to me that as application developers we should be concerned about describing and building our applications in the simplest, most maintainable and extensible way possible. To do so, we need seams in our applications in the form of abstractions. However, we generally do not need to build frameworks on which we build those abstractions. Framework creation is an entirely other topic with an entirely different set of concerns.

I think it is easy to see how quickly things can get overly-complex when we start building abstractions on top of our own abstractions in our applications. Using Microsoft or 3rd party frameworks is fine when appropriate, but there is generally no need to build your own frameworks, especially within your applications. In the vast majority of cases, {SearchLink:yagni|YAGNI}.

Did I miss something here? Do you have a situation where you feel it is worth it to build a framework, or even part of a framework, within your applications. Please let me know about it {TwitterLink}.
