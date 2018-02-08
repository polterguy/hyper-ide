## Extension widgets II

This is the continuation from the previous documentation file.

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

By default, the CodeMirror widget has the following default keyboard shortcuts.

* __Tab__ - Indent code
* __Shift+Tab__ - De-indent code
* __Ctrl+Space__ - Display autocompleter
* __Alt+F__ - Persistent search dialog
* __Ctrl+F__ or __Cmd+F__ (Mac) - Search in document
* __Ctrl+G__ or __Cmd+G__ (Mac) - Go to next search result in document
* __Alt+M__ - Maximize CodeMirror widget (fills entire browser surface)
* __Shift+Ctrl+F__ - Replace in document
* __Alt+G__ - Go to specified line number
* __Ctrl+Z__ or __Cmd+Z__ - Undo
* __Shift+Ctrl+Z__ or __Shift+Cmd+Z__ - Redo

The supported modes for the CodeMirror editor is as follows.

* apl
* asciiarmor
* asn.1
* asterisk
* brainfuck
* clike (C#, C++, C, Java, etc)
* clojure
* cmake
* cobol
* coffescript
* commonlisp
* crystal
* css
* cypher
* d
* dart
* diff
* django
* dockerfile
* dtd
* dylan
* ebnf
* ecl
* eiffel
* elm
* erlang
* factor
* fcl
* forth
* fortran
* gas
* gfm
* gherkin
* go
* groovy
* haml
* handlebars
* haskell
* haskell-iterate
* haxe
* htmlembedded
* htmlmixed
* http
* hyperlambda (default mode)
* idl
* javascript
* jinja2
* jsx
* julia
* livescript
* lua
* markdown
* mathematica
* mbox
* mirc
* mllike
* modelica
* mscgen
* mumps
* nginx
* nsis
* ntriples
* octave
* oz
* pascal
* pegjs
* perl
* php
* pig
* powershell
* properties
* protobug
* pug
* puppet
* python
* q
* r
* rpm
* rst
* ruby
* rust
* sas
* sass
* scheme
* shell
* sieve
* slim
* smalltalk
* smarty
* solr
* soy
* sparql
* spreadsheet
* sql
* stylus
* swift
* tcl
* textile
* tiddlywiki
* tiki
* toml
* tornado
* troff
* ttcn
* ttcn-cfg
* turtle
* twig
* vb
* vbscript
* velocity
* verilog
* vhdl
* vuew
* webidl
* xml
* xquery
* yacas
* yaml
* yaml-frontmatter
* z80

### Upload widget

The **[micro.widgets.upload-button]** encapsulates the process of uploading files to your server. It simply creates
a button, which allows you to upload one (or multiple) files to your server. It requires an **[.onupload]** lambda
callback, which will be invoked with a **[files]** argument once the user has uploaded one or more files to your
server. Below is an example of usage.


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
            div
              class:bg air-inner shaded rounded
              widgets
                h3
                  innerValue:Upload files
                micro.widgets.upload-button
                  multiple
                  .onupload
                    create-widget
                      element:pre
                      innerValue:x:/..
```

You can optionally pass in a **[multiple]** argument, to allow for multiple files to be uploaded at the same time.
All other arguments becomes directly added to the button itself, allowing you to override its class or style
property, etc. Below is a screenshot of how this widget might look like, and the results of evaluating the above code.

https://phosphorusfive.files.wordpress.com/2018/02/upload-widget-screenshot.png

**Notice** - The **[physical-file]** argument which is passed into your lambda callback, is the physical filename
of the uploaded file on your server, while the **[original-filename]** argument, is the filename that was supplied
by the client, and the file's original filename. It is necessary to create a unique filename on the server like we
do above, since otherwise we might risk multiple file uploading processes, with similar filenames, overwriting each
others' files.

After the uploading is complete, you are responsible yourself to move the file to whatever folder you want to
permanently store the file within, and/or delete the file from the user's _"/temp/"_ folder. All files are uploaded
to the currently logged in user's _"/temp/"_ folder.

### About these widgets

You can combine these extension widgets any ways you see fit, to have for instance
a treeview, inside of a tab view, which once clicked displays a modal window, etc. Feel free
to go berserks here ...

There are also other types of extension widgets in Micro. However, unless they're documented here,
in this documentation file, they should not be considered stable and mature enough at the moment
for you to use them in your own projects. Be warned!

