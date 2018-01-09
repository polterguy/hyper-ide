# Your first real application

In this chapter, we will create a contacts application, allowing us to keep track of our friends, their emails, and phone numbers. Below is a screenshot of our final result.

![alt tag](screenshots/chapter-7-1.png)

Before we can dive into our application though, there are some concepts we'll need to cover first.

* Loading and saving of files
* Parts of the folder structure of Phosphorus Five
* The **[apply]** Active Event
* Widget lambda events

## Loading and saving files

In P5, there are two important events for loading and saving files. These are **[load-file]** and **[save-file]**. Before we start using them though, we'll need to have a look at the folder structure of P5.

Open up the folder *"/phosphorusfive/core/p5.webapp/"*. This is the main root folder for your web application. The most important folder for this chapter is called *"users"*. This folder will contain one folder for each user you have in your P5 installation. By default, P5 has only one user, which is your *"root"* user - So typically as you start out with P5, there will only be one folder inside of your *"users"* folder. This folder will be the *"root"* folder.

Inside of your user's folder, the *"root"* folder that is, you can find a *"documents"* folder. This is the equivalent of *"Your documents"* in windows, or *"Home"* in Linux. This is important to understand for this chapter, since we will store our *"database"* within this folder. Our file will be named *"adr.hl"*. The extension *".hl"* implies *"[H]yper - [L]ambda"*.

Your *"documents"* folder, contains two folders. One *"private"* folder, and another *"public"* folder. We will be using the *"private"* folder, to store a file, containing the data for our CRUD application. Files inside of this folder, cannot in general, be accessed by anyone, except the user whom these files belongs to. Hence, they are your user's *"private files"*.

To reference files inside of your user's home folder, you can prepend your path with a tilde `~/`. If you start out a filename with a tilde, this will automatically save a file to your user's home folder. If you want to create a file inside of your private documents folder, you can use something resembling the following code.

```
save-file:~/documents/private/foo.txt
  src:Hello filesystem!
```

If you execute the above code in your Apps/Executor, it will create a simple text file for you, inside of your private documents folder. To understand why, realize that the tilde `~` will be substituted with *"/users/username"*, before the file is saved. The *"username"* parts of the path, depends upon which user is logged in, invoking the **[save-file]** event.

Since the root folder for *everything* related to files in P5, is the main root web application folder, this means your file can be found within *"/phosphorusfive/core/p5.webapp/users/root/documents/private/"* - Where ever that is locally within your system. Notice, this assumes you're using the source code version of Phosphorus Five. If you have deployed your system into a Linux production environment, typically the file will end up somewhere inside of _"/var/www/html/users/root/documents/private/"_ somewhere.

## The [apply] event

The **[apply]** Active event, is kind of like the *"Superman version"* of **[add]**. It allows you to take a data source, and combine it with a template, to create an entire hierarchy of nodes, and append into some destination, applying your template for each **[src]** result node set.

We will be using this Active Event, to dynamically create an HTML table, from the content of your data file, containing the *"database"* for your contacts.

It might help to visualize the **[apply]** event as *"braiding"* together a data source and a template, to produce a combined results. If you find this concept difficult to understand, then don't despair, since there's a video at the end of this chapter, explaining it in details.

## Widget lambda events

As vaguely touched upon in one of our previous chapters, a widget can associate Active Events with itself. These are *"local"* events, that only exists, for as long as the widget itself exists. We will create one widget lambda event like this, to *"databind"* our HTML table.

We will create this event with the name of **[sys42.examples.databind-addresses]**. This event can be invoked just like a normal Active Event. If we wanted to, we could also pass in arguments, and return arguments from it, just as if it was a normal event. We do not need to neither pass in, nor return any arguments from it though. We simply need to *"databind"* our HTML table element within it. Which we will do, by loading our database file, and create an HTML table widget, for each **[item]** in our file.

## The code for our application

With these concepts, at least partially covered, let's move on to the code, and show you the entire listing for an Address book web app. Create a new *"lambda"* page in System42's CMS, and make sure you replace the existing code with the code listed below.

