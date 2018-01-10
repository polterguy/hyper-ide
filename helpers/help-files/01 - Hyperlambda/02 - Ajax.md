## Chapter 1, Ajax

Ajax is a technology for incrementally applying changes to an HTML page. It is an acronym, although still commonly referred to, 
and written like the header of this chapter writes it. It means _“Asynchronous JavaScript and XML”_, and its name is actually 
highly misleading, since it rarely have anything to do with XML.

Ajax allows us to change parts of the view in our web pages, by fetching data from a server, and using this data to modify parts 
of what the user is seeing on his page. It is often referred to as GUI in its broader sense, meaning Graphical User Interface, 
and is what allows us to create rich web applications, where your web pages becomes interactive and _"alive"_.

Ajax is built around a simple idea, which is the ability to use what's often referred to as the *"XHR object"*, or 
the *"XML HTTP Request object"*. The XHR object allows you to asynchronously retrieve data from a server. This combined with the 
ability to dynamically modify the DOM, or *"Document Object Model"*, allows for the experience of *"interactive web pages"*. 
DOM is what your HTML is creating when it is being evaluated by your browser.

### Managed Ajax internals

Phosphorus Five contains a _managed_ Ajax library, which can be found in the project called *“/core/p5.ajax/”*. This Ajax library 
is built upon WebForms from ASP.NET, but Phosphorus Five has little in common with traditional WebForms applications.

Managed Ajax simply implies that the use of JavaScript for the most parts are *optional*. With p5.ajax, you do not need to use 
JavaScript at all to create rich interactive Ajax web pages. You *can* use JavaScript if you wish, and using JavaScript is in 
fact surprisingly easy in combination with P5. However, if you do not wish to use JavaScript, you can still create stunningly 
rich interactive web apps. There are almost no places in P5, out of the box, that contains any explicitly written JavaScript parts. 
Hence, we refer to the technology used in P5 as _“managed Ajax”_.

The idea with managed Ajax, is to abstract JavaScript and the client away, to create a better code-model, for creating server-side 
code, that automatically creates the associated client-side/server-side mapping for you, without you having to think much about it.

The Ajax library in P5 uses JSON internally to return data from the server. JSON is another acronym, and means _“JavaScript Object Notation”_. 
JSON is a technology for creating JavaScript objects, which are easily transferred from your server to its clients. The reason why 
Ajax almost never has anything to do with XML, is because JSON has almost entirely replaced XML in most Ajax libraries. A more 
correct word for Ajax, would therefor in fact be _“Ajaj”_, suggesting _“Asynchronous JavaScript and JSON”_.

In P5, these parts are perfectly abstracted away for you, and there are rarely, if ever, any need to understand what goes on 
beneath the hoods of the Ajax engine. Nor is it necessary in any ways, to modify, or interact with these parts of P5. You *can* 
easily interact with these parts of P5 though, and extend these parts if you wish - But, you will rarely need to do such a thing.

The above makes P5 a perfect beginner's Ajax framework (Ajaj?), significantly simplifying the process of creating rich Ajax 
applications. While also, due to its extensibility, and ability to allow the developer to tap into its core - Also a perfect 
framework for the seasoned architect and software developer. Arguably, P5's design is all about *"bridging"* the complex and 
the simple - Which you will discover as you proceed.

Managed Ajax also implies that it becomes much harder to create security holes, since all the code that is executed, is 
executed on the server - And the HTML and JavaScript parts, are automatically created for you on the client side. In addition, 
a code model where you only have to think about one concept, makes your code much more easily maintained - Contrary to a pure 
JavaScript solution, where you often have to change multiple places, if you want to change even a small piece of logic in your own app.

### Ajax technology choices in P5

The Ajax engine internally in P5, actually uses what’s referred to as *"ViewState"* in ASP.NET. P5 however, uses the ViewState 
in a very intelligent manner, exclusively keeping it on the server among other things. This completely eliminates all traditional 
ViewState problems, which you can see, if you do a quick Google search for *“ASP.NET ViewState”*. This means that a P5 Ajax request, 
is often several orders of magnitudes smaller in size, than an Ajax request created in for instance ASP.NET AJAX. This makes 
P5 a perfect framework for creating highly rich Ajax applications, for devices that does not have a high bandwidth internet 
connection. Examples includes web apps intended to run on smart phones for instance.

