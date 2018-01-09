# Branching

Branching is at the core of any Turing complete programming language. Although Hyperlambda is not per se a programming language, it still features complete branching possibilities. For those used to programming, branching means that your execution instruction pointer _"jumps"_, often in accordance to some condition. The most common form of branching is an _"if"_ statement. Below is an example of how to branch in Hyperlambda.

```
_data:foo
if:x:/@_data?value
  =:foo
  sys42.windows.info-tip:Foo was here
else
  sys42.windows.info-tip:Foo has left the building!
```

If you execute the above code in System42's executor, you will see its result. Try changing the value of the **[_data]** node, to e.g. _"bar"_, and execute the code again, and notice how the result changes.

## Comparison operators

All branching Active Events in Phosphorus Five obeys by the same logic. Basically, there are a handful of comparison Active Events which you can use.

- **[=]** checks for equality
- **[!=]** checks for inequality
- **[>]** checks for more than
- **[<]** checks for less than
- **[>=]** checks for more than or equals
- **[<=]** checks for less than or equals
- **[~]** checks for _"contains"_ (only useful when comparing strings)
- **[!~]** checks for _"not contains"_ (only useful when comparing strings)

All the above _"operators"_ are actually Active Events themselves, and these operators can easily be extended with your own comparison events.

## Boolean algebraic compound conditions

In addition to the operator Active Events, there are also boolean algebraic events, allowing you to create compound conditions, where you have multiple conditions. Below is an example.

```
_data1:foo
_data2:bar
if:x:/@_data1?value
  =:foo
  and:x:/@_data2?value
    =:bar
  sys42.windows.info-tip:Foo and bar where happily drinking beer!
else
  sys42.windows.info-tip:Either foo, bar or both had a hangover today!
```

In order for the above **[if]** Active Event to evaluate its lambda object, both **[if]** and **[and]** needs to evaluate to true. Notice, when creating more complex conditions, such as the above is an example of, it is often useful to create some comments, to explain to the reader of our code, where the actual lambda object starts. Below is an example of the exact same code as above, only slightly more readable.

```
_data1:foo
_data2:bar
if:x:/@_data1?value
  =:foo
  and:x:/@_data2?value
    =:bar

  /*
   * [_data1] contains "foo" and [_data2] contains "bar".
   */
  sys42.windows.info-tip:Foo and bar where happily drinking beer!

else

  /*
   * Neither foo nor bar was to be seen.
   */
  sys42.windows.info-tip:Sorry, today is hangover day!
```

The above syntax might seem weird to developers who are used to C# or JavaScript, but remember that a lambda object, is a tree structure, or a graph object - And that this creates some syntactic differences, which has some advantages, and some disadvantages.

The disadvantage, is that creating compound conditions for your branching invocations, becomes slightly more _"verbose"_. The advantage, is that it becomes much more easy to figure out, also in automated processes, what your branching invocations are actually doing - And in fact, also modify them, using the meta cognitive capabilities of a lambda object.

Below is a list of all the boolean algebraic compound Active Events in P5.

* __[or]__ one of the conditions must evaluate to true
* __[and]__ both conditions must evaluate to true
* __[not]__ negates the previous _"conclusion"_

These boolean algebraic operators works similarly to how they work in other programming languages. For an understanding of what boolean algebra actually is, you can read the appendix on [lambda expressions](appendix-expressions-boolean-algebra.md). Logically boolean algebra on branching conditions, works similarly to boolean algebra on lambda expressions. Except there is no _"XOR"_ operator while branching.

The **[and]** Active Event has presedence when doing branching, just like you're used to from other programming languages for the record.

## The [while] loop

The **[while]** loop is a special case of branching. Instead of simply evaluate some lambda object a single time, it will keep on evaluating your lambda object, for as long as the condition is true. Below is an example.

```
_data
  foo1
  foo2
  foo3
while:x:/@_data/0
  create-widget
    innerValue:x:/@_data/0?name
  set:x:/@_data/0
```

The above **[while]** simply evaluates its lambda object, for as long as there exists a zero'th child beneath **[_data]**. Then at the end of each iteration, it will remove the zero'th child of **[_data]** - Resulting in the creation of three widgets on your page.

The above shows a crucial point for the record, which is implicit conversion due to existence of some value, name, or node. Basically, the rule-set will check to see if the result of the expression it is given exists, and if it does, it will evaluate to true, unless it is of type boolean, and has the value of false. The above **[while]** example, could have been created like the following.

```
_data
  foo1
  foo2
  foo3
while:x:/@_data/*?count
  >:int:0
  create-widget
    innerValue:x:/@_data/0?name
  set:x:/@_data/0
```

