## A MySQL HTTP REST based ORM library (and more)

Hyper Core is an HTTP REST based ORM library for MySQL and evaluating server side Hyperlambda, as a consequence
of invoking some HTTP request. Hyper Core is mostly for developers who already knows how to create and maintain
HTML, CSS and JavaScript based applications - And probably an easier way to create apps, unless this applies
to you, is to use Hyperlambda directly, by creating widgets and hierarchies of such, instead of using Hyper Core.

**Important** - Some parts of this documentation, requires you to having followed our _"AngularJS tutorial"_, since
it relies upon the same database schema as that tutorial happens to create. Hence, it might be beneficial for 
you to first go through that tutorial at the root of the documentation system, before you continue reading this.
If you haven't already, you might see how to do that, by watching this video.

https://www.youtube.com/watch?v=Zr5f7oweed8

Hyper Core is a MySQL ORM library, built as a generic HTTP REST web service.
This allows you to build your front end towards a mature, reusable, and secure back end, 
that automatically takes care of common security issues, such as preventing SQL injection attacks, and
easily allows you to control authorisation and authentication.

Hyper Core is a a Phosphorus Five module, and hence requires
you to use Phosphorus Five as your core on the server, but does not impose any requirements towards your front
at all. Hyper Core can just as well be consumed by thick clients, as it can be consumed by JavaScript based
front ends - As long as the front end can handle JSON, and create HTTP REST invocations.

**Notice**, Hyper Core can also be used towards other databases, such as MongoDB or MS SQL. However,
if you choose this route, you'll have to use the `x` methods, since there are no existing
wrappers around other databases than MySQL at the moment.