The concern though, is that this must mirror everything from the client on the server. The server is hence keeping the entire 
_“state”_ of your web page, such that it can keep track of which changes are applied to your page during an Ajax request/response. 
Another concern, is that this also means that the entire HTTP FORM must be submitted upon every single Ajax request. These two 
caveats, have few if any practical side effects for you 99% of the time. However, this is what facilitates for P5's architecture 
and development model, for incrementally updating your web pages the way it does.

The above technology, allows you to modify any *"widget"* on your page, from any event raised by any other *"widget"*. This 
facilitates for a significantly less complex development model for applying changes to your page. Which is why knowledge about 
JavaScript becomes *optional* when you use P5.

When creating a P5 web app, you will in fact feel as if you are developing a Desktop Windows app, due to the above mentioned 
features. In fact, creating a highly rich Ajax app in P5, is probably _even easier_ than creating something similar in WinForms, 
Xamarin forms, Qt, etc.

### Bandwidth usage

Due to the above mentioned technologies, the amount of bandwidth consumed by P5, is often _extremely small_. P5 will often 
use orders of magnitude less bandwidth than its competing technologies. This is true both for its initial page loading, 
and its subsequent Ajax requests. The main JavaScript portions of P5, is no more than roughly 5KB in size. The average Ajax 
request, is rarely more than 1KB.

Other competing technologies, often requires hundreds, and sometimes even thousands of kilobytes of JavaScript, to do what 
P5 allows you to do with 5 kilobytes. The difference in performance between P5 and some of its competing technologies, is 
often several orders of magnitudes. Most parts of P5 have been profiled against some of the major player's technologies in 
this area, and almost every time we do this, the competing technologies will end up consuming hundreds of times more bandwidth,
than what P5 consumes to solve the same problem.

In fact, I am running [my own webserver out of my home](https://home.gaiasoul.com), over a plain home 5Mb internet connection - Yet 
still, I can easily check my email, upload and download my own files securely, without any problems in regards to responsiveness. 
Sephia Five for instance, is using 1/25th of the bandwidth that its competitor GMail is using. In addition, I have installed Hyper
IDE on that server, with hundreds, and sometimes even thousands of guests visiting my server, every single day. Below is a graph
showing the difference in bandwidth consumption between GMail and Sephia Five.

https://github.com/polterguy/sephia-five/raw/master/media/bandwidth-comparison.png

### Server side performance and security

In a stateless web app, often your database must be more frequently queried, or some other expensive resource must be polled 
upon every single postback to your server. Although Hyperlambda is an extremely *"high level programming language"*, it often 
performs surprisingly well, compared to other technologies. In addition, without state, a whole range 
of security issues becomes much more prevalent, broadening the *"attack surface"* of your server. P5 is *secure by default*, 
and you'll actually have to consciously do something wrong, to create security holes. In addition, the risk of leaking business 
logic to the client, simply does not exist in P5.

An example can be illustrated by editing some item from a database. Completely stateless, a web app must store this value, 
associated with the client somehow. This can be done through a cookie, an invisible input HTML element, or some other value 
transferred to the client - Which the server expects the client to return, when it is done editing the record. Nothing prevents 
a malicious client from changing this ID, making the server side code, edit a completely different item. In P5, you would by 
default store this ID on the server, making it impossible to modify for a malicious client.

Security issues like the examples above, *can* be fixed in a more stateless model of developing web apps. In P5 however, 
they're completely non-existent, significantly reducing the complexity of creating rock hard secure web apps, without 
introducing complex architecture, or pages up and down of *"remember to do this"* lists, to check before you deploy your 
app into production.

Several books, arguably multiple libraries of security literature, with *"security concerns"* - Are simply _not relevant what so ever with P5_.
