# Your second real application

In this chapter, we will improve our application from chapter 7. We will use the database in P5 to store our records. In addition, we will make sure it becomes a real CRUD app. It will also become a multi user app, where all users saves their data to the same database. In this chapter, we will build upon what we have learned so far. Technologies used here will include.

* Creating Hyperlambda files, and using them as lambda objects
* A new syntax for declaring widgets
* Widget lambda events
* The P5 database

In addition, we will vaguely touch upon the math parts of P5, adding and subtracting integer values.

## Architecture

We will cretate 4 Hyperlambda files, encapsulating all of our 4 CRUD operations; (C)reate, (R)ead, (U)pdate and (D)elete. This is not a technical prerequiste, but makes it easier for us to apply changes to our app in the future. An example might include changing from the P5 database, to a more scalable database.

By hiding the internals of our app, inside our CRUD database layer, we accommodate for future change, and our application achieves a higher degree of encapsulation.

We will also create the app as a *"CMS app"*, which means that it will be declared as a folder inside of our *"/phosphorusfive/core/p5.webapp/system42/apps/"* folder. This is the preferred way to create more complex apps, consisting of multiple files, since it allows for what is often referred to as *"XCopy deployment"*. The latter implies, that you can simply copy the entire folder where your app is declared, and distribute it to others, having them paste the folder into their *"/apps/"* folder. This give you yet another very useful distribution model for your apps. Especially apps of more complex nature.

## End result

Our end result will resemble the following screenshots.

![alt tag](screenshots/chapter-14-1.png)

Above you can see that we have two pager buttons, which allows the user to move back and forward in the list of contacts. In addition, we have a *"Create"* button, that allows the user to create a new contact. When the user creates, or edits an existing contact, the form will look like the following.

![alt tag](screenshots/chapter-14-2.png)

When the user tries to delete an entry, a modal warning will be shown, asking the user to confirm deletion.

![alt tag](screenshots/chapter-14-3.png)

Basically, the app contains most things you'd expect from a CRUD app. The app will also be designed, such that it is easily extendible, and can be easily modified, to hold other types of data. The user will also be able to *"page"* back and forth. By default, our app will show only 5 contacts at the time. But this can be changed, by modifying a single integer value in our app.

## Let's begin

First create a folder named *"contacts"* inside of your *"/core/p5.webapp/modules/system42/apps/"* folder. We will put our entire application into this folder.

Create a file called *"launch.hl"* inside of your *"/contacts/"* folder. The name of this file is important, since the CMS in System42, will look for a file with that exact name inside of your folder. If the CMS finds this file, it will create a menu item, automatically for us, inside of our *"Apps"* menu dropdown. When this menu item is clicked, it will execute our *"launch.hl"* file. Hence, this file's path, becomes our *"menu item"* to launch our app, in addition to its main startup logic. Our *"launch.hl"* file will contain most of our application's code.

**system42/apps/contacts/launch.hl**

