## Introduction to Phosphorus Five

Phosphorus Five is a Web Operating System, and a full stack Web Application Development Framework, for consuming 
and developing, rich and interactive web apps. It contains a unique programming language 
called _"Hyperlambda"_, which allows you to orchestrate your apps together, almost as if they were made out of LEGO bricks.

https://phosphorusfive.files.wordpress.com/2018/01/screenshot-desktop-2.png

### Installation

[Read about installation here](https://github.com/polterguy/phosphorusfive/releases). Basically, it allows you to install it either locally,
running its code version through e.g. Visual Studio - Or installing the binary release on for instance a Linux/Ubuntu server.
The default source installation has no dependencies besides .Net/Mono, unless you want to install additional _"apps"_ through its [Bazar](/bazar).

### Cloning Phosphorus Five

Phosphorus Five has several _"submodules"_. The most important one being [Micro](https://github.com/polterguy/micro). If you get weird 
styling issues as you clone Phosphorus Five, make your you have Micro inside of your _"/core/p5.webapp/modules/"_ folder. If you clone
Phosphorus Five _"recursively"_, it will pull in all of its submodules, including [Micro](https://github.com/polterguy/micro), 
[Hyper IDE](https://github.com/polterguy/hyper-ide), [Sephia Five](https://github.com/polterguy/sephia-five), etc. This is the easiest
way to test *everything* in Phosphorus Five during cloning, including Hyper IDE.

However, some of these modules are *dependent upon MySQL*, which means you'll have to install MySQL, in *addition to GnuPG*. If you get
the _"bluescreen of death"_ during startup, make sure you have MySQL installed on your system. The 
[default zip file installation](https://github.com/polterguy/phosphorusfive/releases) does not have these dependencies, and is probably
easier to get started with. Only the _"Bazar"_ and _"Sephia Five"_ are dependent upon GnuPG. If you don't want to install GnuPG, you can 
simply remove the Bazar, in addition to Sephia Five, after you have cloned Phosphorus Five recursively.

### Downloading apps through the Bazar

Phosphorus Five contains an integrated _"App Store"_. This allows you to install lots of apps on your server, while it is running, without
having to interrupt normal use. This is the preferred way to fill Phosphorus Five with apps, but it is *dependent upon GnuPG*. In a Linux
system, simply make sure you install gnu pg with e.g. `sudo apt-get install gnupg`. On Mac OSX, you can use for instance _"GPG Keychain"_.
You can probably find some sort of GnuPG system, also for Windows, if you look hard enough. GnuPG makes sure only cryptographically signed 
packages are installed on your system through the Bazar, and is hence an integral part of the security features of Phosphorus Five.

### Creating your own apps

Phosphorus Five is created in C#, but relies upon _"Hyperlambda"_. Hyperlambda is a modularised web application programming language, for
creating highly modularised modules and components. Hyperlambda allows you to seemlessly integrate your modules together, and _"orchestrate"_ 
building blocks - Similarly to how you would create things out of LEGO. An example of some Hyperlambda can be found below.

```hyperlambda
create-widget:foo
  element:button
  innerValue:Click me!
  onclick
    set-widget-property:foo
      innerValue:I was clicked!
```

### 3 basic innovations

Phosphorus Five consists of three basic innovations.

* Managed Ajax
* Active Events
* Hyperlambda

The Ajax library is created on top of ASP.NET's Web Forms, allowing you to use them the same way you would create a web forms website.
Simply inject them declaratively into your markup, and change their properties and attributes in your codebehind. We say _"managed"_, because
it takes care of all state, Ajax serialization, and dynamic JavaScript inclusion automatically. In fact, when you use the Ajax library, you can
arguably create your web apps, the same way you would normally create a desktop application. The Ajax library is extremely extendible, allowing 
you to create your own markup, exactly as you wish. This is because there fundamentally exists only one single Ajax widget in the library. 
This approach allows you to declare your HTML tags and attributes dynamically, and remove and change any parts of your DOM structure, without
needing to even know any JavaScript.

**Notice**, you can create web apps any way you want to, if you don't want to take the _"managed approach"_. Managed Ajax has some overhead,
and doesn't scale quite as well as a more traditional solution. If you want to, you can use Hyper IDE to create plain JavaScript based front
ends, and still take advantage of Phosphorus Five in your backend, by using _"Hyper Core"_.

Active Events allows you to loosely couple your modules together, without having any dependencies between them. Active Events is the _"heart"_ of
Phosphorus Five, allowing for the rich plugin nature in P5. You can easily create your own Active Events, either in Hyperlambda, or in C# if you wish.
You can read an MSDN article about Active Events [here](https://msdn.microsoft.com/en-us/magazine/mt795187).

Hyperlambda, and lambda, is the natural bi-product of Active Events; A Turing complete execution engine, for orchestrating your apps 
together, as shown above in the _"Hello World"_ tutorial. By combining Active Events together with Managed Ajax and Hyperlambda - Your 
apps _"comes alive"_, and creating rich web apps, becomes very easy.

### Encapsulation and polymorphism without OOP

The 3 USPs mentioned above, facilitates for a development model, which allows you to combine your existing C# skills,
creating plugins, where you can assemble your apps together, in a loosely coupled architecture. This is in stark
contrast to the traditional way of _"carving out"_ apps, using strongly and statically typed interfaces for plugins. The latter often creates a 
much higher degree of dependencies between your app's different components.

The paradox is, that due to neither using OOP nor inheritance or types, in any ways, Hyperlambda facilitates for arguably improved encapsulation, 
cohesion, and polymorphism - Without even as much as a trace of classic inheritance, OOP, or types. Hyperlambda is a _"functional programming language"_ 
on top of the CLR, making the act of orchestrating CLR modules, loosely coupled together, easily achieved.

**Notice**, Hyperlambda is *not* a CLR language, such as F# or Boo. It is built in C#, but does not compile down to CLR code. It is 100% dynamically
parsed during runtime.

### MSDN Magazine articles

I have written 3 articles about Phosphorus Five in Microsoft's MSDN Magazine. Read the articles below if you wish.

1. [Active Events: One design pattern instead of a dozen](https://msdn.microsoft.com/en-us/magazine/mt795187)
2. [Make C# more dynamic with Hyperlambda](https://msdn.microsoft.com/en-us/magazine/mt809119)
3. [Could Managed AJAX Put Your Web Apps in the Fast Lane](https://msdn.microsoft.com/en-us/magazine/mt826343)

If you wish to read these articles, you might benefit from reading them sequentially, to make sure you understand Active Events, 
before you dive into Hyperlambda.


### License information

<img src="https://phosphorusfive.files.wordpress.com/2017/12/thomas-hansen.jpg" style="float:right;margin-left:3rem;max-width:200px;border-radius:5px;box-shadow:3px 3px 5px rgba(0,0,0,.2);" alt="Thomas Hansen, the creator of Hyper IDE and Phosphorus Five" />

Phosphorus Five is Open Source, and distributed under the terms of the GPL license version 3. This (might) have some
implications for you, and your ability to (legally) create closed source applications with it. If you create 
apps that somehow use Hyperlambda, either directly or indirectly, you will have to [obtain a proprietary license](/bazar?app=license),
unless you have already obtained one. Notice for the record, Hyper Core is built on top of Phosphorus Five,
and hence if you consume it to create proprietary software (closed source), you must (and should) obtain a 
proprietary enabling license.

Regardless of whether or not you legally need a license, please realise that maintaining Hyper IDE, and its
associated components, is actually my dayjob. I am therefor 100% dependent upon people's willingness
to supply me with the monetary means to continue my work, which arguably is to help you become better at what you do.
In addition, if you purchase a license, you are also eligible to professional support, and I often find 
myself prioritising feature requests submitted by those who have a valid proprietary license, for obvious reasons.

I have also set the price for a license very low, such that it should not be a hurdle 
for most (professional) developers. Hence, I would therefor encourage you
to [get properly licensed](/bazar?app=license) if you intend to use Hyper IDE or Phosphorus Five
professionally. The purchasing of a professional license is 100% automated, and secured by PayPal, and I provide
a 30 days money back guarantee. When you have obtained a license, Hyper IDE will also stop _"bugging you"_ about 
getting properly licensed.
<br/>

Kind Regards,

Thomas Hansen - The creator of Hyper IDE, Phosphorus Five, Hyperlambda and Hyper Core

<a href="/bazar?app=license">
  <img style="display:block;margin-left:auto;margin-right:auto;" class="shaded rounded" src="https://phosphorusfive.files.wordpress.com/2017/09/license.jpg" alt="Get licensed" />
</a>