```
/*
 * Creating our main application wrapper widget.
 * This widget contains at the very least our "add contact" button, 
 * in addition to also possible an HTML table, dynamically created, 
 * according to the content of our "database file".
 */
create-widget:app_wrapper
  parent:content
  class:col-xs-12 text-right
  oninit

    /*
     * Making sure we initially databind our address HTML table, 
     * by invoking our "widget lambda event", that is declared 
     * further down on page.
     */
    sys42.examples.databind-addresses

  widgets

    /*
     * This becomes the wrapper widget for our HTML table, 
     * containing our "list of contacts".
     */
    container:table_wrapper
      class:text-left

    /*
     * This becomes our "create new contact button".
     */
    literal:add_btn
      element:button
      class:btn btn-default
      innerValue:+
      style:"width:200px;"
      onclick

        /*
         * Using a "wizard window" to retrieve name, 
         * email and phone from user.
         */
        sys42.windows.wizard
          header:Supply contact information
          body:<p>Please supply the details for your record</p>
          data
            name
            email
            phone
          .onok

            /*
             * Temporary variable containing the content of our "database".
             */
            _content

            /*
             * Retrieving data supplied by user.
             */
            sys42.windows.wizard.get-values

            /*
             * Loading database file, if it exists, and appending 
             * its old values into our [save-file] invocation.
             */
            file-exists:~/documents/private/adr.hl
            if:x:/@file-exists/*?value

              // File exists, appending content into [_content] below.
              load-file:~/documents/private/adr.hl
              add:x:/../*/_content
                src:x:/@load-file/*/*

            /*
             * Then appending the values supplied by user for new record.
             * Notice, we append the entire [sys42.windows.wizard.get-values] 
             * node, for then to later change its name to [item].
             */
            add:x:/@_content
              src:x:/@sys42.windows.wizard.get-values
            set:x:/@_content/*/sys42.windows.wizard.get-values?name
              src:item

            /*
             * Converting our [_content] node's content to Hyperlambda (string),
             * and saving it to disc.
             */
            lambda2hyper:x:/@_content/*
            save-file:~/documents/private/adr.hl
              src:x:/@lambda2hyper?value

            /*
             * Making sure we databind our HTML table again, to make sure 
             * our newly added record is shown.
             */
            sys42.examples.databind-addresses

  /*
   * This is our "widget lambda events".
   */
  events
  
    /*
     * The "databind" table event.
     *
     * This Active Event simply loads our "database file", and creates 
     * our HTML table accordingly.
     *
     * The first line in our event, becomes its name, meaning we can 
     * invoke it by simply adding a node with a name matching this 
     * Active Event's name.
     */
    sys42.examples.databind-addresses

      /*
       * This invocation clears our HTML table wrapper widget for 
       * any previous content.
       */
      clear-widget:table_wrapper

      /*
       * Here we check if our "database file" exists.
       */
      file-exists:~/documents/private/adr.hl
      if:x:/@file-exists/*?value

        /*
         * There exists a database.
         * Loading it, and creating our HTML table accordingly.
         */
        load-file:~/documents/private/adr.hl

        /*
         * Notice, here we use [apply], to dynamically append to our 
         * [create-widget] invocation's children [widgets].
         */
        apply:x:/..if/*/create-widget/*/widgets/*/container/*/widgets
          src:x:/@load-file/*/*
          template
            container
              element:tr
              widgets
                literal
                  element:td
                  {innerValue}:x:/*/name?value
                literal
                  element:td
                  {innerValue}:x:/*/email?value
                literal
                  element:td
                  {innerValue}:x:/*/phone?value

        /*
         * Now our "tbody" HTML widget below should contain on "tr" widget 
         * for each row from our "database file".
         * Each "tr" widget again, should contain one "td" widget for the name,
         * email and phone from our contact.
         */
        create-widget:contacts_table
          parent:table_wrapper
          element:table
          class:table table-striped
          widgets
            literal
              element:thead
              innerValue:<tr><th>Name</th><th>Email</th><th>Phone</th></tr>
            container
              element:tbody
              widgets
```

Although most of the above concepts are things we have already covered, there are some new things in there, which we will have to walk through, in order to understand everything that's going on.

### [apply] in details

As previously mentioned, the **[apply]** Active Event, allows you to braid together a data **[src]**, with a **[template]**, and put the results into some destination. The destination is expected to be the value of the main **[apply]** node, and must be an expression leading to one or more nodes. The destination must return a node somehow, usually implying it should be type declared as a `?node` type of expression. Which you may remember from a previous chapter, was the default type declaration of an expression.

