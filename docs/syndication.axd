<?xml version="1.0" encoding="utf-8"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
  <channel>
    <title>Cognitive Inheritance</title>
    <description>The Application Development Experiences of an Enterprise Developer</description>
    <link>http://www.cognitiveinheritance.com/</link>
    <docs>http://www.rssboard.org/rss-specification</docs>
    <generator>Prehensile Pony Tail 1.0</generator>
    <language>en-US</language>
    <atom:link href="https://cognitiveinheritance.com/syndication.xml" rel="self" type="application/rss+xml" />	
    <item>
  <title>Meta-Abstraction -- You Ain't Gonna Need It!</title>
  <description>&lt;blockquote&gt;
&lt;p&gt;When we look at the abstractions in our applications, we should see a description of the capabilities of our applications, not the capabilities of the abstraction&lt;/p&gt;
&lt;/blockquote&gt;
&lt;p&gt;Let’s start this discussion by looking at an example of a simple repository.&lt;/p&gt;
&lt;div class=&quot;lang-csharp editor-colors&quot;&gt;&lt;div style=&quot;color:Black;background-color:White;&quot;&gt;&lt;pre&gt;
&lt;span style=&quot;color:Blue;&quot;&gt;public&lt;/span&gt; &lt;span style=&quot;color:Blue;&quot;&gt;interface&lt;/span&gt; IMeetingReadRepository
{
    IEnumerable&amp;lt;Meeting&amp;gt; GetMeetings(DateTime start, DateTime end);
}
&lt;/pre&gt;&lt;/div&gt;
&lt;/div&gt;
&lt;p&gt;It is easy to see the capability being described by this abstraction – any implementation of this interface will have the ability to load a collection of Meeting objects that occur within a given timeframe. There are still some unknown details of the implementation, but the capabilities are described reasonably well.&lt;/p&gt;
&lt;p&gt;Now let’s look at a different implementation of the Repository pattern.&lt;/p&gt;
&lt;div class=&quot;lang-csharp editor-colors&quot;&gt;&lt;div style=&quot;color:Black;background-color:White;&quot;&gt;&lt;pre&gt;
&lt;span style=&quot;color:Blue;&quot;&gt;public&lt;/span&gt; &lt;span style=&quot;color:Blue;&quot;&gt;interface&lt;/span&gt; IReadRepository&amp;lt;T&amp;gt;
{
    IEnumerable&amp;lt;T&amp;gt; Get(Func&amp;lt;T, &lt;span style=&quot;color:Blue;&quot;&gt;bool&lt;/span&gt;&amp;gt; predicate);
}
&lt;/pre&gt;&lt;/div&gt;
&lt;/div&gt;
&lt;p&gt;We can still see that something is going to be loaded using this abstraction, we just don’t know what, and we don’t know what criteria will be used.&lt;/p&gt;
&lt;p&gt;This 2nd implementation is a more flexible interface. That is, we can use this interface to describe many different repositories that do many different things. All we have described in this interface is that we have the ability to create something that will load an entity. In other words, we have described our abstraction but said very little about the capabilities of the application itself. In this case, we have to look at a specific implementation to see what it loads, but we still have no idea what criteria can be used to load it.&lt;/p&gt;
&lt;div class=&quot;lang-csharp editor-colors&quot;&gt;&lt;div style=&quot;color:Black;background-color:White;&quot;&gt;&lt;pre&gt;
&lt;span style=&quot;color:Blue;&quot;&gt;public&lt;/span&gt; &lt;span style=&quot;color:Blue;&quot;&gt;class&lt;/span&gt; MeetingReadRepository : IReadRepository&amp;lt;Meeting&amp;gt;
{
    IEnumerable&amp;lt;Meeting&amp;gt; Get(Func&amp;lt;Meeting, &lt;span style=&quot;color:Blue;&quot;&gt;bool&lt;/span&gt;&amp;gt; predicate);
}
&lt;/pre&gt;&lt;/div&gt;
&lt;/div&gt;
&lt;p&gt;We could extend this class with a method that specifically loads meetings by start and end date, but then that method is not on the abstraction so it cannot be used without leaking the details of the implementation to the application.  The only way to implement this pattern in a way that uses the generic interface, but still fully describes the capabilities of the application is to use both methods described above. That is, we implement the specific repository, using the generic repository – layering abstraction on top of abstraction, as shown below.&lt;/p&gt;
&lt;div class=&quot;lang-csharp editor-colors&quot;&gt;&lt;div style=&quot;color:Black;background-color:White;&quot;&gt;&lt;pre&gt;
&lt;span style=&quot;color:Blue;&quot;&gt;public&lt;/span&gt; &lt;span style=&quot;color:Blue;&quot;&gt;interface&lt;/span&gt; IMeetingReadRepository : IReadRepository&amp;lt;Meeting&amp;gt;
{
    IEnumerable&amp;lt;Meeting&amp;gt; GetMeetings(DateTime start, DateTime end);
}

