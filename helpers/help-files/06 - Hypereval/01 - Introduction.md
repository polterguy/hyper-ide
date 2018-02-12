## Introduction to Hypereval

Hypereval is a Phosphorus Five module that allows you to easily store snippets of Hyperlambda in
your MySQL database. This has a lot of benefits, such as allowing you to create spikes and snippets
of code, which you can more easily move around, and are more _"dynamic"_ in nature, than a fully
fledged app or module.

Hypereval allows you to store these snippets as _"startup"_ snippets, _"page"_ snippets, or simply
_"snippets"_. A startup snippet is a snippet that is evaluated every time your web server process
is restarted, which makes it easy for you to for instance create dynamic Active Events, which are
created every time your server restarts. A page snippet is a web page, and has its own unique URL,
and can be launched through `/hypereval/your-page-name`. A plain snippet is simply a snippet, and
are not evaluated in any ways, unless you explicitly request evaluating it somehow.

Below is a screenshot of Hypereval.

https://phosphorusfive.files.wordpress.com/2018/02/hypereval-screenshot.png

Since Hypereval has a very rich API, you can easily evaluate any of your snippets, by using one of
its API methods. Hypereval has the following features.

* Easily Create, Read, Update and Delete (CRUD) your snippets
* Evaluate Hyperlambda in _"immediate mode"_
* View output or result of evaluation
* Download your snippets, either individually or all of them combined in a _"backup zip file"_
* Easily upload one or more snippets, either as individual Hyperlambda files, or contained in a backup zip file
* Easily create _"web pages"_, which are snippets, having their own unique (and search engine friendly) URLs

**Notice** - Hypereval is _not installed by the main Phosphorus Five installation file_. If you want to
use Hypereval, you'll need to [install it explicitly through the Bazar](/bazar?app=hypereval). Hypereval
also depends upon MySQL. So you'll need access to some MySQL database to use it. You might also have
to edit your _"web.config"_ file, to make sure your MySQL connection string is correctly pointing to
your database server.

### Keyboard shortcuts

* __Alt+E__ - Evaluates the current snippet
* __Alt+S__ - Saves the current snippet
* __Alt+L__ - Loads a snippet from your database
* __Alt+P__ - Previews your current snippet. Only applicable if your current snippet as a _"page"_ snippet
* __Alt+V__ - Toggles the _"output CodeMirror instance"_
* __Alt+N__ - Creates a new snippet (optionally) from a template
* __Alt+D__ - Deletes the current snippet

In addition, Hypereval also have all the default keyboard shortcutes, which are applicable for all
CodeMirror modules, such as as __Alt+M__ to maximize the CodeMirror editor, __Tab__ and __Shift+Tab__
to indent and deindent your code (selection?), etc.

### Consuming Hypereval as a _"plugin"_

Hypereval can also be consumed as a _"plugin"_, allowing you to use it yourself, in your own apps. This is
quite useful when you are debugging your apps for instance, to give you meta capabilities during runtime,
in your debugging environment. To instantiate Hypereval as a _"plugin"_, you can simply create an instance
of the **[hypereval.widgets.eval]** widget. Below is an example.

```hyperlambda-snippet
create-widgets
  micro.widgets.modal:sample-modal
    widgets
      h3
        innerValue:Hypereval as a 'plugin'
      hypereval.widgets.eval
      div
        class:right
        widgets
          button
            innerValue:Close
            onclick
              delete-widget:sample-modal
```

In fact, if you have installed Hypereval, you can open it up as a _"plugin"_ from Hyper IDE, by clicking the flash
button in the top toolbar of Hyper IDE.
