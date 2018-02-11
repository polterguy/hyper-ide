## A 5 minutes introduction to Hyper IDE

Welcome to Hyper IDE. Hyper IDE is an extendible web based integrated development environment, supporting more than
100 programming languages out of the box. Below is a 2 minutes long video, demonstrating some of its features.

https://www.youtube.com/watch?v=mWFitx9py80

### This documentation is "alive"

The above might sound absurd for the uninitiated, but it is arguably true. What I mean by that, is that the
documentation is _"literate"_. This implies that the documentation will sometimes itself evaluate snippets of code,
and interact with your system. This allows you to utilise the tactile parts of your brain, to learn new concepts 
and ideas. A good example is the following snippet.

**Try clicking the flash button inside the code editor below to evaluate this snippet**

```hyperlambda-snippet
create-widgets
  micro.widgets.modal:sample-dox-modal-window
    widgets
      h3
        innerValue:It's alive!
      div
        class:center
        widgets
          img
            src:"https://phosphorusfive.files.wordpress.com/2018/01/it-is-alive.jpg"
      div
        class:right air-top
        widgets
          button
            innerValue:Close
            onclick
              delete-widget:sample-dox-modal-window


```

**Important** - The above Hyperlambda is evaluated on the *server*, making it a much more flexible and rich environment for
creating code that is dynamically evaluated, than that which an online JavaScript editor give you for instance.

If you have [installed Hypereval](/bazar?app=hypereval) from the Bazar, and you have enabled the Hypereval plugin for Hyper IDE,
you can also click the _"Lightning"_ button at the top of this page in your toolbar. This will allow you to copy and paste
example code from this documentation into Hypereval, and modify the code, to further include the tactile nervous system during your 
learning process. See a small video demonstrating this below.

https://www.youtube.com/watch?v=-CA_06giItY

If you have installed Hyper IDE on your own machine or server, you can also edit its documentation files. This allows you
to write comments, and save your own examples, as a part of the documentation itself. Click the _"pencil"_ icon at the
bottom of this page to see this in action.

**Warning**, if you edit the documentation, you need to take care as you upgrade your installation, since this will
overwrite your changes.

### The file explorer

To the left at the top of your page, you can find a tree view widget. This will display all the files on your server, 
and allow you to select and open files for editing. The first time you click a folder in the tree view, it will 
automatically expand the folder, and display its sub-folders and files. If you choose to explicitly close
the folder later, by clicking the plus sign, you will have to click the plus sign again to expand it.

As you select a file in the file explorer, Hyper IDE will find the correct CodeMirror mode, according to the file 
extension of your file. The mapping between file extensions and CodeMirror modes, can be found 
in your `/hyper-ide/configuration/extension2cm-instance.hl` file, and you can edit this file to add support for
additional file extensions, and/or CodeMirror modes.

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
types of systems, you must use the **CTRL** key.

### Settings

Hyper IDE comes with 57 themes out of the box. These are for the most parts themes that are distributed with
CodeMirror, and allows you to change the background color, font size, etc, of your CodeMirror editor. In addition there
are several skins in Hyper IDE. These skins are skins from Micro, and can be found in the `/modules/micro/media/skins/`
folder, and you can probably easily figure out how to create your own skin and/or theme if you're not happy with the
default ones. You can access the settings by clicking the _"cog"_ in your toolbar. Below is a video demonstrating
how these different settings works.

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

### Authorization

Read and write access to files and folders, can be either explicitly granted, or explicitly denied, on a per 
file/folder basis, depending upon which role your users belongs to. This allows you to prevent write access 
to specific files, yet still maintain read access to the same files. You can see how to enable and disable 
read and/or write access to folders and files under the _"Security"_ parts of this documentation.
The following video, also demonstrates some of these features of Hyper IDE.

https://www.youtube.com/watch?v=TLm0nuYzfoc

### License information

<img src="https://phosphorusfive.files.wordpress.com/2017/12/thomas-hansen.jpg" style="float:right;margin-left:3rem;max-width:200px;border-radius:5px;box-shadow:3px 3px 5px rgba(0,0,0,.2);" alt="Thomas Hansen, the creator of Hyper IDE and Phosphorus Five" />

Hyper IDE is Open Source, and distributed under the terms of the GPL license version 3. This (might) have some
implications for you, and your ability to (legally) create closed source applications with it. If you create 
apps that somehow use Hyperlambda, either directly or indirectly, you will have to [obtain a proprietary license](/bazar?app=license),
unless you have already obtained one. Notice for the record, Hyper Core is built on top of Phosphorus Five,
and hence if you consume it to create proprietary software (closed source), you must (and should) obtain a 
proprietary enabling license.

Regardless of whether or not you legally need a license, please realise that maintaining Hyper IDE, and its
associated components, is actually my dayjob. I am therefor 100% dependent upon people's willingness
to supply me with the monetary means to continue my work, which arguably is to help you become better at what you do.
In addition, if you purchase a license, you are also eligible to professional support, and I often find 
myself prioritising feature requests submitted by those who have a valid proprietary license, for obvious reasons.

I have also set the price for a license very low, such that it should not be a hurdle 
for most (professional) developers. Hence, I would therefor encourage you
to [get properly licensed](/bazar?app=license) if you intend to use Hyper IDE or Phosphorus Five
professionally. The purchasing of a professional license is 100% automated, and secured by PayPal, and I provide
a 30 days money back guarantee. When you have obtained a license, Hyper IDE will also stop _"bugging you"_ about 
getting properly licensed.
<br/>

Kind Regards,

Thomas Hansen - The creator of Hyper IDE, Phosphorus Five, Hyperlambda and Hyper Core

<a href="/bazar?app=license">
  <img style="display:block;margin-left:auto;margin-right:auto;" class="shaded rounded" src="https://phosphorusfive.files.wordpress.com/2017/09/license.jpg" alt="Get licensed" />
</a>
