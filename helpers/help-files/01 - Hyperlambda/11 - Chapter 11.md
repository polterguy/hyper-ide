# Active Events

Active Events, as previously discussed, is a replacement to *"functions"* or *"methods*".

So what is an Active Event? Short answer; Everything! The 42 of P5! In fact, the only thing you have done so far, is invoking Active Events. The **[sys42.windows.confirm]** parts from one of our previous chapters, is an Active Event. The **[set]** parts we've used several times during the course of this book, also happens to be an Active Event. Active Events is the axiom, at which P5 and Hyperlambda evolves around.

## Your first Active Event

You can easily create your own Active Events. Execute the following code in your Apps/Executor.

```
create-event:sys42.examples.foo
  sys42.windows.confirm
    header:Foo was here!
    body:But bar was not invited ...
```

Then refresh your Executor web page, such that you reload your autocompleter. Then remove all old code from the executor input, and type in `.foo`. When you have done, hold down CTRL as you click the space bar. Execute the code, that should now hopefully look like the following, thanx to the wonders of autocompletion.

```
sys42.examples.foo
```

Probably few surprises here. Congratulations for the record, you have created your first reusable Active Event. Already at this point, you can consume this Active Event, in your own applications, as you see fit.

**Warning**; Before you go berserk creating your own Active Events, please realize that if your web server process for some reasons is being recycled - _Your Active Event will vanish_! If you want to create persistent Active Events, you'll need to declare them in e.g. a Hyperlambda file, and make sure this file somehow is executed, every time your web server process starts. This is easily done, by putting a Hyperlambda file, creating your Active Events, into the *"/system42/startup/"* folder inside of your *"/phosphorusfive/core/p5.webapp/"* folder. All files in this folder, are automatically executed, every time your web server process starts.

## Parametrizing your Active Events

To pass in arguments to an Active Event, is as easy as creating a child node in your lambda. Let's first create an Active Event, that can somehow handle our argument. Notice, we will be using the same name for our Active Event as our first example. This will ensure that our original Active Event becomes overwritten, and replaced with our new implementation, without any extra effort necessary from our side.

```
create-event:sys42.examples.foo
  eval-x:x:/+/*/header
  sys42.windows.confirm
    header:{0} was here!
      :x:/../*/name?value
    body:But bar was not invited ...
```

Afterwards you can invoke your Active Event with a **[name]** argument. Below is an example.

```
sys42.examples.foo
  name:Thomas Hansen
```

Notice, this time our confirmation window is actually able to show the name of *"Thomas Hansen"*. Hence, it has obviously found our argument. The results of the above code, should resemble the following.

![alt tag](screenshots/chapter-11-1.png)

To return arguments from your Active Events is equally easy.

```
create-event:sys42.examples.foo
  return
    foo1:bar1
    foo2:bar2
```

Then invoke your Active Event with the following code.

```
sys42.examples.foo
sys42.windows.show-lambda:x:/..
```

As you can see below, clearly our Active Event has returned two nodes for us after its invocation.

![alt tag](screenshots/chapter-11-2.png)

Often you only wish to return a single *"thing"* from your Active Events though, at which point you can do this, by using the **[return]** Active Event (yes, even the return *"keyword"* is an Active Event), and passing in whatever you wish to return, as the value of **[return]**. Below is an example.

```
create-event:sys42.examples.foo
  return:Hello World
```

Then invoke your event with the following.

```
sys42.examples.foo
sys42.windows.show-lambda:x:/..
```

At this point, the value **[return]**'ed from your Active Event, can be found as the value of your Active Event invocation node, like the following illustrates; `sys42.examples.foo:Hello World`.

### Referencing the "main" argument

If you pass in a value to your Active Events, you can reference this value as an **[_arg]** node, inside of your Active Events. Execute this code, to see its effect.

```
create-event:sys42.examples.main-arg
  sys42.windows.info-tip:x:/../*/_arg?value
sys42.examples.main-arg:Hello world!
```

The **[_arg]** argument(s), are handled in a special manner though. If you pass in an expression for instance, as your main argument - Then this expression will be evaluated *before* your event is invoked. Hence, inside of your event, you will have access to the result of your expression. Consider this code.

```
_name:Jo dude!
sys42.examples.main-arg:x:/@_name?value
```

Inside of your **[sys42.examples.main-arg]** event, the **[_name]** node is no longer accessible, since it's outside of the scope of the event itself. However, since the main argument to our invocation is an expression, this expression is evaluated *before* the event is invoked. This means that the **[_arg]**'s value, inside of our **[sys42.examples.main-arg]** event, is a simple constant value.

