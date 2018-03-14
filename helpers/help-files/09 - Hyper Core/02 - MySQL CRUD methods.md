## MySQL CRUD operations

There are 4 basic CRUD operations you can perform on your MySQL database(s). These are as 
follows.

* __[select]__ - Selects data from your MySQL database. Requires `GET` method.
* __[update]__ - Updates data in your database. Requires `POST` method.
* __[delete]__ - Deletes data from your database. Requires `DELETE` method.
* __[insert]__ - Inserts data into your database. Requires `PUT` method.

In addition to the standard methods above, there is also an `x` method, which allows
you to securely create any type of SQL you wish, or create your own wrappers around alternative
database implementations for that matter. `x` also allows you to create any type of server-side
business logic objects you want to create, completely decoupled from any types of databases too.
Check out the documentation for the `x` method later in this documentation for details about `x`.

Each of the above HTTP REST MySQL services follows the following URL format.

```markdown
/hyper-core/mysql/[database]/[table]/[operation]
```

If you have a database called e.g. `todo`, with a table called `items`, and you want to
perform a `select` query towards it for instance, you can use the following URL.

```markdown
/hyper-core/mysql/todo/items/select
```

In fact, if you have followed our AngularJS tutorial, you can immediately [visit the above link](/hyper-core/mysql/todo/items/select),
to see the results of such an HTTP GET request.
