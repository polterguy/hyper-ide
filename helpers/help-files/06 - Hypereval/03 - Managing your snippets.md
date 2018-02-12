## Managing your snippets

As previously said, Hypereval has a very rich API, allowing you to easily create,read, update and delete
snippets as you see fit. In addition, it also easily allows you to evaluate snippets. This gives you a
highly dynamic environment for storing Hyperlambda snippets within.

For instance, to create a new snippet can easily be done with the following code.

```hyperlambda-snippet
/*
 * Creates a snippet with the name of "foo-bar"
 * and saves it to your snippets database.
 */
hypereval.snippets.save:foo-bar
  content:@"micro.windows.info:Foo bar"
```

If you launch your _"Load snippet window"_ after having evaluated the above code, you will see that clearly
a new snippet was created for you. Below is a screenshot of how this might look like. Notice the
_"foo-bar"_ snippet we just created.

https://phosphorusfive.files.wordpress.com/2018/02/hypereval-load-snippey-screenshot.png

When you dynamically create snippets as we did above, you can (optionally) pass in a **[type]** argument,
which is expected to be either _"page"_, _"startup"_, or _"snippet"_ (default).

If you later want to evaluate the above snippet, this can easily be done with the following code.

```hyperlambda-snippet
/*
 * Evaluates the snippet we created above.
 */
hypereval.snippets.evaluate:foo-bar
```

To load the snippet you created above, you can do something resembling the following. Notice, the
**[hypereval.snippets.load]** event will return one node for each snippet you choose to load,
allowing you to load multiple snippets at the same time.

```hyperlambda-snippet
/*
 * Loads the snippet we created above, and displays it
 * in a modal window.
 */
hypereval.snippets.load:foo-bar
eval-x:x:/+/*/*/*/pre/*/innerValue
create-widgets
  micro.widgets.modal:samples-modal
    widgets
      h3
        innerValue:Content of snippet
      pre
        innerValue:x:/@hypereval.snippets.load/*?value
```

To delete the snippet is equally easy.

```hyperlambda-snippet
/*
 * Deletes the snippet we created above.
 */
hypereval.snippets.delete:foo-bar
```

If you want to overwrite an existing snippet with a new snippet, simply save your snippet with the
same name as your existing snippet. For instance, in the below Hyperlambda, we overwrite our snippet
with another snippet, that creates a modal widget instead of simply showing an information bubble
window.

```hyperlambda-snippet
/*
 * Creates a snippet with the name of "foo-bar"
 * and saves it to your snippets database.
 */
hypereval.snippets.save:foo-bar
  content:@"create-widgets
  micro.widgets.modal:foo-bar
    widgets
      h3
        innerValue:Foo bar
      p
        innerValue:Hello World
      div
        class:right
        widgets
          button
            innerValue:Close
            onclick
              delete-widget:foo-bar"
```

### Creating a snippet web page

If you choose to save your snippet as a "page" __[type]__, then you will create a unique URL, through
which you can load your page. Below is an example.

```hyperlambda-snippet
/*
 * Creates a snippet with the name of "foo-bar"
 * and saves it to your snippets database as a "page".
 */
hypereval.snippets.save:foo-bar
  type:page
  content
    micro.css.include
    create-widget
      class:container
      widgets
        div
          class:row
          widgets
            div
              class:col
              widgets
                div
                  class:shaded rounded air-inner
                  widgets
                    h3
                      innerValue:This is your page
                    p
                      innerValue:Some paragraph
```

Try to evaluate the above snippet, and then open up the [following link](/hypereval/foo-bar) in
a new browser tab.

Notice, if you want to create your snippets more _"semantically correct"_, you can choose to pass
in your lambda as a lambda object, instead of a piece of text. This will not save any of your comments,
but might still make it easier for you to create your snippets in a semantically correct manner. Below
is an example.

```hyperlambda-snippet
/*
 * Creates a snippet with the name of "foo-bar"
 * and saves it to your snippets database.
 */
hypereval.snippets.save:foo-bar
  content
    create-widgets
      micro.widgets.modal:foo-bar
        widgets
          h3
            innerValue:Foo bar
          p
            innerValue:Hello World
          div
            class:right
            widgets
              button
                innerValue:Close
                onclick
                  delete-widget:foo-bar
```

### Querying your snippet database

You can also easily search for snippets, by using the **[hypereval.snippets.search]** event. Below
is an example of a snippet that will find all snippets in your database containing the word _"lambda"_
in their names, for then to display its result in a modal window.

```hyperlambda-snippet
/*
 * Searches your snippets database
 */
hypereval.snippets.search:%lambda%

/*
 * Displays the result of above event in a modal widget.
 */
eval-x:x:/+/*/*/*/pre/*/innerValue
create-widgets
  micro.widgets.modal:foo-bar
    widgets
      h3
        innerValue:'lambda' snippets
      pre
        innerValue:x:/@hypereval.snippets.search
      div
        class:right
        widgets
          button
            innerValue:Close
            onclick
              delete-widget:foo-bar
```

