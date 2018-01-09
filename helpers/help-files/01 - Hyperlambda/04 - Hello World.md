# Hello World

Assuming you have already downloaded [P5](https://github.com/polterguy/phosphorusfive) and [System42](https://github.com/polterguy/system42), and managed to get it up and running, we are going to create our first Hyperlambda application called *"Hello World"*. By walking through this application, and explaining what it does, you will be armed with the knowledge required to create your own Ajax web apps.

Open up System 42's Apps/CMS editor, by choosing it in your menu/navbar at the top of your page. Click the _“+”_ button, and choose to create a new _“lambda”_ page. Then remove the existing code, and paste in the Hyperlambda code below into your editor. When you have done this, make sure you click _“Save”_, and _“View page”_.

The Hyperlambda for our Hello World application.

```
create-widget:foo
  parent:content
  element:button
  class:btn btn-default
  innerValue:Click me
  onclick
    set-widget-property:foo
      innerValue:Hello World
```

Your page should look something like this.

![alt screenshot of hello world](screenshots/chapter-1-1.png)

If you try to click the button created by the Hyperlambda above, it will change its value to *"Hello World"*. If you wish, you can refresh your page, to reset the button's text, for then to click it again.

**Notice**; We will be using [System42](https://github.com/polterguy/system42) in this book, in combination with (of course) [Phosphorus Five](https://github.com/polterguy/phosphorusfive) for most of our examples in this book. This is not recommended for creating a production application, but is a nice starting ground for learning Hyperlambda. To install System42, make sure you first [download Phosphorus Five](https://github.com/polterguy/phosphorusfive/releases)'s zip file, for then to download [System42](https://github.com/polterguy/system42/releases). Then extract both of these, and put your System42 unzipped folder into your P5 folder, inside of _"/core/p5.webapp/modules/"_. When you have done so, make sure you rename System42's folder to remove any versioning numbers, such that it is only named _"system42"_. Then open the P5.sln file in e.g. Visual Studio or MonoDevelop.

## The Hyperlambda structure

Hyperlambda is a name/value/children file format. It allows you to declare *"graph objects"*, or *"tree structures"* - And is semantically quite similar to JSON. In Hyperlambda, we refer to such tree structures declared by Hyperlambda as *"lambda objects"*.

Think of it like the relationship between JSON (Hyperlambda), and the JavaScript objects after your JSON has been evaluated (lambda). If you still think this is difficult to understand, you can watch [this video](https://www.youtube.com/watch?v=oML2JE8kAO0), describing the relationship between Hyperlambda and lambda.

### Analyzing our code

Above, in our `create-widget:foo` parts, which is our first line of code, we first declare a *"lambda node"*. The node has a name, being **[create-widget]**, and a value being *"foo"*. This creates a *"widget"* for us, which is an interactive HTML element. Which type of widget this will create, depends upon which arguments we supply to it. The widget will have an ID attribute of *"foo"*, which can later be used to reference the widget, and change or retrieve its properties and attributes.

Our **[create-widget]** invocation above has 5 children nodes;

- **[parent]** - Parent widget to append our widget into
- **[element]** - HTML tag to render widget with
- **[class]** - CSS class to use for widget
- **[innerValue]** - Inner HTML or text of widget
- **[onclick]** - A lambda callback invoked when widget is clicked

To declare a child of another node in Hyperlambda is very easy, all you have to do, is to indent your node with two spaces, relative to the indentation of the node you wish to declare these children inside of. This makes sure that your node becomes a child of the node above it, or an *"argument"* if you wish.

The **[parent]** argument, declares which parent HTML widget you wish to append your widget into. The **[element]** argument, declares the HTML tag you wish to use for your HTML element. The **[class]** argument, becomes the CSS class attribute of your widget. **[innerValue]** becomes your widget's initial innerHTML value. And **[onclick]** becomes a server-side lambda object, evaluated when your widget is clicked.

You can use any **[parent]** you wish for your widget, which allows you to inject your widget, into any pre-existing widget's collection. The *"content"* **[parent]** we are using above, happens to be a generic **[container]** widget, from the main default template of System42's CMS.

The *"btn btn-default"* value of our **[class]** argument, refers to CSS classes from [Bootstrap CSS](http://getbootstrap.com/css/), which is a commonly used Open Source CSS framework. Bootstrap CSS is the default CSS framework in System42, but can easily be replaced if you wish. In a production site, I recommend you to rather use [Micro](https://github.com/polterguy/micro) instead of Bootstrap, since it's literally orders of magnitudes smaller in size.

To understand the above code, it might be useful to see its resulting HTML. Below is the HTML our Hyperlambda creates.

```xml
<button id="foo" class="btn btn-default" onclick="p5.e(event)">Click me!</button>
```

Notice how our widget is of type *"button"*. This is because of the argument **[element]**, which declares what type of HTML widget you wish to create. You can create any HTML element you wish, by changing the **[element]** argument's value to the *"tagName"* of the HTML element you wish to create.

You can also add any attributes you wish to your widget, by simply adding the attribute as an argument. To add an attribute with the name of *"foo"* and the value of *"bar"* for instance, is as easy as adding `foo:bar` as an argument to our **[create-widget]** invocation.

## Ajax events

In our example above, we have an **[onclick]** Ajax event for our button. This will create an *"onclick"* DOM event handler for us, which when raised, will create an Ajax request, going towards our server, invoking its lambda object.

Lambda objects, such as the one we have declared inside our **[onclick]** event handler, is often referred to as simply *"lambda"*. Lambda objects are stored function objects, which are executed, whenever some condition is being met - Or we wish to for some reasons execute our lambda. The simplicity in declaring such *"lambda objects"*, is the reason why Hyperlambda got its name.

The *"lambda"* above, simply invokes the **[set-widget-property]** Active Event, with the ID of *"foo"*, and an **[innerValue]** argument of *"Hello World"*. This changes the **[innerValue]** property of our *"foo"* widget, to whatever HTML we pass in as the value of our **[innerValue]** argument. The **[set-widget-property]** is an alias to **[p5.web.widgets.property.set]**, which you will see other places in our P5 examples. Many Active Events have aliases, which are alternative names, for invoking the same Active Event. Which one you prefer to use, is often a matter of personal taste.

## Additional studying, video tutorial

If you still struggle with some of the parts we walked through in this chapter, you might benefit from watching [this video](https://www.youtube.com/watch?v=O9ek7JH7Ptw), where we play around with the **[create-widget]** Active Event. In this video we demonstrate how to parametrize our **[create-widget]** invocation, to create whatever HTML we want to create. In addition, we will associate Ajax events with our widget, and do some basic changes to the state of our page, from within our Ajax event handlers. These Ajax events, creates an Ajax request, going to our server, where it evaluates our lambda object associated with our Ajax event.

In case you are reading this book in paper format, you can find links to the videos referred to in this chapter below.

* Hyperlambda 101 - https://www.youtube.com/watch?v=oML2JE8kAO0
* Ajax Widgets 101 - https://www.youtube.com/watch?v=O9ek7JH7Ptw

[Chapter 3, Ajax Widgets dissected](chapter-3.md)