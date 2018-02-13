## Hypereval's API

Hypereval has a very rich API, allowing you to automate it, or extend it as you see fit. Every single operation
that Hypereval can do, can be automated or evaluated through its Active Event API. Hypereval can also be
instantiated as an extension widget, allowing you to consume it in your own modules or apps. Below is the
list of API events that Hypereval contains.

### API events

These events are available at any time, and you can use them as you see fit, to retrieve, update, evaluate, or
somehow modify your snippets. These are probably the most important events, as they allow you to easily consume
snippets in your own apps and/or modules, allowing for you to easily orchestrate multiple snipepts together,
incrementally and dynamically building your apps as you see fit.

* __[hypereval.snippets.evaluate]__ - Evaluate the specified snippet(s)
* __[hypereval.snippets.search]__ - Searches your database for snippets (optionally) matching some criteria
* __[hypereval.snippets.load]__ - Loads the specified snippet(s) from your database
* __[hypereval.snippets.save]__ - Saves a snippet to your database
* __[hypereval.snippets.export]__ - Exports snippets from your database
* __[hypereval.snippets.delete]__ - Deletes the specified snippet from your database

### Automation events

These events are only available while Hypereval is physically loaded somehow on your page, and allows you to
automate parts of Hypereval as you see fit. Probably not as useful as the first list of events, but allows you
to extend Hypereval if you wish, and provide your own logic, instead of its default logic, dictated by its
pre-existing UX.

* __[hypereval.widgets.eval.is-running]__ - Returns boolean "true" if Hypereval is running on your page
* __[hypereval.widgets.eval.load-snippet]__ - Loads specified __[\_arg]__ snippet
* __[hypereval.widgets.eval.save-snippet]__ - Saves current code as __[\_arg]__ snippet, with __[type]__ being for instance _"page"_ or _"startup"_
* __[hypereval.widgets.eval.get-code]__ - Returns the current code from your CodeMirror editor
* __[hypereval.widgets.eval.set-code]__ - Sets the CodeMirror editor's code to __[\_arg]__ value
* __[hypereval.widgets.eval.get-current-snippet]__ - Returns current snippet - __[type]__, __[content]__ and __[name]__
* __[hypereval.widgets.eval.show-load-window]__ - Shows the load snippet window
* __[hypereval.widgets.eval.show-save-window]__ - Shows the save snippet window
* __[hypereval.widgets.eval.download-current-snippet]__ - Downloads the current snippet to client
* __[hypereval.widgets.eval.import-files]__ - Imports the specified __[files]__ zip files, and/or Hyperlambda files into your database
* __[hypereval.widgets.eval.new-snippet]__ - Opens up the _"create new snippet"_ window, allowing user to choose to create either an empty snippet, or creating a new snippet from a list of pre-defined templates
* __[hypereval.widgets.eval.evaluate]__ - Evaluates whatever is in the CodeMirror editor
* __[hypereval.widgets.eval.preview]__ - Previews currently loaded _"page"_ snippet in a new browser tab. Only works if current snippet is of type _"page"_
* __[hypereval.widgets.eval.toggle-output]__ - Toggles visibility of output widget
* __[hypereval.widgets.eval.show-delete-window]__ - Deletes currently loaded snippet, asking user to confirm deletion first

### Event sinks

The **[hypereval.widgets-eval]** event will raise an Active Event every time its content has been programmatically
changed, due to saving or loading a new snippet for instance. If you are interested in _"listening in"_ on this
event, feel free to subscribe to it by for instance creating your own widget lambda event, and name it **[hypereval.widgets.eval.active-snippet-changed]**.
