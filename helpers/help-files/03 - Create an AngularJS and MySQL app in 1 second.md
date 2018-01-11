## Create an AngularJS and MySQL app in 1 second

**Notice**, this tutorial requires that you have MySQL installed on your server/machine.
Select your `/modules/` folder. Then click the `+` button in your toolbar, assuming you 
have enabled the plugin that allows you to create a new module. Then name your app _"todo"_, 
and select the `angular-todo` type. At which point your screen should resemble the following.

https://phosphorusfive.files.wordpress.com/2018/01/angular-todo-screenshot.png

Then simply click the _"Create"_ button, and you're in fact done. If you want to try out your app,
you can [click this link](/todo). The above process will create a new module for you, having the following files.

* _"index.html"_ - Your Angular HTML file
* _"controller.js"_ - Your Angular controller
* _"styles.css"_ - Some default styling
* _"desktop.hl"_ - A desktop icon for Phosphorus Five
* _"launch.hl"_ - Your app's launcher file
* _"startup.hl"_ - Your app's startup file
* _"install.hl"_ - Evaluated when your app is installed, through for instance the _"Bazar"_
* _"uninstall.hl"_ - Evaluated when your app is uninstalled

In the video below, I walk you through the main features of the app you just created, explaining the 
different parts of your app. Unless you're already an AngularJS guru, you will probably benefit from 
watching it. And even for an AngularJS guru, there are a couple of points you would want to understand
which are a part of Phosphorus Five, and not Angular features. The app is using Hyper Core on the server
side, to persist your changes into your MySQL database. We will dive into Hyper Core in later
chapters.

https://www.youtube.com/watch?v=Zr5f7oweed8