Its **[src]** argument, is expected to be an expression, also leading to a node-set somehow. The way to envision the **[src]** argument, is that **[apply]** iterates over its **[src]** result set, and uses the currently iterated node, as the idenity node, for creating a lambda object, based upon the **[template]**.

The **[template]** hence, is being created once for each result from the **[src]** expression, having every iteration, use the currently iterated **[src]** node, as its identity node.

#### Databound expressions in [apply]

Assuming you've copied the code above exactly, line for line, and added no additional whitespace - You can see one of the data bound expressions in your code editor at line 144, where it says `{innerValue}:x:/*/name?value`.

Such a databound expression, is declared by making sure its name starts with a `{`and ending with a `}`. These two parts of your node's name are removed though, before the node is created, and appended into its destination. They are simply there to inform **[apply]** about that this is a databound node. Hence, to declare a databound node, simply wrap its name inside of curly braces, and add up an expression being its relative path, to whatever you wish to databind the node's value towards.

The expression in the value of a data bound node, is local for the currently iterated **[src]** result. This means that the *"idenity"* node for the first iteration, is in fact not the **[{innerValue}]** node itself, but rather the first item from our **[load-file]** invocation.

#### Semantics of [load-file] when loading Hyperlambda files

At this point, it might be useful to realize that our invocation to **[load-file]**, will in fact automatically convert Hyperlambda files into a lambda object, unless you explicitly tell it not to. So our **[load-file]**, after invocation, will in fact not yield plain text, but in fact an entire lambda hierarchy. It will resemble the following example.

```
/* ... rest of code ... */

load-file
  /users/root/documents/private/adr.hl
    item
      name:Thomas Hansen
      email:thomas@gaiasoul.com
      phone:98765432
    item
      name:John Doe
      email:john@doe.com
      phone:99887766

/* ... rest of code ... */
```

So what our **[src]** argument to **[apply]** is actually pointing to, are the **[item]** nodes returned from **[load-file]**. It probably helps to lock this mental picture into your mind, and realize that the **[src]** expression to **[apply]** hence, is actually iterating over every single **[item]** from your _"database file"_.

This means that when we write `:x:/*/name?value` inside of a databound node, like we do in our first data bound node at line 144, this expression is for the first iteration of our **[src]** argument, relative to the first **[item]** from the results of our **[load-file]** invocation above. For the second iteration, it is relative to the second **[item]**, and so on. So what is added to our **[widget]** hierarchy, becomes something similar to the following.

```
container
  element:tr
  widgets
    literal
      element:td
      
      // Taken from first [item], after expression is evaluated.
      innerValue:Thomas Hansen
    literal
      element:td
      
      // Taken from first [item], after expression is evaluated.
      innerValue:thomas@gaiasoul.com
    literal
      element:td
      
      // Taken from first [item], after expression is evaluated.
      innerValue:98765432
```

Notice, the comments will not exists after having evaluated **[apply]**, but are only there to illustrate where the items are fetched from.

If you wish to see how your **[create-widget]** invocation looks like, after it has been **[apply]**'ed, but before it is executed, you can insert a `sys42.windows.show-lambda:x:/+` invocation just before your **[create-widget]** invocation at line 158. If you do, you will see something resembling the following.

```
create-widget:contacts_table
  parent:table_wrapper
  element:table
  class:table table-striped
  widgets
    literal
      element:thead
      innerValue:<tr><th>Name</th><th>Email</th><th>Phone</th></tr>
    container
      element:tbody
      widgets
        container
          element:tr
          widgets
            literal
              element:td
              innerValue:Thomas Hansen
            literal
              element:td
              innerValue:thomas@gaiasoul.com
            literal
              element:td
              innerValue:98765432
        container
          element:tr
          widgets
            literal
              element:td
              innerValue:John Doe
            literal
              element:td
              innerValue:john@doe.com
            literal
              element:td
              innerValue:99887766
        /* ... etc, depending upon how many records you have in your file ... */
```

Above you can see, how our **[apply]** invocation, results in braiding together its **[src]** being the results of our **[load-file]** invocation with its **[template]**.

