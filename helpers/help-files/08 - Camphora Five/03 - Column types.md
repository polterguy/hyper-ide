## Column types

There are several different types of columns you can choose from when creating your fields. Below is a complete
list, and their most important traits explained.

* __Singleline text__ - A single line text type of field
* __Multiline text__ - Multiple lines of text field
* __Checkbox__ - A yes/no type of field
* __Number__ - A way for you to provide a number type of input
* __Select dropdown__ - Allows the user to select from a pre-defined set of different options
* __Radiobuttons__ - Similar to select dropdown, but will display the different options as radiobuttons, where the user must select only one value, from a pre-defined set of values
* __Date/time created__ - Not per se an input field, but an automatically created field, that allows you to track when the item was actually created

Some of the above field types have unique traits, such as for instance the _"Multiline text"_ type of field, which
allows the user to actually provide Markdown, and/or #hash_tags, to easily allow for filtering items, and displaying
content with rich formatting. Below is a screenshot of how a Multiline text item with both Markdown content,
and a hashtag might appear for you - Both during editing, and during viewing the item in the datagrid.

https://phosphorusfive.files.wordpress.com/2018/03/camphora-five-markdown-has-tags-screenshot.png

Hashtags allows you to provide integral filtering capacity, as a part of your item's Multiline content, which
might be useful for categorising your items, and easily later retrieve items according to their multiline text
content. If you click the hashtag in your multiline text content, Camphora Five will filter your items, and
only display items containing that specific hashtag. The syntax for Markdown is really beyond the scope of
this documentation, but you can find several good references on Markdown, such as for
instance [this one](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet). Markdown is however
a very powerful syntax, and allows you to easily embed images, hyperlinks, and even tables, in addition to
basic formatting, as an integral part of your item's content.

The _"Date/time created"_ field type, is not really an input field, and cannot be changed - But rather serves
to track at what exact date and time your item was created.

### Select and radiobutton fields

These items allows the user to select a value from a pre-defined list of options. When you create such items,
the field type definition will split in two, and expect you to supply a comma separated list of pre-defined
values, from which the end user can select from, as he is creating new items, or editing existing items.
An example of such a field could for instance be _"sex"_, containing a comma separated list of the following
values; `male,female`. When the user is creating or editing an item, he will have to choose from only _"female"_
or _"male"_ as his value for that specific column. The screenshot above illustrates this fairly well, since
it contains a _"Radiobutton"_ type of field, which asks the user to supply the value for the _"sex"_ column.

These types of columns also allows the user to filter items during _"gridview"_, by only items matching
the specified value. This can be done by simply clicking for instance a _"female"_ value in your datagrid.
This will automatically populate your filter textbox, with the value necessary to filter your items, by only
items matching the specified value, for only the specified column.

### Checkbox fields

A checkbox column type, simply allows the user to select _"yes/no"_ type of values, since either the checkbox
has been checked, or not.

### Date/time created fields

This field, will simply track when the item was created, and cannot be edited after the item has been created.
This can be useful to track the date and time of creation, and will be displayed as the exact date and time
of creation as you read your item later.

