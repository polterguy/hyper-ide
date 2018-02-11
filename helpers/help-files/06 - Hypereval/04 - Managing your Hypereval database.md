
## Managing your Hypereval database

You can easily export your snippets database, and import it on another server, or send parts of your snippets
to a friend, or publish them somehow, allowing for sharing your snippets, or parts of them, with whom ever you
want to share them with.

To export your entire snippet collection, you can click the _"zip file icon"_ in Hypereval. This will download
a zip file to your client, containing all snippets from your database. To download a single snippet, simply
open your snippet in Hypereval, and click the download button. To upload a snippet, click the upload icon.
Below is a screenshot emphasizing these icons for you.

https://phosphorusfive.files.wordpress.com/2018/02/hypereval-manage-snippets-screenshot.png

Notice, you can use the API event to export only parts of your snippet database. If you want to for instance
export only snippets starting with the text _"data"_, you can accomplish that with something resembling the
following code.

```hyperlambda-snippet
/*
 * Exports all snipepts from your database starting with
 * the string "data".
 */
hypereval.snippets.export
  filter:data%
```
