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
 * Creating a modal window, now with on "li" element for each icon from our IcoMoon set.
 */
create-widget
  parent:hyper-ide-help-content
  widgets
    ol
      widgets
```

