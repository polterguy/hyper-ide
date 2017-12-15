# Hyper IDE

Hyper IDE is a web based IDE (Integrated Development Environment) that supports more than 100 programming 
languages out of the box. It does not feature any project files or structure, and does not plan on ever 
getting one, but rather allows you to browse all your files, on your web server, and edit these as you 
see fit, and hence works with any projects types, as long as your project files are text files.

![screenshot](media/screenshots/screenshot-1.png)

Hyper IDE has autocomplete for many languages, including HTML, XML, JavaScript, Hyperlambda, and more.
It also features syntax highlightning for more than 100 different languages. It comes with 57 different 
themes out of the box, but you can easily apply your own favourite colors and skin for it, by editing 
a single CSS file, with some 25-35 different selectors. Hyper IDE supports the following programming 
languages, markup languages, and syntaxes, though only a handful of these have autocompletion at the time.

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

## Implementation/technology

Hyper IDE is built on top of CodeMirror and Phosphorus Five, and in its entirety created in Hyperlambda.
It should work in all browsers, including most mobile browsers, allowing you to code from your iPhone
if you wish. Hyper IDE is a web based IDE, so unless you intend to run it through Visual Studio, or 
something similar, through localhost, it probably performs best through some sort of web/intranet server.

## Performance

One of my primary reasons for creating Hyper IDE, was actually due to that Visual Studio on my Mac 
computer started becoming extremely sluggish and slow. Particularly for some operations, such as editing
CSS and JavaScript files. This became increasingly annoying for me, until I figured I'd 
simply *"port Visual Studio to the web"*, and create my own alternative for editing my code files, 100% 
based upon JavaScript, HTML, CSS and the web. The performance of Hyper IDE is hence surprisingly good, 
and in fact for most operations, it performs far better than Visual Studio - At least the Xamarin/Mac 
version I tend to mostly use.

It consumes ridiculously small amounts of bandwidth, if you consider what it actually does. Opening
up Hyper IDE, and start editing a handful of code files, seldom downloads more than  ~0.5MB of data
from my server. Of course depending upon how large your code files are. Notice though, if you have many
large code files open at the same time, performance starts dropping, and you will experience lag in your
HTTP requests. I suggest not having more than 5 files open at the same time.





