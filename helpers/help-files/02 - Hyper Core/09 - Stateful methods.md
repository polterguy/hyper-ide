## Stateful web methods

Although the web was arguably built to have your web server be completely stateless, and this is why one
web server can serve millions of page views - Every now and then, you need to maintain some sort of state 
on your server. A great example of such an example, is our Google Translate method, from the previous chapter.

If we don't store any state on the server at all, than every single invocation towards our Translate method, 
will have to invoke Google Translate once, for every single item it retrieves from the `items` table, 
every time it retrieves the item. Needless to say, but this is simply practically impossible.

One thing that might be tempting for such a scenario, would be to implement something that caches requests
based upon for instance the URL, and returns the cached object. This is sub-optimal, since it
would require the client to submit an HTTP request, exactly resembling something another user has 
requested earlier, for the cache to kick in.

Imagine for our above scenario for instance, doing a query for _"foo"_. Then imagine if some other user 
comes later and does a query for _"foo 2"_. Many of the items returned for the second request, would 
also exist in the first request - However, the URL would be *different*, and the cache for our 
HTTP requests, would be useless. A better solution for such scenarios would be to use for instance the
**[p5.web.cache]** object, to use the English text as the _"key"_, and the Norwegian translation
as the _"value"_ - And then before doing our Google Translate lookup, check to see if another
client had already translated our `description` previously.

If we are to take our Google Translate example, and modify it to see this in action, we could create
something that resembles the following.

```hyperlambda
/*
 * Running our SQL select query.
 */
p5.mysql.select:select * from items where description like @description
  @description:%{0}%
    :x:/../*/query/*/description?value

/*
 * Iterating through each item, and invoking Google Translate for its "description",
 * updating the above item with the results returned from Google Translate.
 *
 * This is a much more optimal solution, that the one we wrote in our previous chapter.
 */
for-each:x:/@p5.mysql.select/*

  /*
   * Checking cache object.
   */
  p5.web.cache.get:x:/@_dp/#/*/description?value
  if:x:/-/*?value
  
    /*
     * We found the currently iterated item in our cache.
     */
    set:x:/@_dp/#/*/description?value
      src:x:/@micro.google.translate?value

    // Continue to the next iteration.
    continue

  /*
   * Not found in our cache, hence we need to do our Google Translate lookup, 
   * and store the results in our cache.
   */
  micro.google.translate:x:/@_dp/#/*/description?value
    dest-lang:nb-NO
  set:x:/@_dp/#/*/description?value
    src:x:/@micro.google.translate?value
  p5.web.cache.set:x:/@_dp/#/*/description?value
    src:x:/@micro.google.translate?value

/*
 * Returning our items, now with the description in Norwegian.
 */
return:x:/@p5.mysql.select/*
```

If you have four items in your `items` table, containing some variation of the string _"foo"_ in them,
and you access your above extension method, using a URL such as for instance the following.

```markdown
/hyper-core/mysql/todo/foo/x?description=foo
```

The first time you request the above URL, it will probably spend several seconds responding, since it'll
have to internally create 4 HTTP requests towards Google Translate, before it can return the result.
However, all consecutive requests, also those with different URLs, but still returning the
same items - Will be much faster, since they can simply lookup the translated item from the cache,
and don't have to roundtrip to Google Translate to retrieve the Norwegian translation of your item.

On my machine the first request, returning 4 items, takes 1.2 seconds. If I evaluate it with the same
URL again, it will take 0.076 seconds. **AND** if I just slightly modify my URL, using for instance
the following URL instead. It is still blistering fast, since the cache is looking up on a _"per object basis"_,
and not on the HTTP request's URL.

```markdown
/hyper-core/mysql/todo/foo/x?description=foo+2
```

This makes it possible to do things with Hyper Core, that is difficult to even imagine doing with
other types of similar framework, built without *state* - Simply since you _can_, if you wish,
choose to store state, in temporary objects, on the server, improving the execution time of your
requests from 1.2 seconds, to 0.076 seconds. Which is a one order of magnitude improvement in
response time (15x to be accurate).

You can also cache things on a per user basis, using the **[p5.web.session]** event instead, in addition
to that for our above example, we could create one **[fork]** lambda object, for each Google Translate
lookup, wrapped inside of a single **[wait]** lambda, to make all initial 4 requests being executed
asynchronously, etc - But we are now moving into what is borderline in regards to what the scope 
of this document is, and the scope of learning Hyperlambda and Phosphorus Five in general. Hence, 
that'll be an exercise for you to figure out by yourself, if you wish to dive deeper into this subject.

Just put this at the back of your mind, that Hyper Core *can* cache things on the server side, on a per
object basis - And hence arguably, has an internal _"memcache"_ implementation.

**Notice**, it may be tempting to argue now, at this point, that the client could translate the
items itself. Eliminating the need for any server-side state. However, this simply offloads the server,
while making the client execute poorly, since it'll have to do the Google Translate invocations for
each item, before it can render its UI. Our above _"cache"_ solution, would only go towards Google Translate
every time it encounters a `description` it has not previously encountered - While for every consecutive
request, requesting the same item(s), it would simply return the cached value. Making all clients, 
except one initial HTTP request per item, returning one or more items it hasn't seen before, 
perform blistering fast.

Also notice that the default timeout for the cache object in Hyperlambda is 30 minutes, but this
can be changed as you see fit. Sliding expirations are also supported.

**Notice**, our above example could in theory have multiples clients doing a lookup at the same time
for the same item. To modify it such that only one client will invoke Google Translate, you'll need
to use a **[read-lock]** while checking the cache, and a **[write-lock]** while writing to the cache,
to synchronise access to your cache. Yet again, this is beyond the scope of this document. Shoot me 
an email at thomas@gaiasoul.com if you want me to write an article for you, with an example of how to 
do this. I also do code reviews, and can help out with architecture and tutoring in general.
