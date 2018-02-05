## Extension widgets

Although Micro is a general purpose CSS framework, it also contains several useful extension widgets
for Hyperlambda and Phosphorus Five. Below is a list of some of the more important ones.

* __[micro.widgets.tree]__ - A tree view widget
* __[micro.widgets.grid]__ - A _"datagrid"_ type of widget
* __[micro.widgets.modal]__ - A modal window type of widget
* __[micro.widgets.tab]__ - A tab control type of widget
* __[micro.widgets.cover]__ - Covers the entire browser surface, preventing interaction with all other widgets
* __[micro.widgets.wizard-form]__ - A shorthand widget to create form elements
* __[micro.widgets.stars]__ - A star rater widget
* __[micro.widgets.codemirror]__ - A CodeMirror wrapper widget

These widgets can be used in place of any one of the core widgets from Phosphorus Five. If you have Hypereval installed,
you can try out the [kitchen sink example](/hypereval/widgets-kitchen-sink) to see these widgets in practice.

* [Try the kitchen sink example](/hypereval/widgets-kitchen-sink) (requires [Hypereval from the Bazar](/bazar?app=hypereval) to work)

### TreeView

Below is an example of a TreeView widget which traverses the folders on your server.

```hyperlambda
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

            /*
             * This is our treeview widget.
             */
            micro.widgets.tree
              items
                root:/

              /*
               * This one will be invoked when the tree needs items.
               * It will be given an [_item-id] argument.
               */
              .onexpand
                list-folders:x:/../*/_item-id?value
                for-each:x:/@list-folders/*?name
                  split:x:/@_dp?value
                    =:/
                  add:x:/../*/return/*
                    src:@"{0}:{1}"
                      :x:/@split/0/-?name
                      :x:/@_dp?value
                return
                  items
```

The above will resemble something like the following.

https://phosphorusfive.files.wordpress.com/2018/01/tree-view-micro-screenshot.png

The tree widget has two main lambda callbacks, **[.onexpand]** and **[.onselect]**. In our above
example we handle the onexpand lambda, to feed the tree with items. If we wanted to, we could
create an onselect callback, and show an information window with the path the user selects. To
do something like that, you could use the dollowing code.

```hyperlambda
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
            micro.widgets.tree
              items
                root:/

              /*
               * This one will be invoked when an item is selected in the tree.
               * It will be given an [items] collection, with one child for each selected
               * item.
               */
              .onselect
                micro.windows.info:x:/../*/items/0?name
                  class:micro-windows-info success
              .onexpand
                list-folders:x:/../*/_item-id?value
                for-each:x:/@list-folders/*?name
                  split:x:/@_dp?value
                    =:/
                  add:x:/../*/return/*
                    src:@"{0}:{1}"
                      :x:/@split/0/-?name
                      :x:/@_dp?value
                return
                  items
```

The above is 28 lines of code. Creating something similar yourself, would easily require hundreds, if
not thousands of lines of code - Depending upon which programming language you'd use. So the benefits
of these extension widget are probably obvious.

### The datagrid

To create a _"datagrid"_ type of widget, you could do something like the following.

```hyperlambda
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

            /*
             * Our actual datagrid.
             */
            micro.widgets.grid
              class:hover striped
              columns
                Name
                Phone
                Address
              rows
                item
                  Name:Thomas Hansen
                  Phone:90909090
                  Address:Foo bar st. 57
                item
                  Name:John Doe
                  Phone:98989898
                  Address:Foo bar st. 67
                item
                  Name:Jane Doe
                  Phone:37474747
                  Address:Foo bar st. 77
```

Which would result in something resembling the following.

https://phosphorusfive.files.wordpress.com/2018/01/grid-micro-screenshot.png

The datagrid widget can also be dynamically databound, by using the **[micro.widgets.grid.databind]**
event. This allows you to dynamically change its content, to allow for _"paging"_ and _"filtering"_.
Below is an example that is databinding the grid from above only as the user clicks a button.

```hyperlambda
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
            micro.widgets.grid:my-grid
              class:hover striped
              columns
                Name
                Phone
                Address
            button
              innerValue:Databind grid
              onclick

                /*
                 * Dynamically databinds the datagrid we created above.
                 */
                micro.widgets.grid.databind:my-grid
                  item
                    Name:Thomas Hansen
                    Phone:90909090
                    Address:Foo bar st. 57
                  item
                    Name:John Doe
                    Phone:98989898
                    Address:Foo bar st. 67
                  item
                    Name:Jane Doe
                    Phone:37474747
                    Address:Foo bar st. 77
```

### Modal widget

This widget allows you to create a modal window, which will _"obstruct"_ everything else behind
it on the page. Below is an example.

```hyperlambda
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
            button
              innerValue:Show modal window
              onclick

                /*
                 * Here we create our modal widget.
                 */
                create-widgets
                  micro.widgets.modal:my-modal
                    widgets
                      h3
                        innerValue:Foo bar
                      p
                        innerValue:Hello world
                      button
                        innerValue:Close
                        onclick
                          delete-widget:my-modal
```

The above code will create something resembling the following.

https://phosphorusfive.files.wordpress.com/2018/01/modal-micro-screenshot.png

### Tab widget

This widget allows you to create a _"tab control"_ type of widget, to for instance group
related constructs together. Below is an example.

```hyperlambda
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
            micro.widgets.tab
              view
                name:Tab 1
                widgets
                  h3
                    innerValue:First tab
                  p
                    innerValue:This is your first tab view
              view
                name:Tab 2
                widgets
                  h3
                    innerValue:Second tab
                  p
                    innerValue:This is your second tab view
```

The above will result in something resembling the following.

https://phosphorusfive.files.wordpress.com/2018/01/tab-micro-screenshot.png

