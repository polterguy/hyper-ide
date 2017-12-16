# Hyper IDE

Hyper IDE is a web based IDE (Integrated Development Environment) that supports more than 100 programming 
languages out of the box. You can use it on localhost, through e.g. Visual Studio, Mono Develop or Xamarin -
Or install it on a web server, having easily access to your code, from anywhere in the world.

![screenshot](media/screenshots/screenshot-1.png)

## Features

* Autocomplete and suggest
* Minify JavaScript and CSS files
* Beautify CSS files
* Preview Markdown files
* Maximise code editor (fills entire browser window if you want it to, Alt+M)
* Browsing, editing, deleting and creating files and folders in your server's htmldoc folder
* Downloading files to your local computer
* Deleting, creating, editing any text file, e.g. PHP, JavaScript, CSS, Python files, etc
* More than 100 languages supported out of the box
* Multiple open files at the same time
* Intelligent indentation while editing
* Automatically closing brackets and parantheses for most languages
* Error feedback, when you have a syntax error is in your code
* Tracking of active item in _'file explorer'_
* Plugin support

## Implementation/technology

Hyper IDE is built on top of CodeMirror and Phosphorus Five, and in its entirety created in JavaScript 
and Hyperlambda. It should work in all browsers, including most mobile browsers, allowing you to code 
from your iPhone if you wish. Hyper IDE is a web based IDE, so unless you intend to run it through Visual 
Studio, or something similar, through localhost - It probably performs best through some sort of web/intranet 
server. The underlaying technology is ASP.NET/Mono and WebForms. However, being a Phosphorus Five module, 
these parts are barely visible, and completely abstracted away. The ViewState doesn't exist for one, and
the markup it renders is 100% HTML5 conforming.

Hyper IDE is extremely small in size. At the time of this writing, it is ~2000 lines of code,
although (obviously) that number will increase in the future. This is only possible due to the extreme 
modularised nature of Hyperlambda and Phosphorus Five, which it is built on top of - Facilitating for 
extreme reuse, allowing me to exclusively build it, from pre-built components, such as the TreeView 
from Micro, CodeMirror, etc. Most of the code is also comments. I suspect there is no more than 800 
lines of code in Hyper IDE in total, if you remove the comments.

However, ~2,000 lines of code in total as of today. To put that number into perspectives, realise that
the Bootstrap CSS DateTimePicker is 5,000 lines of code - It picks dates, Hyper IDE is a fully fledged 
integrated development environment, with support for more than 100 languages. The Bootstrap DateTimePicker
is also consuming more bandwidth for the record - But so does Google.com, Twitter and GMail. Hyper IDE
consumes ridiculous small amounts of bandwidth, due to its underlaying technology.

## Performance

One of my primary reasons for creating Hyper IDE, was actually due to that Visual Studio on my Mac 
computer started becoming extremely sluggish and slow. Particularly for some operations, such as editing
CSS and JavaScript files. This became increasingly annoying for me, until I figured I'd 
simply *'port Visual Studio to the web'*, and create my own alternative for editing my code, 100% 
based upon JavaScript, HTML, CSS, and the web. The performance of Hyper IDE is hence surprisingly good, 
and in fact for most operations, it performs far better than Visual Studio - At least the Xamarin/Mac 
version I tend to mostly use.

It consumes ridiculously small amounts of bandwidth, if you consider what it actually does. Opening
up Hyper IDE, and start editing a handful of code files, seldom downloads more than  ~0.5MB of data -
Of course depending upon how large your code files are. Notice though, if you have many large code 
files open at the same time, performance starts dropping, and you will experience lag in your HTTP 
requests. I suggest not having more than 5 files open at the same time. Below is a screenshot of how 
it can look with a different theme than the default theme, if you don't like my choice of colors.

![screenshot](media/screenshots/screenshot-2.png)

## Installation

If you want to use it locally, you'll need some sort of .Net/Mono runtime, e.g. Visual Studio, Mono Develop,
or Xamarin (now Visual Studio for Mac), in addition to the following.

