## A MySQL HTTP REST based ORM library (and more)

Hyper Core is a MySQL ORM library, built as a generic HTTP REST web service.
This allows you to build your front end, towards a mature, reusable, and secure back end, 
that automatically takes care of common security issues, such as SQL injection attacks, and
authorisation and authentication. Hyper Core is a 
a [Phosphorus Five](https://github.com/polterguy/phosphorusfive) module, and hence requires
you to use Phosphorus Five as your core on the server, but does not impose any requirements towards your front
at all, and can just as well be consumed by thick clients, in addition to JavaScript based
front ends - As long as the front end can handle JSON and create HTTP REST invocations.

## MySQL CRUD operations

There are 4 basic CRUD operations you can perform on your MySQL database(s). These are as 
follows.

* __[select]__ - Selects data from your MySQL database. Requires `GET` method.
* __[update]__ - Updates data in your database. Requires `POST` method.
* __[delete]__ - Deletes data from your database. Requires `DELETE` method.
* __[insert]__ - Inserts data into your database. Requires `PUT` method.

In addition to the standard methods above, there is also an `x` method, which allows
you to securely create any type of SQL you wish. Check out the documentation for the `x` method
further down in this document. Each of the above HTTP REST services follows the following URL format.

```http
/hyper-core/mysql/[database]/[table]/[operation]
```

If you have a database called e.g. `todo`, with a table called `items`, and you want to
perform a `select` query towards it for instance, you can use the following URL.

```http
/hyper-core/mysql/todo/items/select
```

Below is a video that demonstrates how our AngularJS tutorial is consuming Hyper Core.

https://www.youtube.com/watch?v=Zr5f7oweed8