However, the first example, creates more dense code, and becomes more readable. Logically, they're doing the exact same thing though. Another way to describe the exact same thing, would be to use another operator Active Event, such as the following illustrates.

```
_data
  foo1
  foo2
  foo3
while:x:/@_data/*?count
  !=:int:0
  create-widget
    innerValue:x:/@_data/0?name
  set:x:/@_data/0
```

All these three examples does the exact same thing. Which you choose, depends upon your style of coding, and what you find to be more readable.

Notice, all of these three examples depends upon their last **[set]** invocation to not enter what is often referred to as an infinite loop. P5 however, contains _infinite loop protection_ by default, which helps you to prevent evaluating a lambda object, that would enter an infinite loop using **[while]**. Try evaluating the above code for instance.

```
_data
  foo1
  foo2
  foo3
while:x:/@_data/0
  create-widget
    innerValue:x:/@_data/0?name
  // COMMENTED OUT, enters an "infinite loop"
  // set:x:/@_data/0
```

As you can see, after 5.000 iterations, our above **[while]** loop will throw an exception, and stop executing. If you have a loop, where you actually need more than 5.000 iterations, you can add up an **[_unchecked]** argument to your **[while]** loop, and set its value to boolean true. Don't do it with the above code though, unless you want to crash your web server process.

## The "contains" operators

Both the **[~]** and the **[!~]** Active Events are special, and only intended for string handling. They will basically check some string, to see if another string exists within your source string - And if so, yield either true or false, depending upon whether or not you are using the not version or not.

The following code illustrates an example.

```
_data:Thomas Hansen was here
if:x:/@_data?value
  ~:Hansen
  sys42.windows.info-tip:Yo boss!
else
  sys42.windows.info-tip:Yo stranger!
```

Basically, as long as the above **[_data]** node's value contains the string *"Hansen"*, the **[~]** operator event above will yield true. If you try changing *"Hansen"* to *"Doe"* in the above **[_data]** node's value, it will not evaluate to true.

### Regular expression matching with the "contains" operators

The contains operators can also be given regular expressions, instead of simple string. Below is an example looking for any _"sen"_ name.

```
_data:Thomas Hansen was here
if:x:/@_data?value
  ~:regex:/[A-Z]{1,1}[a-z]*sen/
  
  /*
   * Xxxsen name found.
   */
  sys42.windows.info-tip:Yo boss!

else

  /*
   * No "Xxxsen" name found.
   */
  sys42.windows.info-tip:Yo stranger!
```

The above regular expression will match anything starting with a capital letter, followed by x lower case letters, ending with the string _"sen"_. Basically, matching any name ending with the string _"sen"_, which is a common surname in Norway.

How to create regular expressions will be dealt with in a later appendix, but basically, a regular expression starts and ends with a "/", followed by optionally some regex options. In addition, a regular expression has the type declaration of `:regex:`.

**Warning**; Regular expressions are notoriously difficult to read and understand! Be careful with them!

## To branch or not to branch

A lot of times, you can choose between using branching Active Events, or using more complex lambda expressions. Often this is a choice, which you will have to do in accordance to the problem at hand. For instance, in the above code, we are looping through a bunch of nodes, and using an **[if]**, to extract only the nodes having some specified name.

```
_data
  foo:foo1
  bar:XXX
  foo:foo2
for-each:x:/@_data/*
  if:x:/@_dp/#?name
    =:foo
    create-widget
      innerValue:x:/@_dp/#?value
```

The above will create a widget for each node inside of our **[_data]** segment, having the name of *"foo"*. The exact same logic could have been much more easily created using a slightly more complex lambda expression for your **[for-each]** invocation. This would significantly reduce the complexity of your code, and make it much more readable. Below is an example of doing just that.

```
_data
  foo:foo1
  bar:XXX
  foo:foo2
for-each:x:/@_data/*/foo
  create-widget
    innerValue:x:/@_dp/#?value
```

Using a single additional iterator in our above **[for-each]**, we have gotten entirely rid of our original **[if]** invocation, making the code significantly more easy to read, and much more condense in nature.

Often you can get rid of entire hierarchies of conditional event invocations, by adding some tiny additional amount of intelligence, into your lambda expression. Making our branching invocations become completely redundant. Above for instance, if we ignore the **[_data]** segment, we had 5 lines of code, which we were able to reduce to 3 lines of code, while at the same time making our code much more readable.

Often a lot of tasks in Hyperlambda becomes significantly smaller, and surprisingly dense in syntax. You can often get rid of entire hierarchies of conditional branching, simply by adding up a couple of additional iterators to your expressions.

To see the full power of lambda expressions, please check out the appendix where they are more thoroughly described.

[Chapter 19, Creating a PGP GMail clone](chapter-19.md)
