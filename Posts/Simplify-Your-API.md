---
tags:
- api
- coding practices
- code sample
- development
- generics
- presentation
- services
- skill
- SOA
- speaking
- visual studio
menuorder: 0
id: 09a68c70-e4bc-494b-852b-e067b55c00e1
author: bsstahl
title: Simplify Your API
description: 
ispublished: true
showinlist: false
publicationdate: 2015-10-12T13:15:00
lastmodificationdate: 2015-10-12T16:17:48
slug: Simplify-Your-API
categoryids:
- categoryid: da73f25e-343d-4a0e-9b28-1d76e8fd99bf

---

If you are building an API for other Developers to use, you will find out two things very quickly:

1. Developers don't read documentation (you probably already know this).
2. If your API depends on its documentation to get developers to understand and discover its features, it is likely that it will not be used.


Fortunately, there are some simple mechanisms for wrapping complex APIs and making their functionality both easy to use, and highly discoverable. An API that uses tools like IntelliSense in Visual Studio to make its features discoverable by the downstream developer is far more likely to be adopted then one that doesn't. In recent years, additions to the C# language have made creating a Domain Specific Language that uses a fluent syntax for nearly any API into a simple process.

#### Create the Context

The 1st step in simplifying any API is to provide a single starting point for the downstream developer to interact with. In most cases, the best practice is to use the façade pattern to define a context that holds our entity collections. Each collection of entities becomes a property on the context object. These properties all return an IQueryable&lt;Entity&gt;. For example, in the EnumerableStack demo solution on GitHub ([https://github.com/bsstahl/SimpleAPI](https://github.com/bsstahl/SimpleAPI)), I created an object Bss.EnumerableStack.Data.EnumerableStack to provide this functionality. It has two properties, Posts and Questions, each of which returns an IQueryable&lt;Post&gt;. It is these properties that will be used to access the data from our API.

The context object, on top of becoming the single point of entry for downstream developers, also hides any complexities in the construction logic of the underlying data source. That is, if there is any configuration or other setup required to access the upstream data provider (such as web service access or database connections), much of the complexity of that construction can be hidden from the API user. A good example of this can be seen in the FluentStack demo solution from the same GitHub repository. There, the Bss.FluentStack.Data.OData.FluentStack context object wraps the functionality of constructing the connection to the StackOverflow OData web service.

#### Extend Our Language

Now that we have data to access, it's time for us to extend our domain specific language to provide tools to make accessing this data simpler for the API caller. We can use Extension methods on IQueryable&lt;Entity&gt; to create custom filters for our data. By creating extension methods that accept IQueryable&lt;Entity&gt; as a parameter and return the same, we can create methods that can be chained together to form a fluent syntax that will perform complex filtering. For example, in the EnumerableStack solution , the Questions, WithAcceptedAnswer and TaggedWith methods found in the Bss.EnumerableStack.Data.Extensions module, can all be used to execute queries on the data exposed by the properties of our context object, as shown below:

`var results = new EnumerableStack().Posts.WithAcceptedAnswer().TaggedWith("odata");`

In this case, both the WithAcceptedAnswer and TaggedWith filters are applied to the data. The best part about these methods are that they are visible in Intellisense (once the namespace has been brought into scope with a Using statement) making the functionality easy to discover and use.

Another big advantage of creating these extension methods is that they can hide the complexity of the lower level API. Here, the WithAcceptedAnswer method is wrapping a where clause that filters for those posts that have an AcceptedAnswerId property that is non-null. It may not be obvious to a downstream API consumer that the definition of a post with an "accepted answer" is one where the AcceptedAnswerId has a value. Our API hides that implementation detail and allows the consumer to simply request what is needed. Similarly, the TaggedWith method hides the fact that the StackOverflow API stores tags in lower-case, within angle-brackets, and with all tags on a post joined into a single string. To search for tags, the consumer would need to know this, and take all appropriate actions when searching for a tag if we didn't hide that complexity in the TaggedWith method.

#### Simplify Query Predicates

A predicate is a function that accepts an entity as a parameter, and returns a boolean value. These functions are often used in the Where clause of a query to indicate which objects should be included in the result set. For example, in the query below

`var results = new EnumerableStack().Posts.Where(p => p.Parent == null);`

the function expression p =&gt; p.Parent == null is a predicate that returns true if the Parent property of the entity is null. For each entity passed to the function, the value of that property is tested, and if null, the entity is included in the results of the query. Here we are using a Lambda Expression to provide a delegate to our function. One of the coolest things about Linq is that we can now represent this expression in a variable of type Expression&lt;Func&lt;Entity, bool&gt;&gt;, that is, a Lambda expression of a function that takes an Entity and returns a boolean. This is pretty awesome because if we can store it in a variable, we can pass it around and enable extension methods like this one, as found in the Asked class of the Bss.EnumerableStack.Data library:
 `public static Expression<Func<Post, bool>> InLast(TimeSpan span)
   {
   return p => p.CreationDate > DateTime.UtcNow.Subtract(span);
   }`
This method accepts a TimeSpan object and returns the Lambda Expression type useable as a predicate. The input TimeSpan is subtracted from the current DateTime UTC value, and compared to the CreationDate property of a Post entity. If the creation date of the Post is later than 30-days prior to the current date, the function returns true. Since this InLast method is static on a class called Asked, we can use it like this:

`var results = new EnumerableStack().Questions.Where(Asked.InLast(TimeSpan.FromDays(30));`

Which will return questions that were asked in the last 30 days. This becomes even simpler to understand if we add a method extending Int called Days that returns a Timespan, like this:
`public static TimeSpan Days(this int value)
   {
   return TimeSpan.FromDays(value);
   }`
allowing our expression to become:

`var results = new EnumerableStack().Questions.Where(Asked.InLast(30.Days());`

#### Walking through the Process

In my conference sessions, Simplify Your API: Creating Maintainable and Discoverable Code, I walk through this process on the FluentStack demo code. We take a query created against the StackOverflow OData API that starts off looking like this:
`var questions = new StackOverflowService.Entities(new Uri(_serviceRoot))
   .Posts.Where(p => p.Parent == null && p.AcceptedAnswerId != null
   && p.CreationDate > DateTime.UtcNow.Subtract(TimeSpan.FromDays(30))
   && p.Tags.Contains("<odata>"));`
and convert it, one step at a time, to this:
`var questions = new FluentStack().Questions.WithAcceptedAnswer().
   Where(Asked.InLast(30.Days)).TaggedWith("odata");`
a query that is much simpler, easier to understand, easier to create and easier to maintain. The sample code on GitHub, referenced above, and available at [http://github.com/bsstahl/SimpleAPI](http://github.com/bsstahl/SimpleAPI), contains the FluentStack.sln example which shows how to simplify an API created with an OData source. It also contains the EnumerableStack.sln project which walks through the same process on a purely enumerable data source, that is, an implementation that will work with any collection.

#### Sound Off

Have you used these tools to simplify an API for downstream programmers? Do you have other techniques that you use to do the same, similar, or additional things to make your APIs better? If so, Tweet it to me [@bsstahl](http://twitter.com/bsstahl) and let's keep the conversation going.

