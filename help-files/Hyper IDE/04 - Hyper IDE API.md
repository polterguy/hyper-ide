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
* __[desktop.help.display]__ - Displays the help files for Hyper IDE. Optionally pass in **[folder]** to open a specific section of the help files.

Notice that Hyper IDE will also raise the **[hyper-ide.folder-explorer.item-changed]** Active Event when the file
explorer's active item has been changed. The new item selected in the file explorer, will be available as **[\_arg]**
from within your lambda event.

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

### Template project types

If you select the _"/modules/"_ folder, you'll see a _"create new module"_ plugin. By default, there are only a
handful of different project types here, such as _"hello-world"_, _"datagrid"_ and _"angular-todo"_. However,
these are simple template file, which you can extend yourself, with your own module types. To create your own
template module types, create a new file encapsulating your template in your _"/modules/hyper-ide/helpers/app-template/"_
folder. Such template projects can also require additional settings from the user. This can be seen in
[this file](hyper-ide?path=/modules/hyper-ide/helpers/app-templates/datagrid.hl) for instance, which has a
**[.settings]** segment, which is expected to be a lambda object, containing additional widgets, the user
needs to interact with, as he creates a new module.

As the user creates a new module, your new module template file, will be evaluated with a **[name]** argument,
which is the name of the template he chose to create. In addition, all additional **[.settings]** widget's values
will be passed in, allowing you to retrieve these additional settings, as the user supplied them during creation.
Below is a screenshot of how the process of creating such a new template module might appear to the end user.

https://phosphorusfive.files.wordpress.com/2018/03/new-module-screenshot.png

Such template projects might provide a valuable addon to avoid having to repeat repetetive tasks which
are for some reasons necessary to create boiler plate code for, every time you create a new module.

**Notice**, if you add such template new module extensions, you should take care of not loosing your files
as you upgrade Hyper IDE and/or Phosphorus Five.

### Adding your own shell snippets

You can also extend Hyper IDE with custom shell snippets, which allows you to evaluate some piece of bash
code, from within the context of a folder. This is done by adding your shell bash file
inside [this folder](hyper-ide?path=/modules/hyper-ide/helpers/shell-snippets/). These are the shell snippets
the user can select from as he clicks the _"Open terminal window"_ plugin button for a folder.

Such snippets can be shell commands that checks in your code to a Term Service server for instance, or starts
a build process. All such shell snippets will be executed from within the context of the currently selected
folder from your file explorer. Below is a screenshot of which snippets are available out of the box.

https://phosphorusfive.files.wordpress.com/2018/03/shell-snippets-screenshot.png

**Notice**, if you add such shell snippets extensions, you should take care of not loosing your files
as you upgrade Hyper IDE and/or Phosphorus Five.

**Notice** - Instead of adding your own template shell snippets, you can also directly execute a _".sh"_ file.
This allows you to create for instance compiler scripts, and similar types of scripts, as an integral part
of your projects, for then to evaluate them directly by opening up the file, and evaluating it due to
the _"execute shell snippet file"_ plugin, that's distributed directly out of the box with Hyper IDE. You can
also easily create your own plugin, which doesn't have to be a part of Hyper IDE, but which creates a plugin
Active Event to evaluate _".bat"_ files, if you're on a windows system.

### Extending the documentation for Hyper IDE

Also the documentation is extendible, and allows you to easily add your own documentation. All documentation
files are expected to be found in the _"/modules/hyper-ide/helpers/help-files/"_ folder. This allows you to
seemlessly document your own extensions, modules or apps, such that your documentation integrates perfectly
with the existing documentation for Hyper IDE and all other modules.

You can create your own documentation as either Markdown files, and/or Hyperlambda files, which allows
you to create your documentation as an interactive system of rich files, which encapsulates and/or automates
your system, and ways you see fit. If you create a Markdown file (.md), you can also inject snippets of code.
If you inject a Hyperlambda snippet, you can also optionally choose to allow for your reader to evaluate
the snippet inline, on his server, by setting the code mode to `hyperlambda-snippet`. If you click the
pencil icon at the top of the documentation widget, and view the code for the current file for instance,
you can see an example of the latter below.

```hyperlambda-snippet
/*
 * Displays in information "bubble" window.
 */
micro.windows.info:Foo bar
```

To include YouTube videos, and or full-width images, simply add the URL to your video/image inline, in its
own paragraph, in your Markdown file, such as the following is an example of.

https://www.youtube.com/watch?v=mWFitx9py80

**Notice**, if you add such documentation extensions, you should take care of not loosing your files
as you upgrade Hyper IDE and/or Phosphorus Five.

### Extending the general toolbars

Even though you'd probably most of the times want to create specific file types of extension toolbar buttons,
you can also modify the default toolbar buttons, by adding your button/widget into the correct folder
inside of [this folder](/hyper-ide?path=/modules/hyper-ide/helpers/toolbars/). Here you can see all the different
toolbar sections, encapsulated inside of their correct folders, allowing you to globally extend your toolbar
as you see fit.

**Notice**, if you add such toolbar extensions, you should take care of not loosing your files
as you upgrade Hyper IDE and/or Phosphorus Five.

