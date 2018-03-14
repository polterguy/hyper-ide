## Updating items

The `update` operation requires you to use a `POST` HTTP request. It requires one query parameter declaring
which item you'de like to update, and all of its new values as part of the body of your request. Assuming
you're in JavaScript land, you could update an item with something resembling the following.

```javascript
var id = 1;
var description = 'Walk the CAT';
var xhr = new XMLHttpRequest();
xhr.open('POST', '/hyper-core/mysql/todo/items/update?id=' + id, true);
xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
xhr.onreadystatechange = function() {
  if (xhr.readyState === 4) {
    eval("window.res = " + xhr.responseText);
    alert('Item was successfully updated, affected records was; ' + window.res.affected_records);
  }
};
var body = 'description=' + description;
xhr.send(body);
```

The above will update the `description` value for your `todo.items` database/table item, having the id of 1, 
and set its new value to _"Walk the CAT"_. 

**Notice**, the `update` method can only be given one HTTP query parameter as its condition. To 
construct more complex update statements, you must use the extensibility features of Hyper Core, 
which we will discuss later in this documentation. Notice also that both the `insert` method,
and the `update` method, requires you to create your requests as a URL encoded form request. 
This is done by making sure you set the `Content-Type` HTTP header to `application/x-www-form-urlencoded`.

**Warning**, the `update` method will update all records matching the specified query parameter. You are 
responsible to make sure only the records you actually want to update are updated. It poses no restrictions
in regards to whether or not your QUERY parameter is actually the unique database ID of your table or not.
It does however require an *exact match* on its query parameter.
