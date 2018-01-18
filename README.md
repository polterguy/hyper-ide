# Hyper IDE

Hyper IDE is a web based IDE (Integrated Development Environment) that supports more than 100 programming 
languages out of the box. You can use it on localhost, through e.g. Visual Studio, Mono Develop or Xamarin -
Or install it on a web server, having easily access to your code, from anywhere in the world.

![screenshot](screenshots/hyper-ide-micro-screenshot.png)

## Features

* Autocomplete (uses any-word for languages besides XML, HTML, JavaScript, Hyperlambda, CSS)
* Minify JavaScript and CSS files
* Beautify CSS files
* Preview Markdown files
* Shell integration for things such as Git and other tasks
* Maximise code editor (fills entire browser window if you want it to, Alt+M)
* Browsing, editing, deleting and creating files and folders
* Downloading files to your local computer
* Uploading (multiple) files to your server
* More than 100 languages supported out of the box
* Multiple open files at the same time
* Intelligent indentation while editing
* Automatically closing brackets and parantheses for most languages
* Error feedback, when you have a syntax error is in your code
* Tracking of active item in _'solution explorer'_
* Plugin support
* Tons of intelligent keyboard shortcuts

## Implementation/technology

Hyper IDE is built on top of CodeMirror and Phosphorus Five, and in its entirety created in JavaScript 
and Hyperlambda. It should work in all browsers, including most mobile browsers, allowing you to code 
from your iPhone if you wish. Hyper IDE is a web based IDE, so unless you intend to run it through Visual 
Studio, or something similar, through localhost - It probably performs best through some sort of web/intranet 
server. The underlaying technology is C#/ASP.NET/Mono and WebForms. However, being a Phosphorus Five module, 
these parts are barely visible, and completely abstracted away. The ViewState doesn't exist for one, and
the markup it renders is 100% HTML5 conforming.

## Performance

One of my primary reasons for creating Hyper IDE, was actually due to that Visual Studio on my Mac 
computer started becoming extremely sluggish and slow. Particularly for some operations, such as editing
CSS and JavaScript files. This became increasingly annoying for me, until I figured I'd 
simply *'port Visual Studio to the web'*, and create my own alternative for editing my code, 100% 
based upon JavaScript, HTML, CSS, and the web. The performance of Hyper IDE is hence surprisingly good, 
and in fact for most operations, it performs far better than Visual Studio - At least the Xamarin/Mac 
version I tend to mostly use.

It consumes tiny amounts of bandwidth, if you consider what it actually does. Opening
up Hyper IDE, and start editing a handful of code files, seldom downloads more than  ~0.5MB of data -
Of course depending upon how large your code files are. Below is a screenshot of how 
it looks like with multiple open tabs, and AutoCompletion suggest open (use CTRL+Space to display AutoCompletion).

![screenshot](media/screenshots/screenshot-secondary.png)

## Installation (Source)

If you want to use it locally, you'll need some sort of .Net/Mono runtime, e.g. Visual Studio, Mono Develop,
or Xamarin (now Visual Studio for Mac), in addition to downloading 
the [main Phosphorus Five source version](https://github.com/polterguy/phosphorusfive/releases).

## Installation (Binaries on Linux)

[Read more here](https://github.com/polterguy/phosphorusfive/releases), but basically there's a shell script that
automates the entire process of installing both Mono, Apache mod_mono, Phosphorus Five, and Hyper IDE
on a Linux/Apache server.

## License options

Hyper IDE is a part of the GaiaSoul suite, and hence licensed as GPL version 3, but a proprietary license,
with professional support can be obtained. Check out [our website for details](https://gaiasoul.com/license).
