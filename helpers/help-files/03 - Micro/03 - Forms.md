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

<img style="display:block;margin-left:auto;margin-right:auto;max-width:100%;" src="https://phosphorusfive.files.wordpress.com/2018/01/micro-forms-screenshot.png" />

The above form elements doesn't look like much. However, Micro have many additional helper tricks and classes
which you can apply, to style your form slightly better. The most important probably being the `fill` and the `strip` classes.

### Strips

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
                    span
                      widgets
                        input:my-checkbox
                          type:checkbox
                    label
                      innerValue:Checkbox
                      for:my-checkbox
                    button
                      innerValue:Button
```

The above code will end up being rendered like the following.

<img style="display:block;margin-left:auto;margin-right:auto;max-width:100%;" src="https://phosphorusfive.files.wordpress.com/2018/01/micro-strips-screenshot.png" />

### Fill

If you add a tiny little CSS class to our above `class:strip`, making it become `class:strip fill`,
then your strip will fill all available width, whatever that is. It will do this by making sure your
text input element grows to fill whatever space is available for it, after the other elements have taken the
space they need. This little effect allows you to create strips that fills out whatever space you have
assigned to them. You can also apply the `fill` class to textareas, text input elements, etc.

The space you assign to your `strip fill` widgets, can of course be changed by tapping into the column parts
of Micro, from our first chapter.

**Notice** - All form elements, and helper elements, such as the above labels, and our checkbox wrapper,
will have an automatic bottom margin assigned to them. Sometimes this is not what you want, such as when
rendering strips or buttons at the bottom of some related form group. For such cases, you can simply
add the `no-bottom-air` class, which will remove this automatic bottom margin for you. If we were to modify
our above example for instance, to remove the bottom margin, and add a `fill` class to our strip, it would 
look like the following.

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
                      class:no-bottom-air
                    input
                      type:search
                      placeholder:Text ...
                      class:no-bottom-air
                    span
                      class:no-bottom-air
                      widgets
                        input:my-checkbox
                          type:checkbox
                          class:no-bottom-air
                    label
                      innerValue:Checkbox
                      for:my-checkbox
                      class:no-bottom-air
                    button
                      innerValue:Button
                      class:no-bottom-air
```

It does unfortunately become a little bit _"verbose"_, but this is just the way it has to be.
