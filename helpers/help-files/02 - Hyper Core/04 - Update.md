## Updating items

The `update` operation requires you to use a `POST` HTTP request. It requires one query parameter declaring
which item you'de like to update, and all of its new values as part of the body of your request. Assuming
you're in JavaScript land, you could update an item with something resembling the following.

```javascript
var id = 5;
var name = 'John Doe';
var xhr = new XMLHttpRequest();
xhr.open('POST', '/hyper-core/mysql/database/table/update?id=' + id, true);
xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
xhr.onreadystatechange = function() {
  if (xhr.readyState === 4) {
    eval("window.res = " + xhr.responseText);
    alert('Item was successfully updated, affected records was; ' + window.res.affected_records);
  }
};
var body = 'name=' + name;
xhr.send(body);
```

The above will update the `name` value for your `database.table` database item having the id of 5, 
and set its new value to _"John Doe"_. **Notice**, the `update` method can only be given one HTTP query
parameter as its condition. To construct more complex update statements, you must use the extensibility
features, which we will discuss further down in this document. Notice also that both the `insert` method,
and the `update` method, requires you to create your requests as a URL encoded form request. This is done by
making sure you set the `Content-Type` HTTP header to `application/x-www-form-urlencoded`.
