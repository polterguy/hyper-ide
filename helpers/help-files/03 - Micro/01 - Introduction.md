## Introduction to Micro

Micro is a microscopic CSS framework, and an Ajax widget library. Although it is built explicitly for Hyperlambda,
and its Ajax widgets, it can still be used by itself, without any Hyperlambda in your projects.
It is inspired by Bootstrap CSS, but builds upon a much more modern approach for its grid system (flexbox grids).

To include it in a Hyperlambda project, you can use the following code.

```hyperlambda
micro.css.include
  skin:serious
```

To include it in another type of project, you can add the following code in the `head` section of your HTML file.

```htmlmixed
<link rel='stylesheet' type='text/css' href='/modules/micro/media/main.css' />
<link rel='stylesheet' type='text/css' href='/modules/micro/media/fonts.css' />
<link rel='stylesheet' type='text/css' href='/modules/micro/media/skins/serious.css' />
```

Notice the **[micro.css.include]** Hyperlambda event above, will include both the main CSS file, the fonts for
Micro, and the _"serious"_ skin. You can find all available skins in the `/modules/micro/media/skins/` folder.
In addition to including the CSS files, it will also append an HTTP QUERY parameter at the end of the CSS 
inclusion tag. This QUERY parameter will contain the version number of Micro. This helps you to avoid
using an old Micro version, when a new release of Micro is published, since web browsers won't use their cached
CSS files if any parts of the URL have changed.

**Notice**, just because of that Phosphorus Five and Hyper IDE happens to have its own CSS framework, there
are no reasons why you can't use your own favourite instead, such as Bootstrap CSS or Milligram for instance.