* [Phosphorus Five](https://github.com/polterguy/phosphorusfive)
* [Micro](https://github.com/polterguy/micro)
* [Hypereval](https://github.com/polterguy/hypereval)
* MySQL (Hypereval depends upon it)
* GnuPG (the Bazar depends upon it)

The easiest way to install Hyper IDE though, is to [install Phosphorus Five](https://github.com/polterguy/phosphorusfive/releases),
for then to afterwards simply visit _"The Bazar"_ and install it through the Bazar. If you want a more 
manual process, you'll need to unzip Hyper IDE's download into your _"modules"_ folder, which you can 
find inside of your main Phosphorus Five download folder's _"core/p5.webapp"_ folder. Hyper IDE is
a Phosphorus Five module, and will not work without Phosphorus Five.

## Roadmap

* Ability to execute shell scripts on server, to integrate things such as GIT integration through shell scripts, compilation, etc.
* Uploading of files
* Backup of folders (downloading as ZIP files)
* Uploading of files (both binary and text-based files)
* Template support (choosing from a pre-defined set of templates when creating new files, according to file type)
* Even better plugin support, even though today's plugin support is actually fairly good

However, in general, it is already a highly feature rich IDE, supporting most of the tasks you'd probably 
want your IDE to accomplish, paradoxically much faster and more responsive, than most other IDEs out there -
At least the ones I have seen.

## Usage

Although Hyper IDE can be used for any of the programming languages it supports, I suspect it will be
most useful for things such as HTML, JavaScript, CSS, Python, Ruby, PHP and Hyperlambda - Languages which
somehow creates websites, without compilation occurring. However, as Visual Studio becomes increasingly
sluggish, I have now almost completely replaced Visual Studio myself with Hyper IDE, for anything besides 
things such as C# component development, where Visual Studio still is superior, due to superior 
autocompletion on managed code, and features such as refactoring, etc.

### Dogfooding

Hyper IDE was in fact for the most parts built with Hyper IDE. For instance, below you can see a 
screenshot of me editing this file, at the exact point in time I wrote this text. The goal of the project,
is to make it so versatile, that I will stop using anything else myself, for my own needs, except maybe
C# development.

![screenshot](media/screenshots/screenshot-3.png)

## Keyboard shortcuts

Hyper IDE features tons of keyboard shortcuts. The most useful ones are as follows.

* Alt+S - Saves active file
* Alt+X - Close active editor
* Alt+N - Open next code window
* Alt+P - Open previous code window
* Cmd+F, Ctrl+F - Find (supports regular expressions)
* Alt+F - Find (persistent)
* Cmd+Alt+F, Ctrl+Alt+F - Replace (supports _'replace all'_ and regex)
* Alt+M - Maximise code editor
* Alt+G - Go to line
* Tab - Indent selected code one additional tab level
* Shift+Tab - De-indent selected code one tab level
* Ctrl+Space - Shows autocompletion window (only for languages that supports this, such as HTML, JavaScript, XML, CSS etc)

Hint, to open a file for editing, simply _'double click'_ the file in the _'solution explorer'_ (your file browser, the tree view).

## License options

Hyper IDE is a part of the GaiaSoul suite, and hence licensed as GPL version 3, but a proprietary license,
with professional support can be obtained. Check out [my website for details](https://gaiasoul.com/license).

## Language support, complete list

Hyper IDE has autocomplete for all languages, including HTML, XML, JavaScript, Hyperlambda, and more.
However, besides languages such as HTML, XML, JavaScript, Hyperlambda and CSS, autocompletion is implemented
using the _'anyword-hint'_ addon from CodeMirror, and hence is not as strong as autocompletion you might
be used to from other IDEs. It also features syntax highlightning for more than 100 different languages. 
It comes with 57 different themes out of the box, but you can easily apply your own favourite colors and 
skin for it, by editing a single CSS file, with some 25-35 different selectors. Hyper IDE supports the 
following programming languages, markup languages, and syntaxes, and will automatically load up the correct
editor type when opening files for editing, according to file extensions.

* APL
* ASN.1
* Asterix dialplan
* Brainfuck
* C, C++, C#
* Ceylon
* Clojure
* Closure Stylesheets (GSS)
* CMake
* COBOL
* CoffeeScript
* Common Lisp
* Crystal
* CSS
* Cypher
* Cytho
* D
* Dart
* Django
* Dockerfile
* diff
* DTD
* Dylan
* EBNF
* ECL
* Eiffel
* Elixir
* Elm
* Erlang
* Factor
* FCL
* Forth
* Fortran
* F#
* Gas (AT&T style assembly)
* Gherkin
* Go
* Groovy
* HAML
* Handlebars
* Haskell (Literate)
* Haxe
* HTML embedded (JSP, ASP.NET)
* HTML moxed-mode
* HTTP (requests and response)
* IDL
* Java
* JavaScript
* Jinja2
* Julia
* Kotlin
* LESS
* LiveScript
* Lua
* Markdown
* Mathematica
* mbox
* mIRC
* Modelica
* MscGen
* MUMPS
* Nginx
* NSIS
* N-Triples/N-Quads
* Objective C
* OCaml
* Octave
* Oz
* Pascal
* PEG.js
* Perl
* PGP (ASCII armor)
* PHP
* Pig Latin
* PowerShell
* Properties files
* ProtoBuf
* Pug
* Puppet
* Python
* Q
* R
* RPM
* reStructuredText
* Ruby
* Rust
* SAS
* Sass
* Spreadsheet (formula definition)
* Scala
* Scheme
* SCSS
* Shell
* Sieve
* Slim
* Smalltalk
* Smarty
* Solr
* Soy
* Stylus
* SQL (several different dialects)
* SPARQL
* Squirrel
* Swift
* sTeX, LaTeX
* Tcl
* Textile
* Tiddlywiki
* Wiki wiki
* TOML
* Tornado
* troff
* TTCN
* TTCN Configuration
* Turtle
* Twig
* VB.NET
* VBScript
* Verilog/SystemVerilog
* VHDL
* Vue.js
* Web IDL
* XML
* HTML
* XQuery
* Yacas
* Yaml
* Yaml (frontmatter)
* Z80
* Hyperlambda (of course)
