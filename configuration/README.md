# Configuration folder for Hyper IDE

Here you can find the global configuration settings for Hyper IDE. Among other
things, you can find the mapping from file extensions to CodeMirror modes.
In addition, you can optionally choose to create a new file in this folder,
called _"plugins.hl"_. If you do, the existence of this file will explicitly 
turn **OFF** all plugins not explicitly mentioned in that file.

To turn off all plugins, except for instance the `hyper-ide.plugins.hl.foo` plugin,
you can create a file containing the following Hyperlambda code.

```
hyper-ide.plugins.hl.foo
```

The plugins can be found in the `/modules/hyper-ide/startup/plugins/` folder.
This allows you to easily turn off all plugins you don't want any user to have access
to for some reasons.