```
/*
 * Our CRUD app's main launcher.
 * Loads the default CMS template.
 * This ensures our menu/navbar is loaded, among other things.
 */
sys42.cms.load-template


/*
 * Creating main UI.
 */
create-widget
  parent:content
  class:col-xs-12
  widgets

    /*
     * Main "datagrid" for app.
     */
    table:contacts-table
      class:table table-striped
      widgets
        thead
          innerValue:<tr><th>Name</th><th>Email</th><th>Phone</th><th>Edit</th><th>Delete</th></tr>
        container:contacts-items
          element:tbody

    /*
     * Add button for our app, that allows user to create new contacts.
     * When clicked, this buttons invokes the widget lambda event, responsible
     * for creating a new contact.
     */
    container
      class:text-right
      widgets
        button
          class:btn btn-primary
          innerValue:Create
          onclick
            sys42.examples.contacts.create

  /*
   * Widget lambda events.
   */
  events

    /*
     * UI wrapper for creating a new contact.
     * Using our "wizard window" to ask user for contact's details.
     */
    sys42.examples.contacts.create

      /*
       * Showing a wizard window, asking user to provide contact details.
       */
      sys42.windows.wizard
        header:Supply contact's details
        body
        data
          name
          email
          phone
        .onok

          /*
           * Passing in the data given by user to our "create" wrapper.
           */
          sys42.windows.wizard.get-values
          add:x:/../*/sys42.utilities.execute-lambda-file
            src:x:/@sys42.windows.wizard.get-values/*
          sys42.utilities.execute-lambda-file:/system42/apps/contacts/crud/create.hl

          /*
           * Databinding our table, since our database has now changed.
           */
          sys42.examples.contacts.databind

    /*
     * "Databinds" our app.
     * Fetches items from our "read" file, and creates table "tr" 
     * items for each item returned from "data layer".
     */
    sys42.examples.contacts.databind

      /*
       * This is a little "lambda expression" trick, to provide default 
       * values for [start] and [end], such that if the caller of this event 
       * doesn't provide these arguments, it will use the values found below.
       */
      start:0
      end:5

      /*
       * Invoking file responsible for retrieving items from our database,
       * making sure we forward evaluate arguments first.
       */
      eval-x:x:/+/*
      sys42.utilities.execute-lambda-file:/system42/apps/contacts/crud/read.hl
        start:x:/../*/start/[0,1]?value
        end:x:/../*/end/[0,1]?value

      /*
       * Checking if above invocation returned zero items, 
       * and if so, returning early.
       */
      if:x:/@sys42.utilities.execute-lambda-file/*?count
        =:int:0
        sys42.windows.info-tip:No more items in database
        return

      /*
       * Making sure we delete tbody HTML widget.
       */
      delete-widget:contacts-items

      /*
       * Creating our table rows, one for each item returned from above 
       * Hyperlambda file invocation.
       */
      apply:x:/../*/create-widget/*/widgets
        src:x:/@sys42.utilities.execute-lambda-file/*
        template
          tr
            widgets
              td
                {innerValue}:x:/*/name?value
              td
                {innerValue}:x:/*/email?value
              td
                {innerValue}:x:/*/phone?value
              td
                widgets
                  button
                    class:btn btn-default btn-xs
                    innerValue:Delete
                    onclick

                      /*
                       * Asking user to confirm action, before we delete item.
                       */
                      sys42.windows.confirm
                        header:Please confirm
                        body:<p>Are you sure you wish to delete this contact?</p>
                        .onok

                          /*
                           * Invoking file responsible for deleting item.
                           * Notice, the argument to this invocation, is 
                           * actually databound in the above [apply].
                           */
                          sys42.utilities.execute-lambda-file:/system42/apps/contacts/crud/delete.hl
                            {id}:x:?value

                          /*
                           * Databinding our table all over again.
                           */
                          sys42.examples.contacts.databind
              td
                widgets
                  button
                    class:btn btn-default btn-xs
                    innerValue:Edit
                    onclick

                      /*
                       * Using a wizard window, passing in existing details for 
                       * contact, asking user to provide his changes.
                       * Notice, the [data] arguments to this invocation, is 
                       * actually databound in the above [apply].
                       */
                      sys42.windows.wizard
                        header:Provide new data
                        body
                        data
                          {name}:x:/*/name?value
                          {email}:x:/*/email?value
                          {phone}:x:/*/phone?value
                        .onok

                          /*
                           * Passing in the data given by user to 
                           * our "edit" wrapper.
                           */
                          sys42.windows.wizard.get-values
                          add:x:/../*/sys42.utilities.execute-lambda-file
                            src:x:/@sys42.windows.wizard.get-values/*
                          sys42.utilities.execute-lambda-file:/system42/apps/contacts/crud/edit.hl
                            {id}:x:?value

                          /*
                           * Databinding our table, since our 
                           * database has now changed.
                           */
                          sys42.examples.contacts.databind

      /*
       * Creating our "pager" button (previous, next).
       */
      add:x:/../*/create-widget/*/widgets
        src
          tr
            widgets
              td
                colspan:5
                class:text-right
                widgets
                  button
                    class:btn btn-default
                    innerValue:&lt;
                    _start:x:/../*/start/[0,1]?value
                    _end:x:/../*/end/[0,1]?value
                    onclick

                      /*
                       * Databinding table over again, making sure we 
                       * fetch the "previous page".
                       */
                      p5.web.widgets.property.get:x:/../*/_event?value
                        _start
                        _end
                      -:x:/@p5.web.widgets.property.get/*/*/_end?value.int
                        _:x:/@p5.web.widgets.property.get/*/*/_start?value.int
                      -:x:/@p5.web.widgets.property.get/*/*/_start?value.int
                        _:x:/./@-?value
                      -:x:/@p5.web.widgets.property.get/*/*/_end?value.int
                        _:x:/./-/@-?value
                      eval-x:x:/+/*
                      sys42.examples.contacts.databind
                        start:x:/./-3?value
                        end:x:/./-2?value

                  button
                    class:btn btn-default
                    innerValue:&gt;
                    _start:x:/../*/start/[0,1]?value
                    _end:x:/../*/end/[0,1]?value
                    onclick

                      /*
                       * Databinding table over again, making 
                       * sure we fetch the "next page".
                       */
                      p5.web.widgets.property.get:x:/../*/_event?value
                        _start
                        _end
                      -:x:/@p5.web.widgets.property.get/*/*/_end?value.int
                        _:x:/@p5.web.widgets.property.get/*/*/_start?value.int
                      +:x:/@p5.web.widgets.property.get/*/*/_start?value.int
                        _:x:/@-?value
                      +:x:/@p5.web.widgets.property.get/*/*/_end?value.int
                        _:x:/@-?value
                      eval-x:x:/+/*
                      sys42.examples.contacts.databind
                        start:x:/./-3?value
                        end:x:/./-2?value

      /*
       * Creating actual tbody HTML table, wrapping our items.
       */
      create-widget:contacts-items
        parent:contacts-table
        element:tbody
        widgets

/*
 * Initially databinding our table widget above.
 */
sys42.examples.contacts.databind
```

