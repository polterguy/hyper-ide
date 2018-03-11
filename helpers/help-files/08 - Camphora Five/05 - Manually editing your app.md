
## Manually editing your app

When you have generated your app, you can use Hyper IDE to edit your app's files. If your app's name is
for instance _"address-book"_, then you can find your app's files in the folder _"/modules/address-book/"_.

**Warning** - If you edit your app, for then to later re-generate your app, then your changes will be lost, since
the generating process overwrites all files from your app's folder.

Your app's structure is the same as any other module you have in your Phosphorus Five installation. The
actual process of editing your app though, is beyond the scope of this documentation, and requires you to
understand Hyperlambda. However, for your convenience, I have included a snippet of Hyperlambda below, that
allows you to see all the possible icons you can use for your app. If you want to change your app's icon,
you can evaluate the snippet below, for then to edit your app's _"desktop.hl"_ file, and change the parts
of your `class` property that declares which icon to use.

T.H. Rose Home Cloud, Inc. can also help you edit your app, or create custom apps entirely from scratch for you,
if you require additional features, or custom apps. This is a service we charge for. Feel free to
send us an email at thomas@gaiasoul.com if you want to hear more about these types of services.

```hyperlambda-snippet
/*
 * Loading HTML example file for IcoMoon.
 */
load-file:"/modules/micro/media/fonts-demo.html"

/*
 * Semantically iterating each "icon-x" class from HTML document retrieved above,
 * and adding one "li" element for each into our [create-widgets] invocation below.
 */
html2lambda:x:/@load-file/*?value
for-each:x:@"/@html2lambda/**/\@class/""=:regex:/icon-.{1,}/""?value"
  eval-x:x:/+/*/*/*/*/*
  add:x:/../*/create-widgets/**/ol/*/widgets
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
create-widgets
  micro.widgets.modal:dox-icons-modal
    widgets
      div
        class:air
        widgets
          h3
            innerValue:Icons
          ol
            widgets
      div
        class:right
        widgets
          button
            innerValue:Close
            onclick
              delete-widget:dox-icons-modal
```

Below is an example of a _"desktop.hl"_ file from a Camphora Five generated app. If you change the `icon-paragraph-justify`
parts of your **[class]** declaration to any of the values that you found by evaluating the above Hyperlambda snippet,
your app's desktop icon will change.

```hyperlambda
/*
 * Desktop widget file for Camphora generated apps.
 */
container
  element:a
  role:button
  class:desktop-app button shaded
  widgets
    literal
      element:span

      /*
       * Change the "icon-paragraph-justify" parts below to any
       * of the values found by evaluating the above Hyperlambda.
       */
      class:icon-paragraph-justify desktop-app-icon

    /*
     * ... the rest of your app's "desktop.hl" file ...
     */
```
