## Hyper IDE's API

Hyper IDE has a rich API, which allows you to automate tasks, and extend it as you see fit. Below is a list
of all Active Events that are available when Hyper IDE is open.

* __[hyper-ide.is-open]__ - Return true if Hyper IDE is open
* __[hyper-ide.folder-explorer.select-path]__ - Expands the specified **[\_arg]** path in your folder explorer, and starts the correct editor, if you are giving it a path to a file
* __[hyper-ide.folder-explorer.set-active-item]__ - Sets the active folder explorer item. Notice, will not expand folders as the above event will, but expects the specified **[\_arg]** folder/file to already have been loaded in your folder explorer
* __[hyper-ide.folder-explorer.get-active-item]__ - Returns the active folder explorer item to caller
* __[hyper-ide.folder-explorer.refresh-active-folder]__ - Reloads the currently active item in your file explorer
* __[hyper-ide.active-editor.get-filepath]__ - Returns the path of the currently edited file, if any
* __[hyper-ide.active-editor.get-id]__ - Returns the ID of the currently active editor, if any
* __[hyper-ide.active-editor.get-code]__ - Returns the code for the currently active editor, if any
* __[hyper-ide.active-editor.set-code]__ - Sets the code for the currently active editor
* __[hyper-ide.active-editor.is-clean]__ - Returns false if your currently active editor has unsaved changes
* __[hyper-ide.active-editor.set-clean]__ - Sets the clean flag for your currently active editor, pass in "true" or "false"
* __[hyper-ide.active-editor.save]__ - Saves your currently active editor
* __[hyper-ide.active-editor.close]__ - Closes your currently active editor
* __[hyper-ide.editors.get-open-editors]__ - Returns the file path to all open editors
* __[hyper-ide.editors.set-active-editor]__ - Sets the currently active editor, requires the editor to already have been opened
* __[hyper-ide.editors.activate-previous-editor]__ - Activates the previous available editor
* __[hyper-ide.editors.activate-next-editor]__ - Activates the next available editor
* __[hyper-ide.editors.close]__ - Closes one or more editors. Pass in **[filter]** being a file/folder path which will declare which editors it will close, and **[exact]** being boolean true, if you only want to close the editor with the exact matching **[filter]** path

### Creating plugins for Hyper IDE

Hyper IDE easily allows you to create your own plugins. These plugins can be global plugins, at which point
they're available all the time - Or they can be plugins that are only available if some specific type of editor
is your active editor. Below is an example of a plugin that will show an information bubble window, but which will
only be available if your edited file is an HTML type of file.

```hyperlambda-snippet
/*
 * Creates our bubble window HTML plugin.
 */
create-event:hyper-ide.plugins.htmlmixed.is-html-file
  return
    button
      innerValue:@"<span class=""icon-question""></span>"
      title:Shows an information window
      onclick

        /*
         * Displays an information "bubble" window.
         */
        micro.windows.info:This is an HTML file!
```

If you evaluate the code above, for then to edit an HTML file, you will see that you've got an additional
toolbar button, which once clicked displays an information bubble window for you.

Hyper IDE will automatically figure out which plugins to load according to their Active Event names. The naming
convention for this is as follows `hyper-ide.plugins.code-mirror-mode.plugin-name`. From our above example,
`htmlmixed` is the CodeMirror mode name for files that are HTML files. Hence, Hyper IDE will load up that
additional plugin button, every time you open an HTML file for editing. To create a similar information bubble
window for CSS files, you can do so with the following code.

```hyperlambda-snippet
/*
 * Creates our bubble window CSS plugin.
 */
create-event:hyper-ide.plugins.css.is-css-file
  return
    button
      innerValue:@"<span class=""icon-question""></span>"
      title:Shows an information window
      onclick

        /*
         * Displays an information "bubble" window.
         */
        micro.windows.info:This is a CSS file!
```

If you want to create a plugin which is only available when a folder is selected in your file explorer, you
can change the above `.plugins.` to `.folder-plugin.`. If you want to create a plugin which is only available
when some specific folder is activated, you'll need to use the **[hyper-ide.folder-explorer.get-active-item]**
lambda event to determine which folder has been activated, before returning your plugin to caller. The
**[hyper-ide.folder-plugins.create-module]** plugin illustrates this, since it's only available when the _"/modules/"_
folder is activated.

Notice, even though most plugins in Hyper IDE are simple buttons, creating any type of plugin, being for instance
a textbox, or a select widget, is easily accomplished, as long as whatever you return from your plugin Active Event,
can somehow be stuffed inside of a Micro _"strip"_ widget.

If you want to create a global plugin for Hyper IDE, which is always always available, regardless of which file or
folder object is active in your file explorer, you can do so with the following naming
convention `hyper-ide.global-plugin.YOUR-PLUGIN-NAME`.

### Hyper IDE as a plugin

You can also consume Hyper IDE in your own application, as an extension widget. This extension widget's Active Event
name is **[hyper-ide.widgets.ide]**. This allows you to in its entirely load up Hyper IDE as an extension widget
in your own applications. Whether or not this makes sense or not, is arguably questionable. However, it may have
uses for you, when debugging your applications - So I've chosen to allow for it. Notice, if you consume Hyper IDE
as an extension widget, you're responsible yourself to load up its CSS file. This can be done with the following
code.

```hyperlambda
/*
 * Loads Hyper IDE's CSS file, for then to instantiate the Hyper IDE
 * extension widget.
 */
p5.web.include-css-file:@IDE/media/main.css
create-widgets
  hyper-ide.widgets.ide
```

By explicitly choosing to not load Hyper IDE's CSS file, this allows you to override the CSS classes used for the
editor, to customise its appearance, by creating your own CSS file(s), and change its content. Notice, you can
only instantiate Hyper IDE once on your page. Hence, make sure you check to see if it's already open, before you
create your extension widget. Evaluating the above code while Hyper IDE is already open, will raise an exception.

