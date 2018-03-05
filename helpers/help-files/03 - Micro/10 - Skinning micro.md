## Skinning Micro

The skinning system in Micro is cleverly created using CSS variables. This allows you to easily create your own
skins, without having to consciously think much about CSS selectors, etc. To see an example of a skin, you can
evaluate the snippet below, which will open up the _"Aztec"_ skin for you in a Hyper IDE editor.

```hyperlambda-snippet
/*
 * Using Hyper IDE's API to open up the Aztec skin for editing.
 */
hyper-ide.folder-explorer.select-path:/modules/micro/media/skins/aztec.css
```

The Aztec skin loads up a Google font, and changes a couple of CSS selectors. However, most of the _"heavy lifting"_,
as you can clearly see, is implemented by simply changing some few CSS variables. This makes it easy to create
your own skin for Micro, even if you don't know any CSS. Below is a list of the CSS variables you can
modify, and their default values.

```css
:root {
    --font-size: 16px;
    --font-break-size: var(--font-size);
    --color: #555;
    --background: #fbfbfb;
    --button-color: #777;
    --button-background: linear-gradient(#f9f9f9, #b0b0b0);
    --button-toggled-background: linear-gradient(#b0b0b0, #f9f9f9);
    --anchor-color: #5959c9;
    --anchor-hover-color: #007;
    --anchor-active-color: #77e;
    --form-element-color: #777;
    --form-element-background-color: #fdfdfd;
    --form-element-active-background: #ffffff;
    --form-element-disabled-color: #aaa;
    --form-element-disabled-background-color: #e5e5e5;
    --form-element-padding: .5rem;
    --placeholder-color: #ccc;
    --border-color: #bbb;
    --border-radius: .25rem;
    --shadow-color: rgba(0,0,0,.4);
    --success-background: linear-gradient(#efe,#afa);
    --warning-background: linear-gradient(#fee,#fcc);
    --max-viewport-width: 1120px;
    --table-striped-background: rgba(0,0,0,.05);
    --table-selected-background: rgba(0,0,0,.1);
    --table-hover-background: rgba(0,0,0,.1);
    --code-background: var(--background);
}
```

Notice, to allow for nice transitions on buttons, and similar types of elements, the `linear-gradient` parts
of your buttons will only use the top 50% of its values, while consuming the bottom 50% of their values
when activated ot hovered.

If you'd like to create a skin, which only changes the font size of your installation to for instance 24px -
Then you can easily accomplish that by creating a CSS file with the following content, at which point the rest
of your site's appearance will use the default values from the main Micro CSS file.

```css
:root {
    --font-size: 24px;
}
```

Creating a skin such as the above, and consuming it having opened Hyper IDE, would resemble something like the following.

https://phosphorusfive.files.wordpress.com/2018/03/hyper-ide-foo-skin-screenshot.png