### Our CRUD database layer

You cannot run your application just yet though, since it relies upon 4 more files. These files must be created inside a *"crud"* folder, inside of your main app's folder. Hence, first create a folder named *"crud"* inside of your *"/system42/apps/contacts/"* folder, and make sure you create the 4 following files in this folder.

**system42/apps/contacts/crud/create.hl**

```

/*
 * Our "create" wrapper for our CRUD operations.
 * Expects [name], [email] and [phone] arguments.
 */


/*
 * The [src] expression, uses a trick, for adding all arguments supplied to file invocation.
 */
add:x:/../*/insert-data/*
  src:x:/./--
insert-data
  sys42.examples.contact
```

**system42/apps/contacts/crud/delete.hl**

```

/*
 * Our "delete" wrapper for our CRUD operations.
 * Expects [id] argument.
 */



/*
 * Deleting the item with the specified [id] value.
 */
delete-data:x:@"/*/*/sys42.examples.contact/""=:guid:{0}"""
  :x:/../*/id?value
```

**system42/apps/contacts/crud/edit.hl**

```

/*
 * Our "edit" wrapper for our CRUD operations.
 * Expects [id], [name], [email] and [phone] arguments.
 */



/*
 * The [src] expression, uses a trick, for adding all arguments supplied to file invocation,
 * except the [id] argument.
 */
add:x:/../*/update-data/*/*
  src:x:/./--!/../*/id
update-data:x:@"/*/*/sys42.examples.contact/""=:guid:{0}"""
  :x:/../*/id?value
  src
    sys42.examples.contact
```

**system42/apps/contacts/crud/read.hl**

```

/*
 * Our "read" wrapper for our CRUD operations.
 * Expects [start] and [end] arguments.
 */

/*
 * Checking if [start] is more than the number of items in database,
 * or less than 0, and if so, we return early.
 */
select-data:x:/*/*/sys42.examples.contact?count
if:x:/../*/start?value.int
  >=:x:/@select-data?value.int
  or:x:/../*/start?value.int
    <:int:0
  return

select-data:x:/*/*/sys42.examples.contact/[{0},{1}]
  :x:/../*/start?value
  :x:/../*/end?value
return:x:/@select-data/*
```

## Analyzing our code

Arguably, the above application, is our first complete CRUD application. It allows a user to create, read, update and delete contacts. Each contact, consists of a name, an email, and a phone number. The app is relatively easy to modify, to hold other types of data - And although intentionally *not* created with every single best practice from P5 in mind, it isn't too far away from following these either.

### Can you improve it?

First things first. As previously said, although the app is not too far away from following most *"best practices"*, some things in it, could easily be improved. Discuss whether or not there should exist more widget lambda events. Or the app should contain other parts, to make it more clear and generic in nature. For instance, is our CRUD layer _really_ 100% generic? And is the code as clean as it could be?


### CRUD database layer

Our database layer, consists of four files.

* create.hl - Creates new contact items
* read.hl - Reads and returns a list of contact items
* edit.hl - Updates an existing item
* delete.hl - Deletes an existing item.

All of these files can be found in our *"crud"* folder. This design allows us to easily exchange the underlaying database later, to something more scalable for instance. The p5.data database, stores its items in memory, making it perform extremely fast, but also scale badly if you add thousands of records to it.

There are no places in our GUI where we access the database directly in any ways. Hence, our GUI, and our *"model"*, are not dependent upon each other in any ways. This is a *good* thing.

**Discuss**; Are the above filenames the best filenames we could have chosen? Or does there exist a *"better naming convention"* we could have chosen?

### Structure of GUI

