## The fastest Hello World tutorial in the world

The easiest way to get started with Hyper IDE, is to select the `/modules/` folder, for then to click
the `+` button in your toolbar, assuming you have enabled the plugin that allows you to create a new module.
Then name your app _"hello-world"_, and select the `hello-world` type. At which point your screen should resemble
the following.

https://phosphorusfive.files.wordpress.com/2018/01/hello-world-screenshot.png

Then simply click the _"Create"_ button, and you're done. If you want to try out your app,
you can [click this link](/hello-world). Your app consists of 5 files, most of which only
serves as a starting ground for your own app.

* _"desktop.hl"_ - A _"desktop"_ icon
* _"launch.hl"_ - Your app's launcher file
* _"startup.hl"_ - Your app's startup file
* _"install.hl"_ - Evaluated when your app is installed, through for instance the _"Bazar"_
* _"uninstall.hl"_ - Evaluated when your app is uninstalled

The app is a _"Hyperlambda"_ web app. Hyperlambda is a programming language which is native to Phosphorus Five
and thoroughly documented in other parts of this help system. Below is a screenshot of our result.

https://phosphorusfive.files.wordpress.com/2018/01/hyper-ide-hello-world-screenshot.png

### The code

Most of the above files are simply created as a wire frame for your own apps. However, the _"launch.hl"_ file
contains a couple of important constructs. I have included the entire file for you below, such that you can
see it for yourself.

```hyperlambda
/*
 * Includes CSS for our module.
 */
p5.web.include-css-file
  @MICRO/media/main.css
  @MICRO/media/fonts.css
  @MICRO/media/skins/serious.css

/*
 * Creating main wire frame for module.
 */
create-widget
  class:container
  widgets
    div
      class:row
      widgets
        div
          class:col-100
          widgets
            div
              class:right
              widgets
                div
                  class:strip toolbar
                  style:"display:inline-block;"
                  widgets
                    button
                      innerValue:@"<span class=""icon-home3""></span>"
                      onclick

                        /*
                         * Redirecting user to server's root URL.
                         */
                        p5.web.get-root-location
                        p5.web.set-location:x:/-?value

        div
          class:col-100
          widgets
            div
              class:air-inner shaded rounded bg
              widgets
                h3
                  innerValue:Hello World
                p
                  innerValue:@"Here is a template for your convenience, creating a default startup module wire frame for you.
It contains 4 files."
                ul
                  widgets
                    li
                      innerValue:<code>'launch.hl'</code> - This is the file that is evaluated when your module is launched
                    li
                      innerValue:<code>'desktop.hl'</code> - This creates a 'desktop icon' for your module
                    li
                      innerValue:<code>'startup.hl'</code> - Evaluated when the server is started
                    li
                      innerValue:<code>'install.hl'</code> - Evaluated when your module is installed
                    li
                      innerValue:<code>'uninstall.hl'</code> - Evaluated when your module is uninstalled
                button:foo-button
                  innerValue:Click me!
                  onclick
                    set-widget-property:foo-button
                      innerValue:Hello World
```

The above code first includes Micro's CSS files. Micro is a grid based CSS framework, which is native to
Phosphorus Five. In later chapters, we will dive deep into Micro.

After it has included Micro, it creates a `container/row/col` wireframe for us, which you'll probably recognise
if you have done some Bootstrap CSS development. Basically this part creates a _"container"_, which contains
one _"row"_, having two _"columns"_, where each column is 100% width. This means that the last column will
be shown beneath the first one.

Inside our second column, we create a wrapper div, which adds some shading and chrome for us, before we include
an <em>'h3'</em> element, followed by a bulleted list, and a button. Our button has an **[onclick]** Ajax event
handler, which once clicked, will change the **[innerValue]** of our button to _"Hello World"_. If you [try your app](/hello-world),
you can view its source, and probably understand the relationship between the above Hyperlambda, and the HTML
it generates.

### Distributing your app

At this point, you can distribute your app, through the integrated _"Bazar"_ if you wish. The Bazar is
an integrated _"App Store"_ for Phosphorus Five, allowing you to setup your own _"App Store"_, to distribute
your own apps. Later we will dive into exactly how you can do this. If you want to see
the Bazar, you can visit [this link](/bazar). The Bazar allows you to distribute your apps for a fee,
or for gratis, through its PayPal integration.
