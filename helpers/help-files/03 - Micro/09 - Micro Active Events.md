## Micro Active Events

Micro also contains a whole range of additional Active Events, solving particular tasks in your
daily use of Phosphorus Five. Below is a list of some of the more important ones.

* __[micro.css.add]__ - Adds a CSS class to one or more widgets
* __[micro.css.delete]__ - Deletes a CSS class from one or more widgets
* __[micro.css.toggle]__ - Toggles a CSS class in one or more widgets
* __[micro.css.include]__ - Includes Micro CSS on your page
* __[micro.download.file]__ - Downloads a file to the client
* __[micro.form.serialize]__ - Retrieve all form element values beneath some widget
* __[micro.google.translate]__ - Translates the given text using Google Translate
* __[micro.page.set-focus]__ - Sets the focus to a widget on your page
* __[micro.speech.listen]__ - Listens for input using speech recognition
* __[micro.speech.speak]__ - Speaks the given text
* __[micro.speech.stop]__ - Stops listening and speaking, if active
* __[micro.speech.query-voices]__ - Queries available voices from your client
* __[micro.windows.info]__ - Shows a small information _"bubble window"_
* __[micro.url.get-entities]__ - Returns each folder of the URL for the current request

In addition to the above Active Events, you can find some additional Active Events if you look
at Micro's code. However, the above are the ones I consider _"stable"_ at the time of writing.
Be warned! Also be warned that only Google Chrome currently supports speech recognition.
So the listen event from our above list, won't work with any other types of clients than Google
Chrome.

### CSS helper Active Events

There are three basic CSS events to help you modify your widget's CSS classes. These are as follows.

* __[micro.css.add]__
* __[micro.css.delete]__
* __[micro.css.toggle]__

They all expect an ID to one or more widgets, and a **[class]** argument, declaring which class(es) you
wish to delete, add, or toggle. Below is an example of using all of them.

```hyperlambda
micro.css.include
  skin:graphite
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
              class:strip
              widgets
                button
                  innerValue:Delete
                  class:success
                  onclick
                    micro.css.delete:x:/../*/_event?value
                      class:success
                button
                  innerValue:Add
                  onclick
                    micro.css.add:x:/../*/_event?value
                      class:success
                button
                  innerValue:Toggle
                  onclick
                    micro.css.toggle:x:/../*/_event?value
                      class:success
```

The fourth Active Event, **[micro.css.include]**, simply includes Micro on your page. It can optionally
be given either the name of a skin, or an absolute path to another CSS skin file you have created
yourself.

### Downloading files to the client

The **[micro.file.download]** is pretty self explaining. It simply downloads a file to the client.
You can test it with the following code.

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
            button
              innerValue:Download
              onclick
                micro.download.file:@MICRO/README.md