Notice, you can combine these extension widgets any ways you see fit, to have for instance
a treeview, inside of a tab view, which once clicked displays a modal window, etc. Feel free
to go berserks here ...

There are also other types of extension widgets in Micro. However, unless they're documented here,
in this documentation file, they should not be considered stable and mature enough at the moment
for you to use them in your own projects. Be warned!

### Cover widget

This widget allows you to completely hide all widgets on your page, behind a semi transparent layer,
which prevent interaction with all other widgets on your page. It is useful if you have lenghty operations,
which requires the user to wait until the operation is finisihed.

```hyperlambda
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
            button
              innerValue:Cover
              onclick

                /*
                 * Creating a cover widget, and a timer.
                 * When timer's lambda is evaluated, we delete the cover widget.
                 */
                create-widgets
                  micro.widgets.cover:cover-widget
                    message:Please wait for 2 seconds ...
                micro.lambda.create-timeout
                  milliseconds:2000
                  onfinish
                    delete-widget:cover-widget
```

The above will result in something resembling the following when the button is clicked.

https://phosphorusfive.files.wordpress.com/2018/02/cover-widget-screenshot.png

### Wizard form

This widget provides a convenient short hand for creating form input elements, such as textboxes, radio buttons, etc.


```hyperlambda
micro.css.include
create-widget
  class:container
  widgets
    div
      class:row
      widgets
        div
          class:col bg air-inner shaded rounded
          widgets
            h3
              innerValue:Wizard form
            micro.widgets.wizard-form:wizard-form
              text
                info:Name
                .data-field:name
              textarea
                info:Address
                .data-field:address
              checkbox
                info:Permanent
                .data-field:permanent
              radio-group
                .data-field:sex
                options
                  male:male
                    info:Male
                  female:female
                    info:Female
              select
                .data-field:hair
                info:Hair
                options
                  Short:short
                  Long:long
              button
                innerValue:Save
                onclick
                  micro.form.serialize:wizard-form
                  create-widgets
                    micro.widgets.modal:modal-widget
                      widgets
                        h3
                          innerValue:Values
                        pre
                          innerValue:x:/@micro.form.serialize
                        div
                          class:right
                          widgets
                            button
                              innerValue:Close
                              onclick
                                delete-widget:modal-widget
```

The above will result in something resembling the following.

https://phosphorusfive.files.wordpress.com/2018/02/wizard-form-widget-screenshot.png

This widget is particularly useful when combined with **[micro.form.serialize]**, since it allows for doing
a lot, with very little code.

### Star widget

This widget creates a star rating widget, allowing the user to rate some object, with a one through n value.


```hyperlambda
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
            micro.widgets.stars:stars
              value:2
              max:7
```

The above will result in something resembling the following.

https://phosphorusfive.files.wordpress.com/2018/02/stars-widget-screenshot.png

As the user is clicking the above stars, each star will be filled, allowing the user to provide a _"star value"_
to some object. Useful for allowing the user to provide feedback about some object. In addition to **[value]** and
**[max]**, you can also provide a **[read-only]** argument, which if provided, will not allow the user to change
the widget's value. All other arguments are passed in _"as is"_. The star widget also correctly handles the
**[.data-field]** argument automatically, allowing you to easily serialize its value.

### CodeMirror widget

This widget creates a CodeMirror editor for you, that allows you to edit code on your page, providing syntax
highlighting for more than 100 programming languages, in addition to autocomplete, and many more features.


```hyperlambda
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
            micro.widgets.codemirror
              mode:javascript
              value:@"
function foo() {
  alert('Holla senior!');
}
foo();"
```

The above will result in something resembling the following.

https://phosphorusfive.files.wordpress.com/2018/02/codemirror-widget-screenshot.png

The most important arguments to the CodeMirror widget is as follows.

* __[auto-focus]__ - If true, the editor will get initial focus.
* __[height]__ - Height in pixels, percent or any other unit for editor, e.g. _"300px"_.
* __[mode]__ - Language mode for editor, e.g. _"htmlmixed"_, _"hyperlambda"_ or _"javascript"_, etc. Defaults to _"hyperlambda"_.
* __[keys]__ - CodeMirror keyboard-shortcut to JavaScript callback list. E.g. `Ctrl-T:function(){alert('x');}`
* __[value]__ - Initial value of editor.
* __[.data-field]__ - Data field name, used when for instance serialising editor's content.
* __[theme]__ - Optional theme override. If not given, will use the user's settings, defaulting to _"phosphorus"_.
* __[font-size]__ - Optional font size for content. If not given, will use user's settings, defaulting to 9.25pt if no settings exists.
* __[tab-size]__ - Optional tab size. Defaults to 2.

The CodeMirror widget has 57 different themes you can select from, which you can find in the _"/micro/media/codemirror/theme/" folder_.
If no theme is explicitly supplied, it will use the theme settings for teh currently logged in user, and if no
such setting exists, it will default to the _"phosphorus"_ theme. The language modes are the modes supported
by CodeMirror can be found in the _"/micro/media/codemirror/mode/"_ folder.

By default, the CodeMirror widget creates keyboard shortcuts for Tab (indent code), Shift+Tab (de-indent code),
Ctrl+Space (display autocomplete widget), Alt+F (find persistent), CMD/CTRL + F (find), CMD/CTRL + G (go to line number),
Alt+M (maximize editor), Shift+Ctrl+F (replace), Ctrl+G (go to next occurrency during find.

### About these widgets

You can combine these extension widgets any ways you see fit, to have for instance
a treeview, inside of a tab view, which once clicked displays a modal window, etc. Feel free
to go berserks here ...

There are also other types of extension widgets in Micro. However, unless they're documented here,
in this documentation file, they should not be considered stable and mature enough at the moment
for you to use them in your own projects. Be warned!

