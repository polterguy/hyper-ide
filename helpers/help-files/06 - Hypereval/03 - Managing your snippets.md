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
which is expected to be either _"page"_, _"snippet"_ (default) or _"startup"_.

If you later want to evaluate the above snippet, this can easily be done with the following code.

```hyperlambda-snippet
/*
 * Evaluates the snippet we created above.
 */
hypereval.snippets.evaluate:foo-bar
```

To delete the snippet is equally easy.

```hyperlambda-snippet
/*
 * Evaluates the snippet we created above.
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

If you choose to save your snippet as a _"page"_ __[type]__, then you will create a unique URL, through
which you can load your page. Below is an example.

```hyperlambda-snippet
/*
 * Creates a snippet with the name of "foo-bar"
 * and saves it to your snippets database as a "page".
 */
hypereval.snippets.save:foo-bar
  type:page
  content:@"micro.css.include
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
              delete-widget:foo-bar"
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
hypereval.snippets.search:lambda

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
