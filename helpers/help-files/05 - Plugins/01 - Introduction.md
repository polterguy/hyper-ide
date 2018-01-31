
## Introduction

There are literally hundreds of _"plugins"_ in Phosphorus Five that you can use in your own projects. These are created as Active Events,
and categorised into roughly 30 different loosely coupled _"plugin"_ assemblies - And you can easily create your own plugins, using for instance
C# or F#.

These plugins ranges from all sorts of tasks, such as handling your file system, to sending and receiving PGP encrypted emails. In fact, the entirety
of Phosphorus Five is created as such plugins, including tasks such as parsing Hyperlambda, to the _"keywords"_ in the language itself. This creates
an extremely loosely coupled interface between the different components that creates Phosphorus Five, allowing you to loosely couple your different
components together, almost like an orchestrator orchestrates his symphonic orchestra.

Below is a list of each plugin assembly, and what it does.

* p5.data - A memory based database
* p5.events - Allows for dynamically creating Active Events
* p5.hyperlambda - Contains the Hyperlambda parser
* p5.io - Contains all disc IO Active Events
* p5.lambda - The core _"keywords"_ in Phosphorus Five, such as __[for-each]__, __[if]__, etc
* p5.math - Basic math operators
* p5.strings - String manipulation
* p5.types - Supported types for Phosphorus Five
* p5.web - Everything related to web, such as creating Ajax widgets, and storing things into the session object, etc
* p5.auth - Authorization and authentication features of Phosphorus Five
* p5.crypto - Cryptography helper Active Events
* p5.csv - CSV file parsing
* p5.flickrnet - Wrapper around the Flickr API
* p5.html - HTML parsing, and other HTML helper Active Events
* p5.http - HTTP wrappers, for creating HTTP requests
* p5.imaging - Image manipulation Active Events
* p5.io.authorization - Authorization plugin, used by p5.io among other things
* p5.io.zip - Allows for creating and parsing zip files
* p5.json - JSON support
* p5.mail - SMTP and POP3 wrapper events
* p5.markdown - Markdown support
* p5.mime - MIME support, for creating and parsing MIME messages. Also contains PGP cryptography features
* p5.mysql - MySQL support, for querying MySQL databases
* p5.pdf - Allows you to create PDF files
* p5.threading - Allows you to spawn and handle threads
* p5.xml - XML support

