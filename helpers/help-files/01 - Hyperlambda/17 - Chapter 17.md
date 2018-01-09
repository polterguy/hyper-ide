# Loops

Looping, iteration, or enumeration, is the ability to perform the same task multiple times, optionally with some piece of information, associated with each iteration. An example could be to create a widget, for each name in some list. Below is an example of such a loop.

```
_people
  name:Thomas
  name:John
  name:Jane
for-each:x:/@_people/*?value
  create-widget
    innerValue:x:/@_dp?value
```

If you execute the above code in for instance the CMS/Executor, you will create 3 widgets, each with its **[innerValue]**, taken from the value of each child node beneath **[_people]**. If you add another name, and execute the code again, it will create 4 widgets. This is because the **[for-each]** Active Event, will execute its lambda object, once for every result in its source expression. Its source expression, is declared as its value.

## The [for-each] loop

The **[for-each]** Active Event, will execute its lambda object once for each result from its source expression, and each run will have a **[_dp]** node as a child of the **[for-each]** itself. This **[_dp]** wil point to whatever you're currently iterating in the source for your for-each. **[_dp]** implies *"data pointer"*.

In the above example, we are iterating the values of each child node beneath **[_people]**, which means that the value of the **[_dp]** node, will for each run, contain the value of the currently iterated **[name]** node. You can iterate the name, value or node itself, and use it as a source expression, for your **[for-each]** invocations. Notice, if you iterate the node itself, the node will be passed in as the value of your **[_dp]** node, for each iteration. This means that you'll have to use a reference iterator, to access the currently iterated node. Let's illustrate with an example.

```
_people
  name:Thomas
  name:John
  name:Jane
for-each:x:/@_people/*
  create-widget
    innerValue:x:/@_dp/#?value
```

### The reference iterator explained

Notice, our last code example above, is identical to our first example, except it iterates the node itself, and hence is dependent upon using the reference iterator (`/#`), to de-reference the node currently being iterated. The reference iterator will either cast or convert the *value* of the previous result set into a node itself. To visualize what it actually does, it helps to throw up a debug window at the end of your lambda object above, and execute it in the *Apps/Executor"* of System42. This will result in something resembling the following code in your *"output window"*.

```
_people
  name:Thomas
  name:John
  name:Jane
for-each:x:/@_people/*
  _dp:node:"name:Jane"
  create-widget:x6872a19
    innerValue:x:/@_dp/#?value
sys42.windows.show-lambda
```

As you can clearly see above, the **[_dp]** node, actually has a value, which is a node in itself. This allows us to pass around *"pointers"* to nodes, as values of other nodes - Allowing for us to both access the node in its entirety, including its children - In addition to changing the original node's values.

Consider the following code for instance, which changes the value of all nodes to the static value of *"John Doe"*.

```
_people
  name:Thomas
  name:John
  name:Jane
for-each:x:/@_people/*
  set:x:/@_dp/#?value
    src:John Doe
```

Execute the above code in the Executor, and see for yourself how every single node beneath **[_people]** had their values changed after execution.

## The [while] loop

The while loop allows you to iterate for as long as some specific condition is true. Its syntax for its condition(s), is identical to the syntax used in branching (**[if]** invocations), which we will have a look at in a later chapter. However, below is an example of a while loop, that iterates while the **[_people]** data segment has children. Then inside the loop itself, at the end of its lambda object, it removes the first child, before continuing iterating. Logically, it does the exact same thing, as our above **[for-each]** example, except using the **[while]** loop, instead of a **[for-each]** loop.

```
_people
  name:Thomas
  name:John
  name:Jane
while:x:/@_people/*
  create-widget
    innerValue:x:/@_people/0?value
  set:x:/@_people/0
```

To understand the details of how to create more complex conditions for your while invocations, please refer to the chapter covering **[if]** or branching conditions. However, below is an example creating a widget with each number ranging from zero to five.

```
_no:int:0
while:x:/@_no?value
  <:int:5
  create-widget
    innerValue:x:/@_no?value
  set:x:/@_no?value
    +:x:/@_no?value
      _:1
```

You can combine any conditions, by using boolean operators, combining conditions, to create any amount of complexity in your conditions as you see fit. Please refer to the chapter about branching to understand this process, since it is identical to creating conditions for **[if]** invocations.

[Chapter 18, Branching, if, else-if and else](chapter-18.md)
