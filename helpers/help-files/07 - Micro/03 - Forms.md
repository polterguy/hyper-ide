## Form elements in Micro

Contrary to Bootstrap, Micro will automatically style all of your form elements. To see how 
the different form elements looks like, you can change your Hypereval snippet from our 
previous chapter, and exchange its code with the following.

```hyperlambda
/*
 * Includes Micro's CSS files.
 */
micro.css.include
  skin:serious

/*
 * Creating one container with one row containing one col.
 */
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
              class:air-inner shaded rounded
              widgets
                input
                  type:text
                  placeholder:Some text ...
                br
                literal
                  element:textarea
                  placeholder:Some multiline text ...
                br
                select
                  widgets
                    option
                      innerValue:Foo
                    option
                      innerValue:Bar
                br
                input
                  type:checkbox
                input
                  type:radio
                br
                input
                  type:submit
                  value:Submit
                button
                  innerValue:Click
```

The above code will resemble the following.

https://phosphorusfive.files.wordpress.com/2018/01/micro-forms-screenshot.png

The above form elements doesn't look like much. However, Micro have many additional helper tricks and classes
which you can apply, to style your form slightly better. The most important probably being the `fill` and the `strip` classes,
which we will look at further down in this document.

## Labels, checkboxes and radio buttons

In Micro if you want to create a label for your checkbox or radio buttons, you'll have to wrap your
checkbox/radio button inside your label. This is any ways an advantage, since it will allow the user to click the
actual label to change the checked value of your checkbox/radio button. Below is an example.

```hyperlambda
/*
 * Includes Micro's CSS files.
 */
micro.css.include
  skin:serious

/*
 * Creating one container with one row containing one col.
 */
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
              class:air-inner shaded rounded
              widgets
                label
                  widgets
                    span
                      innerValue:Checkbox
                    input
                      type:checkbox
                label
                  widgets
                    span
                      innerValue:Radio button 1
                    input
                      type:radio
                      name:rdo-1
                label
                  widgets
                    span
                      innerValue:Radio button 2
                    input
                      type:radio
                      name:rdo-1
```

Notice how both checkbox elements and radio buttons are styled such that you can modify their color,
background color, size, etc. This is just one of the tricks that Micro applies to create a better foundation
for your own designs. This was one of the crucial design criteria as Micro was conceptualized, the ability to
style any element you want to us in your app, exactly as you want to style it. In fact, checkbox and radio buttons
have been historically largely rendered impossible to use because of the difficulty in styling them according to your
own needs. Micro fixes that problem by intelligently tapping into CSS3 features, allowing us to actually style
these elements again.

## Strips

A `strip` is a bunch of related form elements. You can combine any form elements using strips, and _"couple"_ them
nicely together, to give visual clues to the user that these are related concepts. Basically, create a wrapper
div, set its CSS class to `strip`, and add any form elements inside of it as you see fit. Below is an example.

```hyperlambda
/*
 * Includes Micro's CSS files.
 */
micro.css.include
  skin:serious

/*
 * Creating one container with one row containing one col.
 */
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
              class:shaded air-inner bg rounded
              widgets
                div
                  class:strip
                  widgets
                    label
                      innerValue:Label
                    input
                      type:search
                      placeholder:Text ...
                    label
                      widgets
                        span
                          innerValue:Checkbox
                        input
                          type:checkbox
                    button
                      innerValue:Button
```

The above code will end up being rendered like the following.

https://phosphorusfive.files.wordpress.com/2018/01/strips-micro-screenshot.png

Notice, you cannot add a textarea into a strip. Besides from that, all other form elements are nicely
rendered inside of your strips. This makes strips a nice way for you to create _"toolbar"_ types of
elements in your own solutions.

Notice, you can mix strips with the `left`, `right` and `fill` classes, to further modify your strip's behaviour.
If you want to have multiple toolbars side by side for instance, but which wraps unto multiple lines if the
viewport of your browser doesn't have room to show them all - You can add up for instance the `right` class,
on your strip element. This will render your toolbars side by side, but only if there's room for them all.

Below is an example illustrating this.

```hyperlambda
/*
 * Includes Micro's CSS files.
 */
micro.css.include
  skin:serious

/*
 * Creating one container with one row containing one col.
 */
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
              class:strip right air-left
              widgets
                label
                  innerValue:Label
                input
                  type:text
                  placeholder:Text ...
                label
                  widgets
                    span
                      innerValue:Checkbox
                    input
                      type:checkbox
                button
                  innerValue:Button
            div
              class:strip right
              widgets
                button
                  innerValue:Second strip
                button
                  innerValue:Btn
                button
                  innerValue:Btn
```

## Fill

If you add a tiny little CSS class to our above `class:strip`, making it become `class:strip fill`,
then your strip will fill all available width, whatever that is. It will do this by making sure your
text input or select elements grows to fill whatever space is available for it, after the other elements have taken the
space they need. This little effect allows you to create strips that fills out whatever space you have
assigned to them. You can also apply the `fill` class to textareas, text input elements, etc.

The space you assign to your `strip fill` widgets, can of course be changed by tapping into the column parts
of Micro, from our first chapter.

If we were to modify our above example for instance, to add a `fill` class to our strip, 
it would look like the following.

```hyperlambda
/*
 * Includes Micro's CSS files.
 */
micro.css.include
  skin:serious

/*
 * Creating one container with one row containing one col.
 */
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
              class:shaded air-inner bg rounded
              widgets
                div
                  class:strip fill
                  widgets
                    label
                      innerValue:Label
                    input
                      type:search
                      placeholder:Text ...
                    label
                      widgets
                        span
                          innerValue:Checkbox
                        input
                          type:checkbox
                    button
                      innerValue:Button
```

The `fill` class can also be used on single input elements, textarea elements, or select elements.
If you add a fill class to a strip element though, you must have at the minimum one input text type
of element, or a select list in it for it to work.