If you pass in an expression leading to multiple results, you will have multiple **[_arg]** items inside of your event.

## Hyping Hyperlambda

It may be easy to believe that the name *"Hyperlambda"* is simply a marketing trick, in an attempt at trying to hype the language. However, as we will see in our next example, the word hyper is in fact well deserved.

```
create-event:sys42.examples.two-times
  eval:x:/../*/.exe
  eval:x:/../*/.exe
```

After having executed the above code, you can execute this code in your Executor.

```
sys42.examples.two-times
  .exe
    create-widget
      parent:content
      position:0
      element:button
      class:btn btn-default
      innerValue:Echo
      onclick
        sys42.windows.info-tip:Echo was here!
```

What happens in our above example, is that we pass in a lambda object, intended to be executed. The **[eval]** invocations, inside of our **[sys42.examples.two-times]** event, executes the specified lambda twice.

The simplicity of passing around such *"execution objects"* to other parts of your code, providing callbacks to other lambda objects, is the reason why Hyperlambda got its name. You can easily pass in such lambda objects, to web service endpoints, completely reversing the responsibility of the client and the server. For the record, you can also do this *safely*.

> In P5 eval is not (necessarily) evil

Notice, the **[eval]** Active Event, can also pass in arguments to your evaluated lambda objects, the exact same way you can pass in arguments to an Active Event. An evaluated lambda object, can also return values, the same way an Active Event can. Arguably hence, a lambda object evaluated using **[eval]**, becomes the equivalent of an *"anonymous function object"*, which is capable of being (almost) perfectly interchanged with an Active Event invocation.

## Ignoring arguments

**Warning**; As you may have intuitively understood by now, you can supply whatever arguments you wish, to any Active Event in your system - And the Active Event will simply *ignore* your arguments, unless it was explicitly iplemented to handle your arguments.

Doing such a thing, is probably not wise though - Since ignored arguments, must still be passed into your Active Events, rendering your system's state, such that it contains *dead code*. In addition, of course, this makes your system more difficult to understand, since others will have difficulties in understanding your code, by looking at it, believing arguments that are *"dead"*, carries semantic meaning. In comparison to a strongly typed programming language, such as C#, which gives you compiler errors if you did the same - This might sometimes be a challenge for you, as you modify existing Active Events, removing old arguments, not in use anymore.

However, this is also the strength of Hyperlambda, since it allows you to modify existing events, taking additional arguments, without breaking existing code.

> In Hyperlambda, versioning your Active Events, and having different versions, of different systems, invoking events from each other - Rarely creates any problems for you

Compare the above to the _"interface nightmare"_ from e.g. DirectX or other statically typed programming languages and/or frameworks, which needs a new version, of every single interface, every time they apply a change.

## Non-existing Active Events

Another peculiarity of Active Events, is that you can easily invoke an Active Event which doesn't exist. Your invocation, will however not find any existing events with the specified name, and simply do *nothing*.

This is a really nifty pattern in Hyperlambda in fact, which allows you to anticipate the existence of some *"future event"*, without having to implement it yourself. This allows you to use non-existent *"hooks"* in your code, which you document, and which the consumers of your events later can *"hook into"*. This is implemented a lot of different places in P5 in fact, and allows you to *"inject"* your own Hyperlambda logic, into the *"core kernel parts"* of P5, completely modifying its behavior.

## Naming conventions

There is nothing preventing you from creating the following Active Event.

```
create-event:57
  return:42
```

Whether or not this is a smart thing to do though, is probably *"debatable"*, to say the least. I often find myself encouraging others to use some sort of intelligent namespacing convention. Often this should be as unique as possible, to make sure your Active Events does not clash with Active Events created by others.

By carefully choosing a unique namespace for your Active Events, you make sure your code works, an often times even collaborates, side by side other people's code. My convention here is to encourage others to using their company name, or some other *very unique piece of string*, as the first parts of your Active Events, for then to add the application name as the second - Then at the end, provide the actual name for your Active Event, providing some meaningful clue about what your Active Event actually does.

If we were to rewrite the above Active Event, with this in mind, creating a more intelligent naming convention - We could create something that resembles the following instead.

```
create-event:gaiasoul.the-answer.what-is-57
  return:42
```