&lt;span style=&quot;color:Blue;&quot;&gt;public&lt;/span&gt; &lt;span style=&quot;color:Blue;&quot;&gt;class&lt;/span&gt; MeetingReadRepository : IMeetingReadRepository
{
    IEnumerable&amp;lt;Meeting&amp;gt; GetMeetings(DateTime start, DateTime end)
        =&amp;gt; Get(m =&amp;gt; m.Start &amp;gt;= start &amp;amp;&amp;amp; m.Start &amp;lt; end)

    &lt;span style=&quot;color:Green;&quot;&gt;// TODO: Implement&lt;/span&gt;
    IEnumerable&amp;lt;Meeting&amp;gt; Get(Func&amp;lt;Meeting, &lt;span style=&quot;color:Blue;&quot;&gt;bool&lt;/span&gt;&amp;gt; predicate)
        =&amp;gt; &lt;span style=&quot;color:Blue;&quot;&gt;throw&lt;/span&gt; &lt;span style=&quot;color:Blue;&quot;&gt;new&lt;/span&gt; NotImplementedException();
}
&lt;/pre&gt;&lt;/div&gt;
&lt;/div&gt;
&lt;p&gt;Is this worth the added complexity? It seems to me that as application developers we should be concerned about describing and building our applications in the simplest, most maintainable and extensible way possible. To do so, we need seams in our applications in the form of abstractions. However, we generally do not need to build frameworks on which we build those abstractions. Framework creation is an entirely other topic with an entirely different set of concerns.&lt;/p&gt;
&lt;p&gt;I think it is easy to see how quickly things can get overly-complex when we start building abstractions on top of our own abstractions in our applications. Using Microsoft or 3rd party frameworks is fine when appropriate, but there is generally no need to build your own frameworks, especially within your applications. In the vast majority of cases, &lt;a href=&quot;https://www.cognitiveinheritance.com/Search/yagni.html&quot;&gt;YAGNI&lt;/a&gt;.&lt;/p&gt;
&lt;p&gt;Did I miss something here? Do you have a situation where you feel it is worth it to build a framework, or even part of a framework, within your applications. Please let me know about it on Twitter &lt;a href=&quot;https://twitter.com/bsstahl&quot;&gt;@bsstahl&lt;/a&gt;.&lt;/p&gt;
</description>
  <link>https://www.cognitiveinheritance.com/Posts/Meta-Abstraction-You-Aint-Gonna-Need-It!.html</link>
  <author>aa88801d-9543-467e-9d7e-8768d2d14aa7@bsstahl.com (Barry S. Stahl)</author>
  <guid>https://www.cognitiveinheritance.com/Permalinks/a9d7154a-2798-4a77-851b-0783b45bc1b4.html</guid>
  <pubDate>Mon, 18 May 2020 15:35:16 GMT</pubDate>
</item><item>
  <title>South Florida Code Camp 2019</title>
  <description>&lt;p&gt;Thanks again to all the organizers, speakers and attendees of the 2019 South Florida Code Camp. As always, it was an amazing and fun experience.&lt;/p&gt;
&lt;p&gt;The slides for my presentation are online &lt;a href=&quot;http://introwasmblazor-201903.azurewebsites.net&quot;&gt;Intro to WebAssembly and Blazor&lt;/a&gt; and the Blazor Chutes &amp;amp; Ladders Simulation sample code can be found in my &lt;a href=&quot;https://github.com/bsstahl/AIDemos&quot;&gt;AIDemos GitHub Repo&lt;/a&gt;.&lt;/p&gt;
</description>
  <link>https://www.cognitiveinheritance.com/Posts/South-Florida-Code-Camp-2019.html</link>
  <author>aa88801d-9543-467e-9d7e-8768d2d14aa7@bsstahl.com (Barry S. Stahl)</author>
  <guid>https://www.cognitiveinheritance.com/Permalinks/ba2507c7-41d6-4e4e-8e65-10c22451edd7.html</guid>
  <pubDate>Sun, 03 Mar 2019 16:47:53 GMT</pubDate>
</item><item>
  <title>Three Awesome Months</title>
  <description>&lt;p&gt;The next few months are going to be absolutely amazing. We&apos;ve got some great events coming up in March and April right here in the Valley of the Sun. In addition, I currently have 4 conferences scheduled in 4 different countries on 2 continents.&lt;/p&gt;
