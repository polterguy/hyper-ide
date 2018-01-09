## Your first Ajax form

Arguably, among your most important tasks in an Ajax application, is the gathering of input from your users. This is easily done with P5. 
Below is an example. If you wish, you can simply paste the code below into your _"Hello World"_ application, from our previous chapter,
and test it out without creating a new app.

```
/*
 * Includes CSS for our module.
 */
p5.web.include-css-file
  @MICRO/media/main.css
  @MICRO/media/fonts.css
  @MICRO/media/skins/serious.css

/*
 * Creating main wire frame for module.
 */
create-widget
  class:container
  widgets
    div
      class:row
      widgets
        div
          class:col-100
          widgets
            void:your_name
              element:input
              class:fill
              placeholder:Give me your name ...
            literal:your_adr
              element:textarea
              placeholder:Give me your address ...
              class:fill
              rows:7
            literal
              element:button
              innerValue:Submit
              onclick
                p5.web.widgets.property.get:your_name
                  value
                p5.web.widgets.property.get:your_adr
                  value
                eval-x:x:/+/**/innerValue
                create-widgets
                  micro.widgets.modal
                    widgets
                      h3
                        innerValue:Thx dude!
                      p
                        innerValue:So, I guess your name is '{0}', and your address is '{1}'
                          :x:/../*/p5.web.widgets.property.get/*/your_name/*?value
                          :x:/../*/p5.web.widgets.property.get/*/your_adr/*?value
```

There are several new concepts in the above piece of Hyperlambda. Let's walk through them all, to get a grasp of exactly what is going on here.
First of all, we don't care about giving neither our main root **[container]** widget, nor our button widget any explicit IDs. This ensures 
that our widgets will have *"automatically assigned IDs"*. You can see these IDs if you view the HTML of your page.
Secondly, we create a simple *"input"* widget, followed by a *"textarea"* widget. Both of these widgets, we have given an explicit ID, since
we want to be able to easily retrieve their values later. The *"input"* element is created as a **[void]** widget, while our *"textarea"* 
element is created as a **[literal]** widget. This is important for these particular types of widgets.

### Retrieving form data

Probably the most complex parts above, is the stuff that's happening in our **[onclick]** event handler. To make it clear, let's isolate the 
lambda of our **[onclick]** Ajax event.

```
onclick
  p5.web.widgets.property.get:your_name
    value
  p5.web.widgets.property.get:your_adr
    value
  eval-x:x:/+/**/innerValue
  create-widgets
    micro.widgets.modal
      widgets
        h3
          innerValue:Thx dude!
        p
          innerValue:So, I guess your name is '{0}', and your address is '{1}'
            :x:/../*/p5.web.widgets.property.get/*/your_name/*?value
            :x:/../*/p5.web.widgets.property.get/*/your_adr/*?value
```

Initially we retrieve the values of our *"your_name"* input widget, and our *"your_adr"* textarea widget. This is done with our 
two **[p5.web.widgets.property.get]** invocations. Then we show a modal confirmation window with the data supplied by the user. However, 
before we show this modal confirmation window, there's an invocation to **[eval-x]**. This simply *"forward evaluates"* the expressions found 
in our **[innerValue]** node, which is a child of our **[p]** node. Since this is a formatted string, with its formatting values pointing to 
the results of our **[p5.web.widgets.property.get]** invocations - This means that when **[micro.widgets.modal]** is evaluated, 
the **[innerValue]** of our **[p]** element, will be a static string, being the product of our formatting expressions, having its *"{n}"* parts, 
exchanged with its n'th child node's result. Notice, only nodes without names, will be considered when creating such _"formated strings"_.

The above `:x:` parts of our Hyperlambda, are in fact what we refer to as *"lambda expressions"*. These allows you to reference other nodes 
in your lambda structure. If you have some knowledge of XPath, the similarities might be obvious.

The **[micro.widgets.modal]** above, is an extension widget from Micro, which will be created as we invoke **[create-widgets]** (plural form).

### Lambda expressions

Lambda expressions are crucial for the understanding of P5. Let's dissect the first expression in our Hyperlambda above, 
the `eval-x:x:/+/**/innerValue` parts. The first part of our code, the `eval-x` parts, is an Active Event invocation, that forward evaluates 
the resulting nodes of the lambda expression it is given. The `:x:` parts, is a type declaration, and simply means that the value of our node, 
is of type *"lambda expression"*. After these two parts, comes our actual expression.
To *"forward evaluate"* an expression, simply means evaluating it, and exchanging the expression, with a constant being the value of whatever 
the expression points to. Hence, after our **[eval-x]** invocation is done executing, our **[innerValue]** node of our **[p]** node, will no 
longer contain an expression, but the constant result of the expression. This is a trick often applied in Phosphorus Five when passing in 
arguments to Active Events. **[eval-x]** is an Active Event you will be using a lot in your own code.

### Conceptualizing expressions

An expression can point to one or more nodes, and hence serves as a *"node pointer"*. This way of referencing nodes, is probably unique to 
Hyperlambda, and what allows you to retrieve and change nodes in your lambda objects. These expressions are in fact so powerful, that 
Hyperlambda has no means of declaring traditional variables. However, everything can in fact vary in a lambda object. Any node can have 
its name, value, and children collection modified, during its execution. This allows you to use everything in your lambda objects 
as *"variables"*, and change it, remove it, add to it - Exactly as you see fit, during its execution.
To create a useful mental model for expressions - It might be useful to perceive Hyperlambda as a combination of XML and XSLT, and 
lambda expressions as the equivalent of XPath.

Although Hyperlambda, per se, doesn't contain any explicit variables - By convention, you will often find that nodes purely intended to 
contain data of some sort, are prefixed with either an underscore "\_", or a period ".". The reasons for this, is because the Hyperlambda 
execution engine, will ignore nodes starting with an underscore, or a period, and not attempt to raise these as Active Events. Or to be 
more explicit; The **[eval]** event, and its associated overloads, will not attempt to raise anything starting out with a *"."* as an 
Active Event, but simply ignore it.

If you still think these expressions appears like black magic, you can check out the following video. **Notice**, it's quite old, but still
explains it accurately. To understand Hyperlambda, it is crucial that you understand lambda expressions, so even though it may be a boring
video to watch - I still encourage you to watch it to the end.

https://www.youtube.com/watch?v=VjG2hGeMnbU

### Lambda expression Ninja tricks

Often you will declare *"variable nodes"* before you use them. This allows you to use the *"variable scope iterator"*, which starts out 
with `/@_x`, where *"_x"* is the name of some node, declared before the code that is referencing it.

The variable scope iterator allows you to reference nodes that the lambda executor has *"already seen"*. This iterator will find the first 
node, matching the specified name, amongst the node's elder siblings. If it cannot find any nodes amongst its elder siblings, matching the 
name supplied, it will move up to the parent node, trying to make a match amongst the parent node, or one of the parent node's elder siblings. 
This process will repeat, until either a match is found, or the expression yields a *"null result"*.

This iterator resembles to some extent the usage of variables in traditional programming languages, hence its name; *"variable scope iterator"*.
