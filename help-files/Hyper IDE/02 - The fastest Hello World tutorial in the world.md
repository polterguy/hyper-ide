## The fastest Hello World tutorial in the world

The easiest way to get started with Hyper IDE, is to select the `/modules/` folder, for then to click
the _"star"_ button in your toolbar, assuming you have enabled the plugin that allows you to create new modules.
Then name your app _"hello-world"_, and select the `hello-world` type. At which point your screen should resemble
the following.

https://phosphorusfive.files.wordpress.com/2018/03/hell-world-template-screenshot.png

Then simply click the _"Create"_ button, and you're done. If you want to try out your app,
you can [click this link](/hello-world). Your app consists of 5 files, most of which only
serves as a starting ground for your own apps.

* _"desktop.hl"_ - A _"desktop"_ icon
* _"launch.hl"_ - Your app's launcher file
* _"startup.hl"_ - Your app's startup file
* _"install.hl"_ - Evaluated when your app is installed, through for instance the _"Bazar"_
* _"uninstall.hl"_ - Evaluated when your app is uninstalled

The app is a _"Hyperlambda"_ web app. Hyperlambda is a programming language that is native to Phosphorus Five,
and thoroughly documented in the _"Hyperlambda"_ section of this help system.

### The code

Most of the above files are simply created as a wire frame for your own apps. However, the _"launch.hl"_ file
contains a couple of important constructs. The code for your _"launch.hl"_ file first includes Micro's CSS
files. Micro is a grid based CSS framework, that is native to Phosphorus Five. We will look at Micro in
other parts of this documentation.

After it has included Micro, it creates a `container/row/col` wireframe for us, which you'll probably recognise
if you have done some Bootstrap CSS development. Basically this part creates a _"container"_, which contains
one _"row"_, having two _"columns"_, where each column is 100% width. This means that the last column will
be shown beneath the first one.

Inside our second column, we create a wrapper div, which adds some shading and chrome for us, before we include
an <em>'h3'</em> element, followed by a bulleted list, and a button. Our button has an **[onclick]** Ajax event
handler, which once clicked, will change the **[innerValue]** of our button to _"Hello World"_. If you [try your app](/hello-world),
you can view its source, and probably understand the relationship between the above Hyperlambda, and the HTML
it generates.

**Notice**, the _"Hyperlambda"_ parts of this documentation goes through this app in much more detail in
one of its chapters, than we do here.

### Distributing your app

At this point, you can distribute your app, by simply zipping your folder, and give away this zip file to
anyone who wants to install your app on their own server. Installation of such apps, is easily done through
the Desktop module.
