## Deleting items

The `delete` operation requires you to use a `DELETE` HTTP method. It requires a single query parameter,
declaring which column and value you wish to use as your `where` clause in your final SQL. To delete an item
in our above `database.table` database, having the id of 5 for instance, could be accomplished with the following
code, assuming you're in JavaScript land.

```javascript
var xhr = new XMLHttpRequest();
xhr.open('DELETE', '/hyper-core/mysql/database/table/delete?id=5', true);
xhr.onreadystatechange = function() {
  if (xhr.readyState === 4) {
    eval("window.res = " + xhr.responseText);
    alert(window.res.affected_records + ' items was successfully deleted');
  }
};
xhr.send();
```

Neither the `delete` method, nor the `update` method requires you to use the database id to reference records
in your database. However, they both requires exactly one criteria, with a single value, which will be checked
for equality. To create more complex types of SQLs, you can use extension methods, which you can see further
down in this document how to create.