If you find the **[apply]** event to be confusing, you can watch [this video](https://www.youtube.com/watch?v=KcaRyjj2w58), where I explain it in more details. If you are reading this book in some sort of paper format, you can find this video here; https://www.youtube.com/watch?v=KcaRyjj2w58

### [lambda2hyper], converting lambda to Hyperlambda

The above **[lambda2hyper]** Active Event, which we use at line 87 in our code, simply converts a piece of lambda to a string, resembling its Hyperlambda version. There also exists a **[hyper2lambda]** event, which does the opposite. These events are useful for transforming lambda objects to strings, and vice versa - Such as when we want to save a lambda object to disc, or use it as a string for some reason. Both of these two events should be relatively self explaining.

### Our "wizard" window

At line 42, we use an Active Event we haven't used before. Its name is **[sys42.windows.wizard]**, and its purpose is simply to provide an easy wrapper for asking the user for some new input, or edit some existing data. It is similar to the **[sys42.windows.confirm]** window, and beneath its hood, uses the same logic - But instead of simply showing a static piece of text/HTML, we can ask the user to supply input, according to which nodes we supply to its **[data]** argument.

If you click the *"+"* button in your application, you can clearly see the relationship between the **[data]** node's children, and the 3 input textboxes, asking the user for a *"name"*, *"email"* and *"phone"*.

When we invoke this event, we normally would want to supply an **[.onok]** lambda callback to it, which is a piece of lambda, that is executed when the user clicks *"OK"*. Inside of our **[.onok]** lambda callback, is actually where most of the magic in our little application happens, since this is where we load our database file, and concatenate a new value into it, before we save it back to disc again.

The **[sys42.windows.wizard.get-values]** event, does exactly what you think it does. After invocation, it will look something like the following.

```
sys42.windows.wizard.get-values
  name:Thomas Hansen
  email:thomas@gaiasoul.com
  phone:98765432
```

After we have retrieved the values from our wizard window, we first check if there already exists a *"database file"*. This is necessary, in order to make sure we actually *add* records to our data. If it does, we load this file, and adds the contents of it into a temporary **[_content]** node. Notice, we do this before we add the values from our newly created record into this file, to ensure the last record supplied, physically becomes the last record in our file. This preserves the order of our records, according to the order they were supplied by the user.

Then finally, before we convert this **[_content]** node to Hyperlambda, and save it to disc, we add the values from our *"wizard"* window. At this point we use a little trick, which is that we add the entire **[sys42.windows.wizard.get-values]** node. For then to change its name, after we have added it, such that it becomes an **[item]** node. This is necessary, because we need an **[item]** node, and this node perfectly serves that purpose for us, after having been properly *"renamed"*. Technically, we wouldn't actually need to do this last step, but it makes sure our database file becomes more *"semantically correct"* in its structure. Try to remove that last **[set]** invocation, and see how this affects the structure of your *"database file"*, after having added a record into it.

The last thing we do in our **[.onok]** lambda callback, is to make sure we invoke **[sys42.examples.databind-addresses]**, which is our widget lambda event, that is responsible for databinding our HTML table all over again.

## Homework

Discuss this application, its pros and its cons. Some questions I want you to answer, are as follows.

* Is it a complete CRUD application?
* Would it be thread safe, as multiple users are accessing it?
* How could the application be improved?

### Advanced homework, optionally

If you wish, feel free to improve it, to create a complete CRUD app out of it, and expand upon it, by adding additional items to your *"database"* - Such as for instance address and Twitter handle. Hint, use **[p5.types.guid.new]** to create a unique ID for your records, which you will need, in order to be able to reference unique nodes in your database file, while editing and deleting items.

## The P5 distribution model

When you are done creating your applications, you can actually download them, and distribute them to your friends, by clicking *"Download"*, and send it in for instance an email to your friends - Whom for whatever reasons might be interested in your little app. Your friends on the other hand, can then simply *"drag and drop"* the resulting Hyperlambda file into their CMS, and reproduce the exact same application on their server systems.

This is a very nice distribution model in fact, implemented as an integral part of P5, which allows you to *"Download"* apps you've created, and have other users simply *"Drag and drop"* these apps into their own CMS.

After you have downloaded your app in fact, delete the page, for then to *"drag and drop"* your app's Hyperlambda file, into your CMS, to *"reinstall"* your app, to see this in action.

I have created a YouTube video, which you can find [here](https://www.youtube.com/watch?v=EBOYr4PGT7o), where I demonstrate this feature of System42. If you are reading this book in a paper format, you can find the video here; https://www.youtube.com/watch?v=EBOYr4PGT7o

[Chapter 8, Having a pan galactical gargle blaster](chapter-8.md)