Our GUI is relatively nicely structured. It could easily be improved though, since among other things, it *"mixes"* logic and declaration of GUI elements. One improvement that could be applied for instance, would be to instead of having our logic inside of our **[onclick]** Ajax event handlers for our buttons, at line 137, 164, 213 and 238 - We could probably benefit from creating these parts of our app, encapsulated in some widget lambda events, to make sure we have more flexibility in regards to future change of our GUI. This makes it easier for us to change the GUI, without being forced to moving around tons of Ajax event handler code.

Notice, it might be tempting to wrap the above mentioned pieces of logic into Active Events. This would however create bad cohesion, since these Active Events would exist, even if our GUI does not exist. This would reduce *"cohesion"* in our app. To create these as widget lambda events, is probably smarter.

**Homework assignment**; Create widget lambda events for the logic found in our **[onclick]** event handlers specified above.

#### Interesting new GUI ideas

As you may have noticed, we use a syntax for declaring our GUI, that we haven't used before in our examples. This syntax is referred to as *"explicit element declaration syntax"*. It allows you to declare the element you want to use as the widget's main node, and trust the *"implicit type declaration"* for its type. Type here being one of **[literal]**, **[container]** or **[void]**. Consider the following code for instance.

```
create-widget
  parent:content
  widgets
    button
      class:btn btn-default
      innerValue:Foo bar
```

Since we declare an explicit **[innerValue]** in our **[button]** above, the P5 Ajax engine, can easily deduct that the above is a **[literal]** type of widget. This implies that we can use the main node, for another purpose besides declaring its type. In the above code, what we're actually doing, is the exact same as the following code is doing.

```
create-widget
  parent:content
  widgets
    literal
      element:button
      class:btn btn-default
      innerValue:Foo bar
```

However, the first syntax is more condense, since it allows us to get rid of one node in our lambda object. It is also semantically more close to the end result HTML, which sometimes makes it more readable and easy on the eye.

### Interesting facts

The **[sys42.utilities.execute-lambda-file]** Active Event, is being used every time we execute one of our CRUD database files. It simply loads a Hyperlambda file, and execute **[eval]** on it, passing in the arguments it were supplied. This event, allows us to invoke Hyperlambda files, as if they were plain Active Events, or simple lambda objects. This Active Event can also in fact execute multiple files, if you supply an expression, leading to multiple Hyperlambda files.

There is even an overload of this event, which allows you to execute all Hyperlambda files, from a specific folder. The latter allows you to easily create *"startup script folders"* for your app, where every Hyperlambda file within this folder, is automatically executed during installation of your app, etc.

In our **[sys42.examples.contacts.databind]** lambda widget event, we use a little *"trick"*, to apply default values for our **[start]** and **[end]** arguments. The `/[0,1]` iterator we use in our expression at line 100 and 101, simply retrieves the *first* **[start]**/**[end]** nodes from our lambda object. Since arguments to Active Events, are always found before the lambda object for the event itself - This means that if you supply a **[start]** argument when invoking this event, your **[start]** argument will be used. If you do not supply this argument, the first **[start]** node this expression will find, is the one at line 91, where we supply a default value.

For the record, this logic is really useful, but the way it is implemented in our little app, is a little bit *erroneous*. Or rather, to be more specific, potentially *"dangerously implemented"*. Can you spot its dangers? What could we do to change this *"dangerous behavior"*? Hint; Try to imagine what would happen if you created an Active Event who's name was **[start]**.

Interestingly though, our app doesn't contain a single loop. We can get away with this, due to the magic of **[apply]**, which allows us to more easily create a bunch of HTML "tr" widgets, than any looping mechanisms would allow us.

Another interesting detail, is that our database layer, is in no ways (almost) dependent upon the structure of our items. If you want to extend the app, to hold an additional piece of information, such as an address field for instance - Then this does no in any ways require you to change your database layer.

Arguably hence, our *"database layer"* could hence be reused, for every single CRUD app you were ever to create. This would require some few tiny changes though. Can you see which ...?

We can come away with this, thanks to some *"lambda expression magic"* within our database CRUD files. For instance, the code below, which is taken from our *"create.hl"* file ...

```
add:x:/../*/insert-data/*
  src:x:/./--
insert-data
  sys42.examples.contact
```

... allows us to add all arguments given to the file, into our **[insert-data]** invocation.

The reasons for this, is because the `/--` iterator, retrieves *all* elder sibling nodes from its previous result set. Since all arguments, to all lambda invocations, are passed in to our lambda, at the *top* of our lambda object - This imples that our **[add]** expression trick, will actually add all arguments, regardless of how many we supply. This allows you to reuse this CRUD database layer, for almost every single CRUD database operation you'll ever need. The latter happens to be a defining trait of P5, as in allowing you to reuse functionality, not possible to imagine as reusable components in *"traditional programming languages"*.

You can find a similar construct in our *"edit.hl"* file, except here we *exclude* one of the specified arguments, using boolean algeraic lambda expressions. This has to be done, to make sure we exclude the **[id]**, which is actually not a property of our data record, but becomes the value of our main data node, due to the internals of the p5.data database.

### The P5 database

To see the structure of your items, as stored in your database, you can insert a couple of items into your contacts application, and then execute the following code in the Apps/Executor.

```
select-data:x:/*/*/sys42.examples.contact
```

This will show you the structure of your items, as they are stored in your database. Notice the `:guid:` parts, in the value of your nodes. These are automatically created unique IDs, making it easy for you to reference a single item from your database. This is crucial to make it possible to update and delete items from our database. Below is an example of the results of executing the above Hyperlambda.

```
select-data
  sys42.examples.contact:guid:cba30929-04a3-4dc0-9142-905acd438701
    name:Thomas Hansen
    email:thomas@gaiasoul.com
    phone:90909090