By default, the **[hypereval.snippets.search]** event will only return its first 10 matches, but this
can easily be changed by providing a **[limit]** and an **[offset]** argument. You can also further
parametrize your search by adding a **[type]** criteria, being either _"page"_ or _"startup"_ for
instance.

**[limit]** implies how many snippets to return, and **[offset]** is an offset integer value from the
beginning of its result set, allowing you to easily implement paging and similar types of techniques,
if you want to display your snippets in a datagrid or something.

In addition, you can query your snippets with a **[content]** argument, implying that you snippet must
contain the **[content]** parts in its Hyperlambda. To for instance search for all snippets containing
the text _"create-widget"_, you could use something resembling the following.

**Notice** - You'll need to add a '%' in both your **[content]** and **[\_arg]** criteria, to be able to
do a wildcard match.

```hyperlambda-snippet
/*
 * Searches your snippets database
 */
hypereval.snippets.search
  content:%create-widget%

/*
 * Displays the result of above event in a modal widget.
 */
eval-x:x:/+/*/*/*/pre/*/innerValue
create-widgets
  micro.widgets.modal:foo-bar
    widgets
      h3
        innerValue:'create-widget' snippets
      pre
        innerValue:x:/@hypereval.snippets.search
      div
        class:right
        widgets
          button
            innerValue:Close
            onclick
              delete-widget:foo-bar
```

To retrieve the first 2 snippets of **[type]** "page", you could use the following code.

```hyperlambda-snippet
/*
 * Searches your snippets database
 */
hypereval.snippets.search
  type:page
  limit:2

/*
 * Displays the result of above event in a modal widget.
 */
eval-x:x:/+/*/*/*/pre/*/innerValue
create-widgets
  micro.widgets.modal:foo-bar
    widgets
      h3
        innerValue:'page' snippets
      pre
        innerValue:x:/@hypereval.snippets.search
      div
        class:right
        widgets
          button
            innerValue:Close
            onclick
              delete-widget:foo-bar
```

You can of course combine any of the above arguments to your **[hypereval.snippets.search]** invocations.

### Evaluating multiple snippets at the same time

You can also evaluate multiple snippets at the same time by providing an expression to **[hypereval.snippets.evaluate]**.
For instance, if you wish to evaluate both the _"kitchen-sink"_ and the _"page-viewer"_ snippet sequentially,
you can pass in an expression leading to multiple results. Below is an example.

```hyperlambda-snippet
.snippets
  widgets-kitchen-sink
  page-viewer
hypereval.snippets.evaluate:x:/-/*?name
```

And of course, you can combine any of these Active Events as you see fit, having the results of one becoming
the input to another, by for instance evaluating **[hypereval.snippets.search]**, and passing in the results
of that invocation to **[hypereval.snippets.evaluate]** or **[hypereval.snippets.load]**, etc. This allows you
to easily combine snippets together, with very little syntax, yet still being able to accomplish a lot.

You can also pass in arguments to your **[hypereval.snippets.evaluate]** invocations. Every argument you pass
in, except **[type]** and the **[\_arg]** argument, will be added to your snippet's evaluation, allowing you
to (almost) evaluate a snippet the same way as you would evaluate any other lambda object. Below is an example
that creates two snippets requiring a **[text]** argument, for then to evaluate both of these snippets, passing
in _"Hello World"_ to their evaluation.

```hyperlambda-snippet
/*
 * Creates a snippet that simply shows an information bubble window,
 * displaying the specified [text].
 */
hypereval.snippets.save:foo-bar1
  content
    micro.windows.info:x:/../*/text?value

/*
 * Creates a snippet that creates a paragraph with the specified [text].
 */
hypereval.snippets.save:foo-bar2
  content
    create-widget
      element:h1
      innerValue:x:/../*/text?value

/*
 * Evaluates both of the above snippets, passing in "Hello World" to
 * our evaluation.
 */
.snippets
  foo-bar1
  foo-bar2
hypereval.snippets.evaluate:x:/@.snippets/*?name
  text:Hello World
```

### Creating extension widget snippets

One of my favourites in regards to Hypereval, is the ability to easily create extension widgets, and storing
these in your Hypereval database. This allows you to create highly dynamic and _"agile"_ extension widgets,
that are easily consumed in your own apps and modules. Below is an example of how you could create such an
extension widget.

```hyperlambda-snippet
hypereval.snippets.save:examples.widgets.foo
  content
    eval-x:x:/+/*/literal/*/innerValue
    return
      literal
        style:"background-color:Yellow;"
        element:h3
        innerValue:x:/../*/text?value
```

Then to consume the above extension widget, you could do something resembling the following.

```hyperlambda-snippet
create-widgets
  micro.widgets.modal:foo-bar
    widgets
      h3
        innerValue:Extension widget snippet
      hypereval.snippets.evaluate:examples.widgets.foo
        text:Hello World!
      div
        class:right
        widgets
          button
            innerValue:Close
            onclick
              delete-widget:foo-bar
```

The above allows you by properly namespacing your Hypereval extension snippets, to easily for instance
load up a bunch of dynamically and before hand undetermined extension widgets, which you can easily add
to, such as for instance dynamic toolbars with plugin support, etc, etc, etc. And that you can easily
parametrize as you see fit.
