## Introduction to Micro

Micro is a microscopic CSS framework, and an Ajax widget library. Although it is built explicitly for Hyperlambda,
and its Ajax widgets, it can still be used by itself, without any Hyperlambda in your projects.
It is inspired by Bootstrap CSS, but builds upon a much more modern approach for its grid system (flexbox grids).
It is also **significantly smaller in size** than Bootstrap CSS.

To include it in a Hyperlambda project, you can use the following code.

```hyperlambda
micro.css.include
```

You can override what skin you want to use by explicitly specify a **[skin]** argument to the above Active Event.
To include it in another type of project, you can add the following code in the `head` section of your HTML file.

```htmlmixed
<link rel='stylesheet' type='text/css' href='/modules/micro/media/micro.css' />
<link rel='stylesheet' type='text/css' href='/modules/micro/media/fonts.css' />
<link rel='stylesheet' type='text/css' href='/modules/micro/media/skins/air.css' />
```

Notice the **[micro.css.include]** Hyperlambda event in out first code example will include both the main CSS file, the fonts for
Micro, and the _"air"_ skin. Or whatever default skin a user has changed his settings to use. You can find all available skins
in the `/modules/micro/media/skins/` folder. In addition to including the CSS files, it will also append an HTTP query parameter at the end of the CSS 
inclusion tag. This query parameter will contain the version number of Micro. This helps you to avoid
using an old Micro version, when a new release of Micro is published, since web browsers won't use their cached
CSS files if any parts of the URL have changed.

You can of course also include Micro CSS manually, either in Hyperlambda using for instance **[p5.web.include-css-file]**, 
or in HTML using meta tags. If you choose this path you have more control, and can for instance avoid 
including any skin files at all, and/or drop including the icons, if you wish to use your own icon files.

**Notice**, just because of that Phosphorus Five and Hyper IDE happens to have its own CSS framework, there
are no reasons why you can't use your own favourite instead, such as Bootstrap or Milligram for instance.
With Phosphorus Five and Hyperlambda you have (almost) 100% perfect control over the resulting HTML markup.
