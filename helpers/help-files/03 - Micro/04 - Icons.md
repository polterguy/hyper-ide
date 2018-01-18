## Icons

Micro includes the IcoMoon icon collection, which you can read about in the credits section of these help files.
There are 200 different icons you can use, and they all obey by the same syntax. You would normally include 
these by adding an additional span, and settings its CSS class, to whatever icon you want to use. Below is an 
example.

```hyperlambda
/*
 * Includes Micro's CSS files.
 */
micro.css.include
  skin:serious

/*
 * Creating a simple container with one button inside, with the "flash" icon.
 */
create-widget
  class:container
  widgets
    button
      widgets
        literal
          class:icon-flash
```

When you add icons to buttons for instance, it is wise to add them inside of their own `span`, and somehow
have that span be a child element of your actual button. You **cannot** add the icon class directly on your button.
Below is a snippet you can evaluate to show all icons in Micro.

```hyperlambda-snippet

/*
 * Loading HTML example file for IcoMoon.
 */
load-file:"/modules/micro/media/fonts-demo.html"

/*
 * Semantically iterating each "icon-x" class from HTML document retrieved above,
 * and adding one "li" element for each into our [create-widget] invocation below.
 */
html2lambda:x:/@load-file/*?value
for-each:x:@"/@html2lambda/**/\@class/""=:regex:/icon-.{1,}/""?value"
  eval-x:x:/+/*/*/*/*/*
  add:x:/../*/create-widget/**/ol/*/widgets
    src
      container
        element:li
        widgets
          span
            innerValue:
            class:x:/@_dp?value
          span
            innerValue:" - "
          span
            innerValue:x:/@_dp?value

/*
 * Creating a widget wrapping each icon from IcoMoon.
 */
create-widget
  parent:hyper-ide-help-content
  style:"font-size:24px;"
  widgets
    ol
      widgets
```

Below is an example of a strip with 3 buttons, each having their own icon.

```hyperlambda
micro.css.include
  skin:graphite
create-widget
  class:container
  widgets
    div
      class:strip
      widgets
        button
          widgets
            literal
              element:span
              class:icon-flash
        button
          widgets
            literal
              element:span
              class:icon-home3
        button
          widgets
            literal
              element:span
              class:icon-gift
```

If you are not satisfied with the icons included in Micro by default, you can easily generate your own set
of icons using the [IcoMoon select icons app](https://icomoon.io/app/#/select), and start out with for instance 
Font Awesome, etc. The IcoMoon icon set includes dozens of different icon sets, you can mix as you see fit,
and which perfectly plugs into Micro.