```

As previously mentioned, the P5 database stores its items in memory. This makes it perform extremely fast, but also scale relatively badly. It consists of 4 basic Active Events.

* __[select-data]__ - Selects items from your database
* __[insert-data]__ - Inserts items
* __[delete-data]__ - Deletes items
* __[update-data]__ - Updates items

It also contains an additional Active Event called **[append-data]**, that works similarly to **[insert-data]** - Except it forces the item(s) to be inserted at the *end* of our database.

Although the database is memory based, it still persists its items to disc. This means that if you reboot your server, or your web server process is recycled, your items are still there. The database layer is also thread safe.

The database internally actually stores its items as Hyperlambda files. And you can see this for yourselves, by looking at the *"/phosphorusfive/core/p5.webapp/db/db0/"* folder. By default, it will create one Hyperlambda file, for every 32 items you insert into it. It will also create 256 such files, for every folder within its main root folder. This makes changes to the database execute faster, since it doesn't have to persist the entire database upon every change, but only a sub-section of its files. It also ensures that your file system stays responsive, by not putting too many files into one folder - Which among other things tends to make the Windows file systems respond more slowly.

As you insert a lot of items into the database, more and more files will be created. And is you insert more than 32x256 items, a new folder called *"db1"* will be created. The database could in fact, in theory, have been implemented in Hyperlambda - However, it is implemented in C#, within the *"p5.data"* project of P5.

The database relies entirely upon lambda expressions as its *"query language"*. When you query items in the database, realise that what you're actually doing, is evaluating your expressions, with the identity node pointing to a main *"root node"* containing your *entire database*. This *"root node"*, has one child node for each file that exists in the database. Each *"file node"*, contains one node for every *"item"* in your database. This is why a query operation to the database, *always* at the minimum should start out with `:x:/*/*`, plus your actual query iterators following these two iterators.

If you wish to query all your *"web page objects"* for instance, you could accomplish this with the following.

```
select-data:x:/*/*/p5.page
```

#### Practical use-cases for P5's database

As previously mentioned, the P5 database stores its items in memory, making it unsuitable for *"big data"*. However, for smaller data-sets, such as a user's settings, and other types of data, which you know will not exceed some sort of threshold in size, it is perfect. This is especially true, if you require your data to be retrieved rapidly, repeatedly, and frequently. I tend to look at the P5 database, as a type of *"Windows registry"* type of storage, mostly for settings and such.

P5 contains a MySQL data adapter though, for larger data sets, which you can use when you have thousands of records, and the p5.data memory based database simply won't cut it.

### Known unknowns

In our **[onclick]** Ajax event handler, at line 238, we have a couple of invocations to **[+]** and **[-]**. The same is true for our **[onclick]** at line 213. These are math Active Events, allowing us to add and subtract, either some constants, or the result of an expression, from another constant or expression's result.

We will cover these in one of our appendixes. However, if you twist your brain hard, you can probably figure out what they do. Hint; Use `sys42.windows.show-lambda:x:/..` to see the results of these invocations, if you are curious.

In addition we haven't really dissected branching, or the **[if]** parts within our *"read.hl"* file for instance. These topics will be covered in a later chapter.

### Viddi time

In [this video](https://www.youtube.com/watch?v=IAHnfP9_lt0), I walk you through the main parts of the application. If you're reading this book in some sort of paper format, you can find the above video at; https://www.youtube.com/watch?v=IAHnfP9_lt0

[Chapter 15, FYI, P5 is fork friendly, and free-fusable](chapter-15.md)