```

### Serializing forms

The **[micro.form.serialize]** serializes all form elements beneath some specified widget. It uses a fairly
intelligent construct to create _"friendly names"_ for your form elements, based upon a hidden attribute
called **[.data-field]**. The data-field value becomes the name of your form element values when this event
is invoked. Below is an example of usage.

```hyperlambda
micro.css.include
create-widget
  class:container
  widgets
    div
      class:row
      widgets
        div
          class:col-50 offset-25
          widgets
            div:my-form
              class:air-inner bg shaded rounded
              widgets
                input
                  type:text
                  class:fill
                  placeholder:Name ...
                  .data-field:name
                literal
                  element:textarea
                  placeholder:Address ...
                  .data-field:address
                  class:fill
                button
                  innerValue:Serialize
                  onclick

                    /*
                     * Serializing our form and displaying the result in a modal window.
                     */
                    micro.form.serialize:my-form
                    eval-x:x:/+/**
                    create-widgets
                      micro.widgets.modal
                        widgets
                          h3
                            innerValue:Your values
                          pre
                            innerValue:x:/@micro.form.serialize

```

The above will result in something resembling the following.

https://phosphorusfive.files.wordpress.com/2018/01/micro-serialize-screenshot.png

And of course when the _"Serialize"_ button is clicked, it will resemble the following.

https://phosphorusfive.files.wordpress.com/2018/01/micro-serialize-after-screenshot.png

One detail in regards to select elements and radio buttons, is that these needs one additional
attribute, due to their _"pluralistic nature"_. This attribute is called **[.data-value]**, and should
be declared for each _"option"_ or radio input element, inside of the same radio input group.
Below is an example of serializing a select element to illustrate this concept.

```hyperlambda
micro.css.include
create-widget
  class:container
  widgets
    div
      class:row
      widgets
        div
          class:col-50 offset-25
          widgets
            div:my-form
              class:air-inner bg shaded rounded
              widgets
                select
                  .data-field:city
                  widgets
                    option
                      innerValue:New York
                      .data-value:new-york
                    option
                      innerValue:San Francisco
                      .data-value:san-francisco
                button
                  innerValue:Serialize
                  onclick
                    micro.form.serialize:my-form
                    eval-x:x:/+/**
                    create-widgets
                      micro.widgets.modal
                        widgets
                          h3
                            innerValue:Your values
                          pre
                            innerValue:x:/@micro.form.serialize
```

### Using Google Translate

The **[micro.google.translate]** Active Event is fairly self describing. It optionally takes two arguments.

* __[dest-lang]__ - Mandatory language you want to translate text into
* __[src-lang]__ - If ommitted, will be automatically determined by Google Translate

Consuming it might resemble the following.

```hyperlambda
micro.css.include
micro.google.translate:Hello world
  dest-lang:NB-no
micro.windows.info:x:/-?value
```

### Setting focus to elements

The **[micro.page.focus]** Active Event is fairly self describing. Pass in the ID to whatever widget
you want to give focus to.

### Micro's speech Active Events

There are four basic Active Events which helps you with speech recognition and speech synthesis, these are
as follows.

* __[micro.speech.listen]__
* __[micro.speech.speak]__
* __[micro.speech.stop]__
* __[micro.speech.query-voices]__

To have the computer speak some sentence for instance, you can use the following code.

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
            button
              innerValue:Talk to me
              onclick
                micro.speech.speak:Hello there, my name is John Doe
```

You can optionally pass in a **[voice]** argument, which you can give a value of either a named voice, which
you can fetch by querying the voice API on the client - Or to a language code, such as for instance _"NB-no"_.
Try adding `voice:Alex` for instance to the above code.

Both the listen and speak events can optionally take an **[onfinish]** lambda callback, which if specified, will
be evaluated after the operation is finished. If you pass in an onfinish lambda to the **[micro.speech.listen]**
event, then a **[text]** argument will be passed into your lambda callback, with the text that the speech
recognition engine was capable of recognizing. Below is an example.

```hyperlambda
micro.css.include
create-widget
  class:container
  events

    /*
     * Waits for speech input, reads it out loud, and restarts the input loop.
     */
    examples.capture-speech

      /*
       * Listens for input.
       */
      micro.speech.listen
        onfinish

          /*
           * Speaks the input with the "Karen" voice.
           * Notice, make sure the Karen voice exists in your client, 
           * before you try to run this example.
           */
          micro.speech.speak:x:/../*/text?value
            voice:Karen

          /*
           * "Recursively" invokes self.
           */
          examples.capture-speech

  widgets
    div
      class:row
      widgets
        div
          class:col
          widgets
            button
              innerValue:Talk to me
              onclick

                /*
                 * Starts "input loop".
                 */
                examples.capture-speech

            button
              innerValue:Stop
              onclick

                /*
                 * Stops speech engine (both speak and listen).
                 */
                micro.speech.stop
```


### Information "bubble" windows

The **[micro.windows.info]** is a _"bubble"_ window, for displaying feedback to the user, in a non-intrusive
way. Simply pass in whatever text you want for it to display, and optinally pas in a **[class]** argument.
Notice, if you pass in an explicit class, you'd probably want to make sure you **also add micro-windows-info**
to your class list, since otherwise it'll probably look weird. Below is an example.

```hyperlambda
micro.css.include
  skin:graphite
create-widget
  class:container
  widgets
    div
      class:row
      widgets
        div
          class:col
          widgets
            button
              innerValue:Click me
              onclick
                micro.windows.info:Hello world
                  class:micro-windows-info success
```

### Retrieving URL's entities

The **[micro.url.get-entities]** event will return all URL _"entities"_ for you, implying all folders
for the current request, without any query parameters. If your URL is for instance _"/foo/bar/howdy?some=query"_, it
will return the following.

```hyperlambda
micro.url.get-entities
  foo
  bar
  howdy
```

This makes it easy for you to retrieve the different parts and sub parts of the current request's URL, without
having to manually parse it yourself, using for instance **[split]** etc.