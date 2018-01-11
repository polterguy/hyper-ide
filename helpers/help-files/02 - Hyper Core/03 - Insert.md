## Inserting items

The `insert` operation is arguably simpler than the `select` operation, since it doesn't require as many arguments. It requires
you to use a `PUT` HTTP request, and expects each column to be declared as a value/key pair in your body's request.
For instance, assuming you're in JavaScript land for instance, you could insert a column into your database with
the following code.

```javascript
var xhr = new XMLHttpRequest();
xhr.open('PUT', '/hyper-core/mysql/database/table/insert', true);
xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
xhr.onreadystatechange = function() {
  if (xhr.readyState === 4) {
    eval("window.res = " + xhr.responseText);
    alert('Item was successfully inserted with the id of; ' + window.res.id);
  }
};
var name = 'John Doe';
var email = 'john@doe.com';

// Notice, assumes you have a name and email column, in your table table, in your database database.
xhr.send(body = 'name=' + encodeURIComponent (name) + '&email=' + encodeURIComponent (email);
```

The `insert` operation will return the id of your inserted item as `id`. Notice also that both the `insert` method,
and the `update` method, requires you to create your requests as a URL encoded form request. This is done by
making sure you set the `Content-Type` HTTP header to `application/x-www-form-urlencoded`.
