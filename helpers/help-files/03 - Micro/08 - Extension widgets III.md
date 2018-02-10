
## Extension widgets III

This is the continuation from the previous documentation file.

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

You can also optionally pass in a **[accept]** argument, which should be a comma separated file extension list of
accepted file extensions, such as e.g. _".png,.jpg,.jpeg,.gif"_.

**Notice** - The **[physical-file]** argument which is passed into your lambda callback, is the physical filename
of the uploaded file on your server, while the **[original-filename]** argument, is the filename that was supplied
by the client, and the file's original filename. It is necessary to create a unique filename on the server like we
do above, since otherwise we might risk multiple file uploading processes, with similar filenames, overwriting each
others' files.

After the uploading is complete, you are responsible yourself to move the file to whatever folder you want to
permanently store the file within, and/or delete the file from the user's _"/temp/"_ folder. All files are uploaded
to the currently logged in user's _"/temp/"_ folder.

### Folder widget

This widget will load up all Hyperlambda files from the specified **[folder]**, and/or files, and treat these files' content
as children widgets of itself. It is useful for creating toolbars with plugins, encapsulating each toolbar item,
into a separate file. Usage can be found below. Notice, this code doesn't evaluate without an exception, since
you highly likely don't have the specified **[folder]** on your system.

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
            micro.widgets.file
              class:strip right toolbar
              folder:/some-folder/in-your-system/with-a-bunch-of-hyperlambda-files/
              widgets
```

### About these widgets

You can combine these extension widgets any ways you see fit, to have for instance
a treeview, inside of a tab view, which once clicked displays a modal window, etc. Feel free
to go berserks here ...

There are also other types of extension widgets in Micro. However, unless they're documented here,
in this documentation file, they should not be considered stable and mature enough at the moment
for you to use them in your own projects. Be warned!

