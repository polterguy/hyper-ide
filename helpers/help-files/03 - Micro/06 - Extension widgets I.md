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
* __[micro.widgets.upload-button]__ - A button that encpasulates the process of uploading files to your server
* __[micro.widgets.file]__ - Loads up all Hyperlambda files from specified files or a single folder, and treats them as children widgets of self

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

The **[micro.widgets.tree]** widget can also be rendered in _"menu mode"_, which is useful if you want to create
an hierarchical navbar type of widget. If you want to do this, you can override its default **[class]** property,
and set its CSS class to `micro-widgets-tree micro-widgets-tree-navbar`. This will create a responsive navbar/menu
widget, instead of a tree view widget.

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
