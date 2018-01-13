
## Icons

Micro includes the IcoMoon icon collection, which you can read about in the credits section of these help files.
There are 200 different icons you can use, and they all obey by the same syntax. If you wish to see which icons
you have at your disposal, you can check out [the following link](/modules/micro/media/fonts-demo.html).

You would normally include these by adding an additional span, and settings its CSS class, to whatever
icon you want to use. Below is an example.

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

