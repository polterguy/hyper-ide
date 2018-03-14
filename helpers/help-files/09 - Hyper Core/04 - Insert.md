## Inserting items

The `insert` operation is arguably simpler than the `select` operation, since it doesn't require as many arguments. It requires
you to use a `PUT` HTTP request, and expects each column to be declared as a key/value pair in your body's request.
An insert operation can only insert one item for each request. Yet again, check out the `x` documentation, for how
to create your own server side methods.

Assuming you're in JavaScript land, you could insert a column into your database with the following code.

```javascript
var xhr = new XMLHttpRequest();
xhr.open('PUT', '/hyper-core/mysql/todo/items/insert', true);
xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
xhr.onreadystatechange = function() {
  if (xhr.readyState === 4) {
    eval("window.res = " + xhr.responseText);
    alert('Item was successfully inserted with the id of; ' + window.res.id);
  }
};
var description = 'Walk the dog';

/*
 * Notice, assumes you have a "todo" database, with an "items" table, having a "description" column.
 * If you have followed our AngularJS tutorial, you will have already created this schema.
 */
xhr.send(body = 'description=' + encodeURIComponent (description));
```

The `insert` operation will return the id of your inserted item as `id`. Notice also that both the `insert` method,
and the `update` method, requires you to create your requests as a URL encoded form request. This is done by
making sure you set the `Content-Type` HTTP header to `application/x-www-form-urlencoded`.

Yet again, I want to emphasize that the URLs for all server side methods, are _"intelligently created"_, according
to the following rules.

```markdown
/hyper-core/mysql/[database]/[table]/[method]
```
