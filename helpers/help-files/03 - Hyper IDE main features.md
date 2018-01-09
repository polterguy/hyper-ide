
## A 5 minutes introduction to Hyper IDE

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

**Notice**, depending upon what plugins you happen to have (turned on) in your installation, you might
have additional buttons, such as the _"Create new template module"_ plugin, which allows you to create
an AngularJS and MySQL app, and many other types of apps, by following a _"wizard"_ - But only when you
have selected the `/modules/` folder. Some plugins are _"context sensitive"_, and only available for
specific folders, and/or specific files extensions.

### Keyboard shortcuts

Hyper IDE has many keyboard shortcuts. Most of these are created as CodeMirror keys, which implies that
some sort of CodeMirror editor must be active, and have the focus, for the keyboard shortcut to work.
Below is a list of these keyboard shortcuts.

* __Alt+S__ - Saves the active document
* __Alt+W__ - Activates the next open document
* __Alt+Q__ - Activates the previous open document
* __Alt+X__ - Closes the active document
* __Ctrl+Space__ - Displays the AutoCompleter
* __Tab__ - Indents selected code 2 more spaces
* __Shift+Tab__ - De-indents selected code 2 more spaces
* __Alt+F__ - Search, _"sticky"_ version (regex support)
* __Ctrl+F__ - Search, _"highlight"_ version (regex support) - Cmd+F on Mac
* __Ctrl+Alt+F__ - Replace in file. Cmd+Alt+F on Mac
* __Alt+G__ - Go to line number

**Notice**, on a Mac OS X computer, you'll have to use the **CMD** key where it says _"Ctrl"_ above.

### Settings

Hyper IDE comes with 57 themes out of the box. These are for the most parts themes that are distributed with
CodeMirror, and allows you to change the background color, font, etc of the CodeMirror editor. In addition there
are several skins in Hyper IDE. These skins are skins from Micro, and can be found in the `/modules/micro/media/skins/`
folder, and you can probably easily figure out how to create your own skin and/or theme. You can access the settings by
clicking the _"cog"_ at the top of your page.

### Plugins and access control

Most features in Hyper IDE can be turned off or on, and some features are only available if you are logged in
as root. In addition, plugins can be turned on or off according to the declarations of plugins in the 
file `/hyper-core/configuration/plugins.hl`. If you want to enable all plugins, you can simply delete this file,
if it exists, since all plugins are enabled by default. If you want to turn off all plugins, you can simply
create an empty file. If you want to only allow some specific plugin, you can create a `plugins.hl` file,
and declare which plugins you want to enable as items in this file. The available plugins in your installation,
can for the most parts be found in your `/hyper-ide/startup/plugins/` folder - However, this depends upon your
installation, and which additional modules you have installed.

In addition, read and write access, can be either explicitly granted, or denied, on a per file/folder basis,
and a role basis, depending upon which role some user belongs to. This allows you to prevent write access for 
instance, to specific files, yet still maintain read access to the same files. You can see how to enable
and disable read and/or write access to folders and files under the _"Security"_ parts of this documentation.

### The documentation is extendible

The documentation for Hyper IDE is actually extendible, and allows you to edit it, as you see fit.
This allows you to write inline personal comments, and add to it, as you see fit yourself. To see this in
action, try clicking the _"Edit button"_ (which show a pencil icon) at the bottom right corner of your screen.
Some of the help files are written in Hyperlambda, to provide example code, and allow you to test out concepts
as you read. However, most of them (such as this file) is written in Markdown. Try clicking the _"pencil"_ button
at the bottom right corner of this document to try it out for yourself. When you have saved your edits, you
can view them instantly by clicking the _"refresh"_ button, next to the edit button. Any YouTube videos you include,
will automatically be embedded, such as the example video below illustrates. **Hint**, you can also embed _"unlisted"_
YouTube videos, which allows you to document your own code and projects inline, as an integral part of the IDE 
and code itself.

https://www.youtube.com/watch?v=mWFitx9py80

### License information

Hyper IDE is Open Source, and distributed under the terms of the GPL license version 3. This (might) have some
implications for you, and your ability to (legally) create closed source applications with it. As a general rule
of thumb, if you only use Hyper IDE to create code, and you do not consume any of the underlaying Phosphorus Five
components in any ways - You don't have to worry about this. However, if you create your apps such that they somehow
use Hyperlambda, either directly or indirectly, you will have to [obtain a proprietary license](/bazar?app=license),
unless you have already obtained one. Notice for the record, Hyper Core is built on top of Phosphorus Five,
and hence if you consume it, you must (and should) obtain a proprietary enabling license.

Regardless of whether or not you legally need a license, please realise that maintaining Hyper IDE, and its
associated components, is actually my dayjob. I am therefor 100% dependent upon people's willingness
to supply me with the monetary means to continue my work, which arguably is to help you become better at what you do.
In addition, if you purchase a license, you are also eligible to professional support, and I often find 
myself prioritising feature requests submitted by those who have helped me in monetary ways for obvious reasons.

I have also consciously set the price for a license arguably very low, such that it should not be a hurdle 
for most (professional) developers. Hence, I would therefor encourage you
to [get properly licensed](/bazar?app=license) if you intend to use Hyper IDE or Phosphorus Five
professionally. The purchasing of a professional license is 100% automated, and secured by PayPal, and I provide
a 30 days money back guarantee. When you have obtained a license, Hyper IDE will also stop _"bugging you"_, asking
you to get properly licensed.

<a href="/bazar?app=license">
  <img style="display:block;margin-left:auto;margin-right:auto;" class="shaded rounded" src="https://phosphorusfive.files.wordpress.com/2017/09/license.jpg" alt="Get licensed" />
</a>