&lt;h4&gt;AZGiveCamp IX - Presented by Quicken Loans - March 8th-10th&lt;/h4&gt;
&lt;p&gt;The most important occasion coming up is the 9th AZGiveCamp Hackathon of Help. This year, we&apos;re very fortunate to have Quicken Loans presenting our event and hosting it at their new facility in downtown Phoenix. At AZGiveCamp, Arizona&apos;s finest technologists will put their skills to work creating software for some great local charity organizations. We help them help our community by using our skills to create tools that help them further their mission.&lt;/p&gt;
&lt;h4&gt;Visual Studio 2019 Arizona Launch - April 16th&lt;/h4&gt;
&lt;p&gt;Another fun event for developers in the valley is the Visual Studio 2019 Arizona Launch event being hosted at Galvanize. We&apos;ll have some great speakers talking about how Visual Studio 2019 is a more productive, modern, and innovative environment for building software.&lt;/p&gt;
&lt;h4&gt;Around the World&lt;/h4&gt;
&lt;p&gt;In March, I&apos;ll be visiting opposite ends of the east coast of North America.&lt;/p&gt;
&lt;p&gt;First, on March 2nd, I&apos;ll be attending the always amazing &lt;a href=&quot;https://sfsdc.itpand.net/&quot;&gt;South Florida Code Camp&lt;/a&gt; in Fort Lauderdale.  This event is right up there with the biggest community conferences in the country and is always worth attending. This will be the 7th year I&apos;ve presented at SoFlaCC. If you&apos;re in the area I hope you&apos;ll attend.&lt;/p&gt;
&lt;p&gt;Later in March, I cross the border into Canada to attend &lt;a href=&quot;https://confoo.ca/en/speaker/barry-stahl&quot;&gt;ConFoo Montreal&lt;/a&gt;. This will be my first trip ever to Montreal so I hope the March weather is kind to this 35 year Phoenix resident.  The event runs from March 13th - 15th and there will be 2 Canadiens games during the time I am there so I should be able to get to at least one of them.&lt;/p&gt;
&lt;p&gt;In May I get to do a short tour of Europe, spending 2 weeks at conferences in Budapest, Hungary (&lt;a href=&quot;https://craft-conf.com&quot;&gt;Craft Conference&lt;/a&gt;), and Marbella, Spain (&lt;a href=&quot;https://jonthebeach.com/&quot;&gt;J on the Beach&lt;/a&gt;).  While I have done some traveling in Europe before, I have never been to Spain or Hungary so I am really looking forward to experiencing the history and culture that these two cities have to offer.&lt;/p&gt;
&lt;h4&gt;Keep up With Me&lt;/h4&gt;
&lt;p&gt;I maintain a list of my presentations, both past and upcoming, on the &lt;a href=&quot;https://www.cognitiveinheritance.com/Pages/Speaking-Engagements.html&quot;&gt;Community Speaker&lt;/a&gt; page of this blog. I also try to document my conference experiences on Twitter &lt;a href=&quot;https://twitter.com/bsstahl&quot;&gt;@bsstahl&lt;/a&gt;. If you are going to be attending any of these events, please be sure to ping me on Twitter and let me know.&lt;/p&gt;
</description>
  <link>https://www.cognitiveinheritance.com/Posts/Three-Awesome-Months.html</link>
  <author>aa88801d-9543-467e-9d7e-8768d2d14aa7@bsstahl.com (Barry S. Stahl)</author>
  <guid>https://www.cognitiveinheritance.com/Permalinks/7d652a10-6e7d-43d9-adb0-fbfce01e46db.html</guid>
  <pubDate>Tue, 26 Feb 2019 04:57:21 GMT</pubDate>
</item><item>
  <title>The Value of Flexibility</title>
  <description>&lt;p&gt;Have you ever experienced that feeling you get when you need to extend an existing system and there is an extension point that is exactly what you need to build on?&lt;/p&gt;
&lt;p&gt;For example, suppose I get a request to extend a system so that an additional action is taken whenever a new user signs-up.  The system already has an event message that is published whenever a new user signs-up that contains all of the information I need for the new functionality.  All I have to do is subscribe a new microservice to this event message, and have that service take the new action whenever it receives a message. Boom! Done.&lt;/p&gt;
&lt;p&gt;Now think about the converse. The many situations we’ve all experienced where there is no extension point. Or maybe there is an extension mechanism in place but it isn’t quite right; perhaps an event that doesn’t fire on exactly the situation you need, or doesn’t contain the data you require for your use case and you have to build an entirely new data support mechanism to get access to the bits you need.&lt;/p&gt;
&lt;blockquote&gt;
&lt;p&gt;The cost to &quot;go live&quot; is only a small percentage of the lifetime total cost of ownership. – Andy Kyte for Gartner Research, 30 March 2010&lt;/p&gt;
&lt;/blockquote&gt;
&lt;p&gt;There are some conflicting principles at work here, but for me, these situations expose the critical importance of flexibility and extensibility in our application architectures.  After all, maintenance and extension are the two greatest costs in a typical application’s life-cycle. I don’t want to build things that I don’t yet need because the likelihood is that I will never need them (see &lt;a href=&quot;https://www.cognitiveinheritance.com//Search/yagni.html&quot;&gt;YAGNI&lt;/a&gt;). However, I don’t want to preclude myself from building things in the future by making decisions that cripple flexibility. I certainly don’t want to have to do a full system redesign ever time I get a new requirement.&lt;/p&gt;
&lt;p&gt;For me, this leads to a principle that I like to follow:&lt;/p&gt;
&lt;blockquote&gt;
&lt;p&gt;I value &lt;strong&gt;Flexibility&lt;/strong&gt; over &lt;strong&gt;Optimization&lt;/strong&gt;&lt;/p&gt;
&lt;/blockquote&gt;
&lt;p&gt;As with the principles described in the Agile Manifesto that this is modeled after, this does not eliminate the item on the right in favor of the item on the left, it merely states that the item on the left is valued more highly.  This makes a ton of sense to me in this case because it is much easier to scale an application by adding instances, especially in these heady days of cloud computing, than it is to modify and extend it. I cannot add a feature by adding another instance of a service, but I can certainly overcome a minor or even moderate inefficiency by doing so. Of course, there is a cost to that as well, but typically that cost is far lower, especially in the short term, than the cost of maintenance and extension.&lt;/p&gt;
&lt;p&gt;So, how does this manifest (see what I did there?) in practical terms?&lt;/p&gt;
&lt;p&gt;For me, it means that I allow seams in my applications that I may not have a functional use for just yet. I may not build anything on those seams, but they exist and are available for use as needed. These include:&lt;/p&gt;
&lt;ul&gt;
&lt;li&gt;Separating the tiers of my applications for loose-coupling using the Strategy and Repository patterns&lt;/li&gt;
&lt;li&gt;Publishing events in event-driven systems whenever it makes sense, regardless of the number of subscriptions to that event when it is created&lt;/li&gt;
&lt;li&gt;Including all significant data in event messages rather than just keys&lt;/li&gt;
&lt;/ul&gt;
&lt;p&gt;There are, of course, dangers here as well. It can be easy to fire events whenever we would generally issue a logging message.  Events should be limited to those in the problem domain (Domain Events), not application events. We can also reach a level of absurdity with the weight of each message. As with all things, a balance needs to be struck. In determining that balance, I value Flexibility over Optimization whenever it is reasonable and possible to do so.&lt;/p&gt;
&lt;p&gt;Do you feel differently? If so, let me know on Twitter &lt;a href=&quot;https://twitter.com/bsstahl&quot;&gt;@bsstahl&lt;/a&gt;.&lt;/p&gt;
</description>
  <link>https://www.cognitiveinheritance.com/Posts/The-Value-of-Flexibility.html</link>
  <author>aa88801d-9543-467e-9d7e-8768d2d14aa7@bsstahl.com (Barry S. Stahl)</author>
  <guid>https://www.cognitiveinheritance.com/Permalinks/578752d7-225b-4510-8de2-2c35ded2eb84.html</guid>
  <pubDate>Thu, 14 Feb 2019 16:31:05 GMT</pubDate>
</item><item>
  <title>Back to Basics–the Double Data Type</title>
  <description>&lt;p&gt;What is the result of converting a value that is close to, but not at, the maximum value of an Int64 from a double to a long (Int64)?  That is, what would be the result of an expression like:&lt;/p&gt;
&lt;p&gt;&lt;code&gt;(long)((double)(Int64.MaxValue – 1))&lt;/code&gt;&lt;/p&gt;
&lt;ol&gt;
&lt;li&gt;9223372036854775806 (2&lt;sup&gt;63&lt;/sup&gt;-2, the correct value numerically)&lt;/li&gt;
&lt;li&gt;-9223372036854775808 or another obviously incorrect value&lt;/li&gt;
&lt;li&gt;OverflowException&lt;/li&gt;
&lt;li&gt;Any of the above&lt;/li&gt;
&lt;/ol&gt;
&lt;p&gt;Based on the framing of the question it is probably clear that the correct answer is &amp;quot;D&amp;quot;. It is possible, depending on the hardware details and current state of your system, for any of the 3 possible outcomes.  Why is this and what can we do to be sure that the results of our floating-point operations are what we expect them to be?&lt;/p&gt;
&lt;p&gt;Before we go into the ways we can modify the behavior of our operations, let&apos;s take a look at the two data types in question, &lt;strong&gt;Int64&lt;/strong&gt; and &lt;strong&gt;Double&lt;/strong&gt;.&lt;/p&gt;
&lt;p&gt;An Int64 value, also known as a long, is a fairly straightforward storage mechanism that uses 63 bits for the value and 1 bit to represent the sign.  Negative numbers are stored in twos-complement form to make mathematical operations simpler.  The result is that the Int64 type can store, with perfect fidelity, any integral value between -9223372036854775808 and 9223372036854775807.&lt;/p&gt;
&lt;p&gt;The Double data type on the other hand is far more complex. It requires storage for continuous values, not just integers. As a result, the Double data type uses 52 bits to store the mantissa (value), 11 bits to store the exponent (order of magnitude) and the remaining bit of the 64-bit structure to store the sign. Both the exponent and mantissa are shifted by a few bits based on some fairly safe assumptions.  This gives us a range of values for the exponent of -1023 to 1024 and a little more than 52 bits of fidelity in the mantissa.&lt;/p&gt;
&lt;p&gt;It is this difference in fidelity; 63 bits for Int64 and roughly 52 bits for Doubles, that can cause us problems when converting between the two types.  As long as the integer value can be stored in less than 52 bits (value &amp;lt; 4503599627370495) values can be converted back and forth between Int64 and Double without any data loss. However, as soon as the values cannot be represented completely in 52 bits, data loss is likely to occur.&lt;/p&gt;
&lt;p&gt;To store such a value in a Double data type, the exponent is adjusted higher and the best available value for the mantissa is found.  When converted back to Int64, this value will be rounded automatically by the framework into the closest integer value. This resulting value may, or may not, be exactly the same as the original value.  To see an example of this, execute the following code in your favorite C# environment:&lt;/p&gt;
&lt;p&gt;&lt;code&gt;Console.WriteLine((long)9223372036854773765.0);&lt;/code&gt;&lt;/p&gt;
&lt;p&gt;If your system is like mine, you’ll get an answer that is not the same as the original value. On my system, I get the result &lt;strong&gt;9223372036854773760&lt;/strong&gt;. It is said that this integer does not &quot;round-trip&quot; since it cannot be converted into a Double and then back to an integer.&lt;/p&gt;
&lt;p&gt;To make matters worse, the rounding that is required for this conversion can be unsafe under certain conditions. On my machine, if the values get within 512 of Int64.MaxValue, even though they don’t exceed it, attempting the conversion may result in an invalid result, or an &lt;strong&gt;OverflowException&lt;/strong&gt;. Even performing the operation without overflow checking using the &lt;strong&gt;unchecked&lt;/strong&gt; keyword or compiler switch doesn&apos;t improve things since, if done unchecked, any overflow in the operation will result in an incorrect value rather than an exception. I prefer the exception in this kind of situation so I generally keep overflow checking on.&lt;/p&gt;
&lt;p&gt;The key takeaway for me is that just checking to make certain that a Double value is less than Int64.MaxValue is not enough to guarantee it will convert without error, and certainly does not guarantee the accuracy of any such conversion. Only integer values below 52 bits can be accurately converted into Int64 values.&lt;/p&gt;
&lt;p&gt;It is always best to avoid type conversions if possible, but if you are in a situation where it is necessary to convert from large Double values into Integers, I recommend trying some experiments in your production environment to see what range of values will convert accurately. I also highly recommend including very large integers, approaching or at Int64.MaxValue as test data against any method that accepts Int64 values.  Values that are very large in the negative direction (nearing Int64.MinValue) are also good candidates to be used as test data in these methods.&lt;/p&gt;
&lt;p&gt;I’ve attached a number of resources below that I used in my research to produce this article, and to fix the bug I caused doing this kind of conversion.  If you have run into this situation and come up with an interesting way of handling it, or if the results of your conversions are different than mine, please let me know about it on Twitter &lt;a href=&quot;https://twitter.com/bsstahl&quot;&gt;@bsstahl&lt;/a&gt;.&lt;/p&gt;
&lt;h2&gt;Resources&lt;/h2&gt;
&lt;ul&gt;
&lt;li&gt;&lt;a href=&quot;https://docs.microsoft.com/en-us/dotnet/api/system.double?view=netcore-2.2&quot;&gt;Double Struct&lt;/a&gt; in the .NET API Browser&lt;/li&gt;
&lt;li&gt;&lt;a href=&quot;https://docs.microsoft.com/en-us/dotnet/api/system.convert.toint64?view=netcore-2.2#System_Convert_ToInt64_System_Double_&quot;&gt;Convert.ToInt64 method&lt;/a&gt; in the .NET API Browser&lt;/li&gt;
&lt;li&gt;&lt;a href=&quot;https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/floating-point-numeric-types&quot;&gt;double data type&lt;/a&gt; in the C# Language Reference&lt;/li&gt;
&lt;li&gt;John Skeet on &lt;a href=&quot;https://csharpindepth.com/Articles/General/FloatingPoint.aspx?printable=true&quot;&gt;Binary floating point numbers in .NET&lt;/a&gt;&lt;/li&gt;
&lt;li&gt;John Skeet’s &lt;a href=&quot;https://jonskeet.uk/csharp/DoubleConverter.cs&quot;&gt;code to convert doubles to the string representation of their exact decimal value&lt;/a&gt;&lt;/li&gt;
&lt;/ul&gt;
</description>
  <link>https://www.cognitiveinheritance.com/Posts/Back-to-Basicse28093the-Double-Data-Type.html</link>
  <author>aa88801d-9543-467e-9d7e-8768d2d14aa7@bsstahl.com (Barry S. Stahl)</author>
  <guid>https://www.cognitiveinheritance.com/Permalinks/c2b6a683-a9cf-4fce-96c1-5401648c056e.html</guid>
  <pubDate>Tue, 12 Feb 2019 02:55:23 GMT</pubDate>
</item><item>
  <title>Developer on Fire</title>
  <description>&lt;p&gt;I was recently interviewed by Dave Rael (&lt;a href=&quot;https://twitter.com/raelyard&quot;&gt;@raelyard&lt;/a&gt;) for his &lt;a href=&quot;https://developeronfire.com/podcast/episode-399-barry-stahl-optimizing-impact&quot;&gt;Developer on Fire Podcast&lt;/a&gt;.  I had a great time talking with Dave about a lot of different things, both professional and personal, and got to name-drop just a few of the many people who have been a part of my journey over the years.&lt;/p&gt;
&lt;p&gt;I also took the opportunity to talk about a few things that have been on my mind:&lt;/p&gt;
&lt;ul&gt;
&lt;li&gt;The upcoming &lt;a href=&quot;https://www.meetup.com/azgivecamp&quot;&gt;AZGiveCamp&lt;/a&gt; Event scheduled for March 2019&lt;/li&gt;
&lt;li&gt;Some of &lt;a href=&quot;https://twitter.com/bsstahl/status/878043411923599360&quot;&gt;the giants on whose shoulders we stand&lt;/a&gt;&lt;/li&gt;
&lt;li&gt;A few of the technologies that are making me happy right now:
&lt;ul&gt;
&lt;li&gt;&lt;a href=&quot;https://webassembly.org/&quot;&gt;WebAssembly&lt;/a&gt; and &lt;a href=&quot;https://dotnet.microsoft.com/apps/aspnet/web-apps/blazor&quot;&gt;Blazor&lt;/a&gt;&lt;/li&gt;
&lt;li&gt;&lt;a href=&quot;https://www.cognitiveinheritance.com/Search/ai.html&quot;&gt;AI, Combinatorial Optimization and Genetic Algorithms&lt;/a&gt;&lt;/li&gt;
&lt;/ul&gt;
&lt;/li&gt;
&lt;li&gt;A couple of resources I learn from:
&lt;ul&gt;
&lt;li&gt;&lt;a href=&quot;https://brilliant.org&quot;&gt;brilliant.org&lt;/a&gt;&lt;/li&gt;
&lt;li&gt;The works of &lt;a href=&quot;http://davidmcraney.com/&quot;&gt;David McRaney&lt;/a&gt;&lt;/li&gt;
&lt;/ul&gt;
&lt;/li&gt;
&lt;/ul&gt;
&lt;p&gt;I hope you enjoy this interview and find something of value in it. If so, please let me know about it on Twitter &lt;a href=&quot;https://twitter.com/bsstahl&quot;&gt;@bsstahl&lt;/a&gt;.&lt;/p&gt;
&lt;p&gt;&lt;a href=&quot;https://developeronfire.com/podcast/episode-399-barry-stahl-optimizing-impact&quot;&gt;&lt;img src=&quot;https://www.cognitiveinheritance.com/Images/DeveloperOnFire_1.png&quot; alt=&quot;Developer On Fire&quot; /&gt;&lt;/a&gt;&lt;/p&gt;
</description>
  <link>https://www.cognitiveinheritance.com/Posts/Developer-on-Fire.html</link>
  <author>aa88801d-9543-467e-9d7e-8768d2d14aa7@bsstahl.com (Barry S. Stahl)</author>
  <guid>https://www.cognitiveinheritance.com/Permalinks/88996646-da47-4325-a45e-3c2e2446ba9e.html</guid>
  <pubDate>Thu, 13 Dec 2018 21:39:17 GMT</pubDate>
</item><item>
  <title>SoCalCodeCamp Slide Decks</title>
  <description>&lt;p&gt;The slide decks for my two talks at SoCalCodeCamp USC from November 10, 2018 are below.&lt;/p&gt;
&lt;ul&gt;
&lt;li&gt;&lt;a href=&quot;https://1drv.ms/b/s!AMwbHpz53UVdm45C&quot;&gt;Intro to WebAssembly Using Blazor&lt;/a&gt; – SGM-124 at 1:30 pm&lt;/li&gt;
&lt;li&gt;&lt;a href=&quot;https://1drv.ms/b/s!AswbHpz53UVdm48YGGXqRVK0KTiOJA&quot;&gt;Building .NET Applications for any Cloud with Cloud Foundry&lt;/a&gt; – GFS-207 at 4:00 pm&lt;/li&gt;
&lt;/ul&gt;
&lt;p&gt;Thanks to all of the organizers and attendees of this always amazing event.&lt;/p&gt;
</description>
  <link>https://www.cognitiveinheritance.com/Posts/SoCalCodeCamp-Slide-Decks.html</link>
  <author>aa88801d-9543-467e-9d7e-8768d2d14aa7@bsstahl.com (Barry S. Stahl)</author>
  <guid>https://www.cognitiveinheritance.com/Permalinks/135fbe81-8ec5-42ad-8ac7-6fac74cdf4f4.html</guid>
  <pubDate>Sat, 10 Nov 2018 19:39:46 GMT</pubDate>
</item><item>
  <title>AZGiveCamp IX-Save the Date</title>
  <description>&lt;blockquote&gt;
&lt;p&gt;March 8th–10th 2019&lt;/p&gt;
&lt;/blockquote&gt;
&lt;p&gt;&lt;img src=&quot;https://www.cognitiveinheritance.com//Images/Code%20Monkey%203%20Duckin%20it%20(1)_1.png&quot; alt=&quot;Code Monkey Duckin-It&quot; /&gt;&lt;/p&gt;
&lt;p&gt;Mark your calendars to block-out the weekend of March 8th 2019 for the next AZGiveCamp Hackathon-of-Help. More details will be coming very soon so keep an eye on &lt;a href=&quot;https://www.azgivecamp.org/&quot;&gt;AZGiveCamp.org&lt;/a&gt; and &lt;a href=&quot;https://www.meetup.com/azgivecamp&quot;&gt;Meetup&lt;/a&gt; for all the particulars as soon as they are available.  I’m looking forward to seeing you all at our 9th event, helping those who help our community.&lt;/p&gt;
</description>
  <link>https://www.cognitiveinheritance.com/Posts/Save-the-Date-for-AZGiveCamp-IX.html</link>
  <author>aa88801d-9543-467e-9d7e-8768d2d14aa7@bsstahl.com (Barry S. Stahl)</author>
  <guid>https://www.cognitiveinheritance.com/Permalinks/c6b4c9e8-b82c-4fd2-b73d-c230671d66ec.html</guid>
  <pubDate>Wed, 31 Oct 2018 03:10:44 GMT</pubDate>
</item><item>
  <title>Intro to WebAssembly Using Blazor</title>
  <description>&lt;p&gt;I will be speaking tonight, 9/26/2018 at the &lt;a href=&quot;https://www.meetup.com/NWVDNUG/events/254835128/&quot;&gt;Northwest Valley .NET User Group&lt;/a&gt; and tomorrow, 9/27/2018 at the &lt;a href=&quot;https://www.meetup.com/sevdnug/events/254838096/&quot;&gt;Southeast Valley .NET User Group&lt;/a&gt;. I will be speaking on the subject of WebAssembly. The talk will go into what WebAssembly programs look and act like, and how they run, then explore how we as .NET developers can write WebAssembly programs with Microsoft’s experimental platform, Blazor.&lt;/p&gt;
&lt;blockquote&gt;
&lt;p&gt;Want to run your .NET Standard code directly in the browser on the client-side without the need for transpilers or browser plug-ins? Well, now you can with WebAssembly and Blazor.&lt;/p&gt;
&lt;p&gt;WebAssembly (WASM) is the W3C specification that will be used to provide the next generation of development tools for the web and beyond. Blazor is Microsoft&apos;s experiment that allows ASP.Net developers to create web pages that do much of the scripting work in C# using WASM.&lt;/p&gt;
&lt;p&gt;Come join us as we explore the basics of WebAssembly and how WASM can be used to run existing C# code client side in the browser. You will walk away with an understanding of what WebAssembly and Blazor can do for you and how to immediately get started running your own .NET code in the browser.&lt;/p&gt;
&lt;/blockquote&gt;
&lt;p&gt;The slide deck for these presentations can be found here &lt;a href=&quot;https://1drv.ms/b/s!AMwbHpz53UVdm45C&quot;&gt;IntroToWasmAndBlazor-201809.pdf&lt;/a&gt;.&lt;/p&gt;
</description>
  <link>https://www.cognitiveinheritance.com/Posts/Intro-to-WebAssembly-Using-Blazor.html</link>
  <author>aa88801d-9543-467e-9d7e-8768d2d14aa7@bsstahl.com (Barry S. Stahl)</author>
  <guid>https://www.cognitiveinheritance.com/Permalinks/357b8c8b-e115-4aad-9534-6f1f80a17fa2.html</guid>
  <pubDate>Wed, 26 Sep 2018 18:12:49 GMT</pubDate>
</item><item>
  <title>Programmers -- Take Responsibility for Your AI’s Output</title>
  <description>&lt;blockquote&gt;
&lt;p&gt;&lt;strong&gt;plus ça change, plus c&apos;est la même chose&lt;/strong&gt; – &lt;strong&gt;The more that things change, the more they stay the same&lt;/strong&gt;. – Rush (and others &lt;img src=&quot;https://www.cognitiveinheritance.com//Images/wlEmoticon-winkingsmile.png&quot; alt=&quot;Winking smile&quot; /&gt; )&lt;/p&gt;
&lt;/blockquote&gt;
&lt;p&gt;In 2013 I &lt;a href=&quot;https://www.cognitiveinheritance.com/Posts/Programmers-Take-Responsibility-for-Your-Programe28099s-Output.html&quot;&gt;wrote&lt;/a&gt; that programmers needed to take responsibility for the output of their computer programs.  In that article, I advised developers that the output of their system, no matter how &quot;random&quot; or &quot;computer generated&quot;, was still their responsibility. I suggested that we cannot cop out by claiming  that the output of our programs is not our fault simply because we didn’t directly instruct the computer to issue that specific result.&lt;/p&gt;
&lt;p&gt;Today, we have a similar problem, only the stakes are much, much, higher.&lt;/p&gt;
&lt;p&gt;In the world of 2018, our algorithms are being used in police work and inside other government agencies to know where and when to deploy resources, and to decide who is and isn’t worthy of an opportunity. Our programs are being used in the private sector to make decisions from trading stocks to hiring, sometimes at a scale and speed that puts us all at risk of economic events. These tools are being deployed by information brokers such as Facebook and Google to make predictions about how best to steal the most precious resource we have, our time.  Perhaps scariest of all, these algorithms may be being used to make decisions that have permanent and irreversible results, such as with drone strikes.  We  simply have no way of knowing the full breadth of decisions that AIs are making on our behalf today.  If those algorithms are biased in any way, the decisions made by these programs will be biased, potentially in very serious ways and with serious results.&lt;/p&gt;
&lt;blockquote&gt;
&lt;p&gt;If we take all available steps to recognize and eliminate the biases in our systems, we can minimize the likelihood of our tools producing output that we did not expect or that violates our principles.&lt;/p&gt;
&lt;/blockquote&gt;
&lt;p&gt;All of the machines used to execute these algorithms are bias-free of course.  A computer has no prejudices and no desires of its own.  However, as we all know, decision-making  tools learn what we teach them.  We cannot completely teach these algorithms free of our own biases.  It simply cannot be done since all of our data is colored by our existing biases.  Perhaps the best known example of bias in our data is in crime data used for policing. If we send police to where there is most often crime, we will be sending them to the same places we’ve sent them in the past, since generally, crime involves having a police office in the location to make an arrest. Thus, any biases we may have had in the past about where to send police officers, will be represented in our data sets about crime.&lt;/p&gt;
&lt;p&gt;While we may never be able to eliminate biases completely, there are things that we can do to minimize the impact of the biases we are training into our algorithms.  If we take all available steps to recognize and eliminate the biases in our systems, we can minimize the likelihood of our tools producing output that we did not expect or that violates our principles.&lt;/p&gt;
&lt;h5&gt;Know that the algorithm is biased&lt;/h5&gt;
&lt;p&gt;We need to accept the fact that there is no way to create a completely bias-free algorithm.  Any dataset we provide to our tools will inherently have some bias in it.  This is the nature of our world.  We create our datasets based on history and our history, intentionally or not, is full of bias.  All of our perceptions and understandings are colored by our cognitive biases, and the same is true for the data we create as a result of our actions.  By knowing and accepting this fact, that our data is biased, and therefore our algorithms are biased, we take the first step toward neutralizing the impacts of those biases.&lt;/p&gt;
&lt;h5&gt;Predict the possible biases&lt;/h5&gt;
&lt;p&gt;We should do everything we can to predict what biases may have crept into our data and how they may impact the decisions the model is making, even if that bias is purely theoretical.  By considering what biases could potentially exist, we can watch for the results of those biases, both in an automated and manual fashion.&lt;/p&gt;
&lt;h5&gt;Train &quot;fairness&quot; into the model&lt;/h5&gt;
&lt;p&gt;If a bias is known to be present in the data, or even likely to be present, it can be accounted for by defining what an unbiased outcome might look like and making that a training feature of the algorithm.  If we can reasonably assume that an unbiased algorithm would distribute opportunities among male and female candidates at the same rate as they apply for the opportunity, then we can constrain the model with the expectation that the rate of  accepted male candidates should be within a statistical tolerance of  the rate of male applicants.  That is, if half of the applicants are men then men should receive roughly half of the opportunities.  Of course, it will not be nearly this simple to define fairness for most algorithms, however every effort should be made.&lt;/p&gt;
&lt;h5&gt;Be Open About What You’ve Built&lt;/h5&gt;
&lt;p&gt;The more people understand how you’ve examined your data, and the assumptions you’ve made, the more confident they can be that anomalies in the output are not a result of systemic bias. This is the most critical when these decisions have significant consequences to peoples’ lives.  A good example is in prison sentencing. It is unconscionable to me that we allow black-box algorithms to make sentencing decisions on our behalf.  These models should be completely transparent and subject to our analysis and correction.  That they aren’t, but are still being used by our governments, represent a huge breakdown of the system, since these decisions MUST be made with the trust and at the will of the populace.&lt;/p&gt;
&lt;h5&gt;Build AIs that Provide Insight Into Results (when possible)&lt;/h5&gt;
&lt;p&gt;Many types of AI models are completely opaque when it comes to how decisions are reached.  This doesn’t mean however that all of our AIs must be complete black-boxes.  It is true that  most of the common machine learning methods such as Deep-Neural-Networks (DNNs) are extremely difficult to analyze.  However, there are other types of models that are much more transparent when it comes to decision making.  Some model types will not be useable on all problems, but when the options exist, transparency should be a strong consideration.&lt;/p&gt;
&lt;p&gt;There are also techniques that can be used to make even opaque models more transparent.  For example, a hybrid technique (&lt;a href=&quot;https://www.cognitiveinheritance.com/Posts/AI-That-Can-Explain-Why.html&quot;&gt;AI That Can Explain Why&lt;/a&gt; &amp;amp; &lt;a href=&quot;https://www.cognitiveinheritance.com/Posts/An-Example-of-a-Hybrid-AI-Implementation.html&quot;&gt;An Example of a Hybrid AI Implementation&lt;/a&gt;) can be used to run opaque models iteratively.  This can allow the developer to log key details at specific points in the process, making the decisions much more transparent.  There are also techniques to manipulate the data after a decision is made, to gain insight into the reasons for the decision.&lt;/p&gt;
&lt;h5&gt;Don’t Give the AI the Codes to the Nukes&lt;/h5&gt;
&lt;p&gt;Computers should never be allowed to make automated decisions that cannot be reversed by a human if necessary. Decisions like when to attack a target, execute a criminal, vent radioactive waste, or ditch an aircraft are all decisions that require human verification since they cannot be undone if the model has an error or is faced with  a completely unforeseen set of conditions. There are no circumstances where machines should be making such decisions for us without the opportunity for human intervention, and it is up to us, the programmers, to make sure that we don’t give them that capability.&lt;/p&gt;
&lt;h5&gt;Don’t Build it if it Can’t be Done Ethically&lt;/h5&gt;
&lt;p&gt;If we are unable to come up with an algorithm that is free from bias, perhaps the situation is not appropriate for an automated decision making process.  Not every situation will warrant an AI solution, and it is very likely that there are decisions that should always be made by a human in totality.  For those situations, a decision support system may be a better solution.&lt;/p&gt;
&lt;h4&gt;The Burden is Ours&lt;/h4&gt;
&lt;p&gt;As the creators of automated decision making systems, we have the responsibility to make sure that the decisions they make do not violate our standards or ethics.  We cannot depend on our AIs to make fair and reasonable decisions unless we program them to do so, and programming them to avoid inherent biases requires an awareness and openness that has not always been present.  By taking the steps outlined here to be aware of the dangers and to mitigate it wherever possible, we have a chance of making decisions that we can all be proud of, and have confidence in.&lt;/p&gt;
</description>
  <link>https://www.cognitiveinheritance.com/Posts/Programmers-Take-Responsibility-for-Your-AIe28099s-Output.html</link>
  <author>aa88801d-9543-467e-9d7e-8768d2d14aa7@bsstahl.com (Barry S. Stahl)</author>
  <guid>https://www.cognitiveinheritance.com/Permalinks/686f1de9-562f-4ef5-a3ac-4a75da9373f8.html</guid>
  <pubDate>Fri, 16 Mar 2018 03:22:42 GMT</pubDate>
</item>
</channel>
</rss>