
## Creating custom views

This is a fairly advanced concept, and requires you to understand Hyperlambda. However, it is also extremely
powerful, and literally allows you to take control over every single aspect of the rendering of your app, while
still getting to use your automatically generated Camphora Five _"backend"_. If you choose to create your own
view, then from within your Camphora Five app, you'll see an additional _"eye icon button"_. If you click
this button, you'll see a list of all your views, allowing you to open up this view directly. If your view
is named for instance `some-view`, and your app `address-book`, then the URL to your view will become
`/address-book/some-view`.

From your view, you can take completely control over every aspect of your app, and really do whatever you
want to do. If you want to access your database from your view, then you'll have to use code similar to
the following.

```hyperlambda
/*
 * First open up your main Camphora database connection.
 */
p5.mysql.connect:[camphora]

  /*
   * Then (for instance) select items from your address-book table.
   */
  p5.mysql.select:select * from address-book

    /*
     * Do something with the above results ...
     */
    for-each:x:/@p5.mysql.select/*

      // ... code to handle currently iterated item goes here ...
```

Of course, you could also choose to for instance insert items in your _"view"_. Or really do whatever you wish.
In fact, you don't even need to access your database at all from within your view. You could also create
a _"settings"_ view for instance, or a _"help"_ view, etc, etc, etc.

For details about Hyperlambda, and how to create such custom views, please check out the parts of the
documentation that encapsulates the Hyperlambda parts. To directly open up the Hyperlambda help section,
you can evaluate the Hyperlambda below.

```hyperlambda-snippet
/*
 * Launches the "Hyperlambda" help files section.
 *
 * Click the "Flash" button in the bottom right corner to evaluate
 * this Hyperlambda, and open up the Hyperlambda help files.
 */
hyper-ide.help.display
  folder:@IDE/helpers/help-files/01 - Hyperlambda/
```
