## Creating your own extension methods

Often times the previous 4 basic CRUD operations simply won't cut it for you. Maybe you want to perform a join on
multiple tables for instance? Or you want to add more complex conditions than the above allows you to? Or maybe
you need to insert into multiple tables during one invocation, wrapping your SQLs in a database transaction? For such 
times, there is the `x` method. The `x` method doesn't take a table name as its second parameter. Instead it requires
the name, to your extension method, which you'll need to supply as a Hyperlambda file, inside
of your _"/common/documents/private/hyper-core/x/"_ folder. If you have a file called for instance
_"foo.hl"_ inside of the previously mentioned folder, you can invoke this extension method using a URL resembling
the following.

```markdown
/hyper-core/mysql/todo/foo/x
```

The above URL will evaluate your _"/common/documents/private/hyper-core/x/foo.hl"_ file.
This file will be evaluated with all the relevant information from your HTTP request, having been automatically
decorated for you. Notice, as your file is evaluated, the `todo` database will already be the open and active
database connection, but no transactions will have been associated with it. Below is an example of how your 
file invocation might be decorated.

```hyperlambda
method:POST
params
  some-url-encoded-parameter:foo
query
  some-query-parameter:bar
```

This allows you to easily reference any parts of the HTTP request, and its decoration, as you see fit.
Below is an example of a file that executes a `count` SQL on your `items` table,
parametrised with a query parameter, filtering the `description` of the records it should count.

```hyperlambda
p5.mysql.scalar:select count(*) from items where description like @description
  @description:%{0}%
    :x:/../*/query/*/description?value
return:x:/@p5.mysql.scalar?value
```

If you invoke the extension method above, with something resembling the following 
URL `/hyper-core/mysql/todo/foo/x?description=bar` - The above 
will return JSON resembling the following to your client, assuming you have two records containing the
string _"bar"_ in their description.

```javascript
{"result":2}
```

To return multiple records instead, you could create a _"foo.hl"_ file such as the following instead.

```hyperlambda
p5.mysql.select:select * from items where description like @description
  @description:%{0}%
    :x:/../*/query/*/description?value
return:x:/@p5.mysql.select/*
```

The above would return JSON resembling the following to your client.

```javascript
[{"id":2,"description":"bar"},{"id":3,"description":"hello"},
{"id":4,"description":"foo 2"},{"id":6,"description":"bar 3"},
{"id":7,"description":"bar 4"},{"id":9,"description":"XYS"}]
```

If you create an extension method that does an `insert`, `update`, or `delete` operation, it is considered
to be good practice to return the results of the operation to the client. For `update` and `delete`, this
would imply returning simply the value of the **[p5.mysql.delete]** or **[p5.mysql.update]** invocation.
For a **[p5.mysql.insert]** invocation, the id of the last inserted item, can be found as an **[id]** node
child of your insert event invocation.

### Mandatory arguments

You can create an extension method that requires one or more arguments to be supplied, and if they aren't, 
it will throw an exception. To do this, you'll have to invoke the **[micro.lambda.contract.min]** event, 
passing in the root node, and a list of mandatory arguments, and their type(s), in your extension method's implementation.
Below is an example of a method that requires the client to pass in a `description` query argument as a string, 
and if he hasn't, or the description is empty, it will throw an exception.

```hyperlambda
/*
 * This line will throw an exception, if the client did not pass
 * in a "description" query parameter, or the "description" query parameter
 * was empty for some reasons.
 */
micro.lambda.contract.min:x:/..
  query
    description:string

/*
 * If we came this far without an exception, there was a "description" query parameter, 
 * and it was not empty.
 */
p5.mysql.select:select * from items where description like @description
  @description:%{0}%
    :x:/../*/query/*/description?value
return:x:/@p5.mysql.select/*
```

You can of course require an argument to be supplied that is convertible into for instance a `double` or
an `int` too. If you wish to do that, simply replace the above `description:string` with e.g. `foo:int`, or
whatever name/type you want your argument to be possible to convert into.

### About Hyperlambda

The above extension methods are actually created using Hyperlambda. Most of the time this is not important for you, 
since you'll probably just invoke some **[p5.mysql.xxx]** event, and return its result. However, realise that
Hyperlambda is actually a Turning complete programming language, from which you can do a lot of really awesome
stuff - Ranging from sending PGP encrypted emails, to invoking Google Translate.

Let's create a thought experiment. Imagine that you want to to translate the description of 
your items into Norwegian, before you return them to the client. This is easily accomplished using Hyperlambda, 
by invoking an Active Event from Micro, which allows us to invoke Google Translate. Below is an example of doing 
just that.

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
 * WARNING, this will take a LOT of time, if you have a huge result set returned from your above SQL.
 * It is simply an **EXAMPLE** of how to use Hyperlambda, and not something you should
 * use in production code, due to that it creates one HTTP request towards Google Translate,
 * for each item returned from our above SQL.
 */
for-each:x:/@p5.mysql.select/*
  micro.google.translate:x:/@_dp/#/*/description?value
    dest-lang:nb-NO
  set:x:/@_dp/#/*/description?value
    src:x:/@micro.google.translate?value

/*
 * Returning our items, now with the description in Norwegian.
 */
return:x:/@p5.mysql.select/*
```

The above will actually translate all your descriptions into Norwegian, before returning them to the client.
Obviously, if you want to implement something like the above, you should definitely cache the results somehow 
from Google Translate, to avoid multiple roundtrips for the same items again. However, to keep our example
small and simple, we didn't implement that in our above example.

### Creating C#/VB.NET/F# extension methods

You can also create extension methods as CLR methods if you want to. This is easily accomplished by creating 
a new library type of .Net/Mono project, and add a reference to the project called _"p5.core"_, for then
to create a static C# method, in one of your classes, and mark it with the attribute `ActiveEvent`.
Below is an example of some C# code that would do this for you.

```clike
using System;
using p5.core;

class Foo
{
    [ActiveEvent (Name = "foo-bar.my-event")]
    public static void foo_bar_my_event (ApplicationContext context, ActiveEventArgs e)
    {
        e.Args.Value = 42;
    }
}
```

You'll need to reference the assembly containing the above class into your main _"p5.webapp"_ project,
for then to edit your _"web.config"_ file, to include your assembly as a plugin, by adding another `add` entry
into your `assemblies` configuration. Below is an example of how to accomplish this, assuming your assembly
is called `foo`.

```xml
<add assembly="foo" />
```

If you do the above, you can actually invoke your C# method from an extension method, by for instance changing
your above _"foo.hl"_ file to something resembling the following.

```hyperlambda
foo-bar.my-event
return:x:/@foo-bar.my-event?value
```

For the record, assuming you modified our above _"foo.hl"_ file, the URL to invoke your C# method would become
the following `/hyper-core/mysql/todo/foo/x`, and it would return the following JSON.

```javascript
{"result":42}
```

You can of course mix all concepts discussed here under the extension methods as you see fit, and have any amount
of Hyperlambda, SQL, and/or C# perfectly mixed together, as you see fit, creating any types of extension methods
you want to create.