Notice the "." separating the different components of our *"namespace"*. This *"namespace"* is only a *"convention"* though, and carries no actual semantics.

You could also name your Active Events **[What is the number of $ I would get, for 57€ ...?]**, but I wouldn't recommend it. First of all, if the consumer of your Active Event forgets to add as much as the space " " between the last EURO sign, and the "..." parts, his invocation would not invoke your event.

You could also supply special characters in your event names, making it extremely difficult for others to invoke them. Examples includes carriage returns,"", Japanese characters, Greek letters, TAB, ASCII+7, etc. I wouldn't claim doing such a thing would never be wise - For instance, using Japanese or Chinese characters as event names, or Greek letters for that matter, could probably sometimes provide good contextual meaning. I am simply saying; *be careful!*

Active Events are carefully created to facilitate for *more* contextual meaning, and *improved* understanding of your systems. Not to set a new world record in obfuscated coding olympics - Although, you'd probably easily win such a contest, if you tried attending it with Hyperlambda. For instance, this is perfectly valid Hyperlambda, and creates an Active Event named **[]**, taking a **[∂]** argument - Which of course makes no sense at all.

```
create-event:
  return:{0} is the new ≈
    :x:/../*/∂?value
```

Why the above becomes almost absurd, can be seen by trying to consume the above Active Event.

```

  ∂:¸
```

### Restrictions to Active Event names

There are only 3 restrictions to what you can name your Active Events.

* You cannot start your event name with an underscore "_"
* You cannot start your event name with a period "."
* You cannot create an even who's name is "" (empty string)

These restrictions applies only to Hyperlambda though. The reason is that Active Events starting with either a ".", or a "\_", are considered *"private core Active Events"*. You can create such events, but only from C#. In addition, you cannot invoke such Active Events from Hyperlambda, since the **[eval]** Active Event ignores all nodes starting with either "." or "\_", rendering your events useless, if you could create them. The Hyperlambda **[eval]** event, will neither attempt to raise any events having an empty name. Notice, you can however create Active Events in C# starting with ".", "_", or having an empty name "". This is often useful too in fact.

The "" for Active Event for instance, is a special event name, that can also exclusively be created from C#. This event will handle *all* Active Events, and allows you to tap into the core Active Event *"kernel"*, and modify its behavior.

Active Events starting with "." or "_", can only be created in C#, and only consumed from C#. This allows you to create events, that can only be consumed from C#, which allows you to create *"internal C# code"*, which is not intended to be consumed by Hyperlambda directly. Sometimes this is useful for security reasons for instance. Phosphorus Five contains many such *"internal C# Active Events"*, in its C# core, which have been hidden, to make it more difficult to *"crack"* the system, using Hyperlambda.

In addition, I highly discourage you from creating Active Events that already exists, such as creating an event who's name is **[create-event]**. Which would render your system close to useless in its entirety, if you did.

#### Stay away from my stuff!

You should also have an extremely good argument for creating Active Events starting with the name of *"p5."* or *"sys42."*, since these are intentionally restricted namespaces (by convention), intended for the system itself.

I also highly encourage you to *not* create Active Events that have no namespace, such as for instance `create-event:foo-event`. The risk of having your event name clash with other people's event names, is simply too great - Rendering your system's ability to collaborate with other people's code impossible.

The convention I recommend, is to use something like the following.

```
create-event:company-name.system-name.event-name
```

There are some rare exceptions to the above rules though, such as if you create a specialized widget type in C# - At which point you'll need to break the above rules. But unless you are really certain about that you need to break the rules, _don't!_

### Argument conventions

I often encourage people to pass in lambda objects, intended for execution, by starting their names with a ".". First of all, this will make the intellisense parser of the Hyperlambda code editor mark your lambda object as an *"execution object"*. Secondly, it makes such execution objects more easily tracked, and increases the readability of your code. So even though this is not technically a prerequisite, I find this myself, to be a useful convention.

Other types of arguments, I encourage people to simply pass in with an intelligent name, not pre-prending anything in front of the argument. In a previous version of the **[eval]** event, the expectation was to prepend arguments to lamdba objects with an underscore "_". This is **no longer the case** - And the only reason why there are still any events that even uses this convention, is for historical reasons, to be backwards compatible. I don't encourage people to use this syntax anymore, since a lambda object will not execute any of its arguments any ways, but *"offset"* the execution pointer, to the first *"non-argument part"* of your lambda object.

[Chapter 12, Eval is not (necessarily) evil](chapter-12.md)
