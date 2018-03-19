## Introduction to Hyper IDE

Hyper IDE is a web based integrated development environment. Even though it's main purpose is to allow for easily
developing in primarily Hyperlambda, HTML, CSS and JavaScript, it supports more than 100 programming languages,
to a varying degree. It also works on clients such as your phone and tablet, althought it's probably best used
in combination with a normal computer. Hyper IDE is highly modularised, and easily extendible, and also allows you
to easily customise it, as you see fit. Hyper IDE is entirely built in Hyperlambda, and dependent upon CodeMirror
as its front end code editor.

https://www.youtube.com/watch?v=mWFitx9py80

### The file explorer

To the left at the top of your page, you can find a tree view widget. This will display all the files on your server, 
and allow you to select and open files for editing. The first time you click a folder in the tree view, it will
automatically expand the folder, and display its sub-folders and files. If you choose to explicitly close
the folder later, by clicking the folder icon, you will have to click the folder icon again to expand it.

As you select a file in the file explorer, Hyper IDE will find the correct CodeMirror mode, according to the file
extension of your file. The mapping between file extensions and CodeMirror modes, can be found
in your `/hyper-ide/configuration/extension2cm-instance.hl` file, and you can edit this file to add support for
additional file extensions, and/or CodeMirror modes.

Unless you have explicitly disabled the _"bookmark"_ plugin, you can also retrieve the URL to the currently
selected item from your file explorer, which might be a folder, or a file, which allows you to bookmark files
and folders, or send them to colleagues as URLs.

### The Toolbar

At the top of your page, you can find a toolbar. This toolbar is _"context sensitive"_, and will change
according to what type of object you have selected. If you select a folder, you will be given the option to
create a new file, and/or a sub-folder. If you select a file, you will not be given these options. Hence,
to create a new file or folder, you must first select the folder where you want to place your file.
Try to select back and forth between a file and a folder to see how it changes. Both files and folders
can be renamed. If you hover your mouse over a toolbar button, you will get some information about what
that particular button does.

**Notice**, depending upon what plugins you have (turned on) in your installation, you might
have additional buttons, such as the _"Create new template module"_ plugin, which allows you to create
new apps, by following a _"wizard"_. This button will only be visible when you have selected the `/modules/`
folder. Some plugins are _"context sensitive"_, and only available for
specific folders, and/or specific file extensions. You can also easily extend this toolbar, and create
your own plugins.

### Keyboard shortcuts

Hyper IDE has many keyboard shortcuts. Most of these are created as CodeMirror shortcuts, which implies that
some sort of CodeMirror editor must be active, and have the focus, for the keyboard shortcut to work.
Below is a list of these keyboard shortcuts.

* __Alt+S__ - Saves the active document
* __Alt+W__ - Activates the next open document
* __Alt+Q__ - Activates the previous open document
* __Alt+X__ - Closes the active document
* __Alt+M__ - Maximize the active editor
* __Ctrl+Space__ - Displays the AutoCompleter
* __Tab__ - Indents selected code 2 more spaces
* __Shift+Tab__ - De-indents selected code 2 more spaces
* __Alt+F__ - Search, _"sticky"_ version (regex support)
* __Cx+F__ - Search, _"highlight"_ version (regex support) - Cmd+F on Mac
* __Cx+Alt+F__ - Replace in file. Cmd+Alt+F on Mac
* __Alt+G__ - Go to line number
* __Cx+Z__ - Undo
* __Cx+Shift+Z__ - Redo

**Notice**, on a Mac OS X computer, you'll have to use the **CMD** key where it says _"Cx"_ above, while on other
types of systems, you must use the **CTRL** key. In addition to the above explicit keyboard shortcuts, most modal widgets
can be closed with the _"Escape"_ key and the _"OK"_ button will be clicked with the Carriage Return key.

### Settings

Hyper IDE comes with 57 themes out of the box. These are for the most parts themes that are distributed with
CodeMirror, and allows you to change the background color, font size, etc, of your CodeMirror editor. In addition
Hyper IDE will use your default Phosphorus Five skin, which allows you to change its Micro skin by changing the
skin that your Phosphorus Five installation is using by default. These skins are skins from Micro,
and can be found in the `/modules/micro/media/skins/` folder, and you can probably easily figure out how to
create your own skin and/or theme if you're not happy with the default ones. You can access the settings by
clicking the _"cog"_ in your toolbar. Below is a video demonstrating how these different settings works.

https://www.youtube.com/watch?v=SLNkQm9HC2s

### Plugins

Most features in Hyper IDE can be turned on or off, and some features are only available if you are logged in
as root. In addition, plugins can be turned on or off according to the declarations of plugins in the
file `/modules/hyper-ide/configuration/plugins.hl`. If you want to enable all plugins, you can simply delete this file,
if it exists, since all plugins are enabled by default. If you want to turn off all plugins, you can
create an empty _"plugins.hl"_ file. If you want to only allow some specific plugin, you can create a `plugins.hl` file,
and declare which plugins you want to enable as items in this file.

The available plugins in your installation, can for the most parts be found in your `/modules/hyper-ide/startup/plugins/` 
folder - However, this depends upon your installation, and which additional modules you have installed. Plugins are 
Active Events, and resolved according to their namespace, so any Hyperlambda file, and/or C# module, might in theory 
create plugins for Hyper IDE. This allows you to extend Hyper IDE, without modifying any of the files inside of your 
Hyper IDE folder - Which allows you to extend Hyper IDE, and still easily upgrade to newer versions later, 
without loosing your extensions.

If you want to see all available plugins for your current installation, you can evaluate the following snippet.

```hyperlambda-snippet
.plugins
  ~hyper-ide.folder-plugins.
  ~hyper-ide.plugins.
  ~hyper-ide.global-plugin.
vocabulary:x:/-/*?name
create-widgets
  micro.widgets.modal:all-plugins
    widgets
      h3
        innerValue:Available plugins
      pre
        innerValue:x:/@vocabulary
      div
        class:right
        widgets
          button
            innerValue:Close
            onclick
              delete-widget:all-plugins
```

### Responsiveness

Although Hyper IDE is remarkably responsive, at least compared to Visual Studio, it is a web based IDE. This for obvious
reasons have some benefits, and other disadvantages. One of the disadvantages is that if you expand a huge amount of
folders in your file explorer, and also edit a lot of files at the same time - You might feel that Hyper IDE starts
acting sluggishly and slow. If Hyper IDE starts acting slow on you, then you might benefit from saving your work,
and reloading your page, to make sure you have less active widgets on your page. Typically, you probably wouldn't want
to edit more than a handful of files at the same time, since this would make it start being less responsive.

However, the really cool part, is that Hyper IDE will work on any client you have, capable of displaying HTML,
including your phone ... ;)
