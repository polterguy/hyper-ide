## Selecting items

The select operation takes the following optional parameters as HTTP query parameters. Notice,
all _"special parameter types"_, such as columns, requires square brackets **[xxx]** surrounding their names.
This is to prevent these parameters from _"clashing"_ with your generic column
_"where"_ declarations. The `select` operation requires you to use a `GET` HTTP request.

* __[columns]__ - Which columns you want to select, defaults to `*` (all columns).
* __[order-by]__ - Which column you want to order your select query by. No default value.
* __[order-dir]__ - Can be either `asc` or `desc`, and declares whether or not you'd like to order ascending or descending. Defaults to `asc`.
* __[offset]__ - Offset of where to start fetching items. Defaults to `0`.
* __[limit]__ - Number of items to return. Defaults to `10`. Notice, to avoid having buggy front end code exhaust the server and bandwidth resources, it will throw an exception if you try to select more than 250 items.
* __[boolean]__ - Which boolean operator to use for multiple filter criteria. Defaults to `OR`.
* __xxx__ - Becomes additional parts of your `where` clause. Basically _"anything else"_. **Notice** - These additional arguments are `OR`'ed together by default. Change the boolean operator by changing the `[boolean]` argument.

All parameters above are optional, and will be given _"sane defaults"_ if omitted. If you want to 
select only the `description` and `id` columns, and sort descending by `description`, from your `todo` database, and 
its `items` table - You can accomplish that with the following URL.

```markdown
/hyper-core/mysql/todo/items/select?[columns]=description,id&[order-by]=description&[order-dir]=desc
```

Assuming you have followed our _"AngularJS tutorial"_, you can [open this link](/hyper-core/mysql/todo/items/select?[columns]=description,id&[order-by]=description&[order-dir]=desc)
in a new tab to see the results of the above query towards your database.

The above will return the first 10 records, but only the `description` and `id` columns, and sort your results descending by
their `description` column's value. All additional parameters becomes a part of the where clause to your SQL, and must all 
contain two components, separated by `:`. Below are the explanation for these components.

* __operand__ - Operand to use for your clause. Can be `like`, `equal`, `not-equal`, `less-than`, `more-than`, `less-than-equal`, or `more-than-equal`.
* __value__ - Value to compare against.

If you'd like to retrieve only items which have a `description` containing the string `%groceries%` for instance, 
you could accomplish that with the following URL.

```markdown
/hyper-core/mysql/todo/items/select?description=like:%groceries%
```

**Important** - Remember to URL encode your URL!

Notice, if you supply multiple additional query parameters, these will be `OR`'ed together by default in your select SQL.
This means that the following would select all items having either the firstname containing _"john"_, or the surname 
containing _"hansen"_.

```markdown
/hyper-core/mysql/database/table/select?firstname=like:%john%&surname=like:%hansen%
```

If you wish to use the `and` boolean operator instead, you can explicitly override the boolean operator your MySQL
queries are constructed with, by adding a `[boolean]` argument, and set its value to `and`. For the above query, this
would resemble the following.

```markdown
/hyper-core/mysql/database/table/select?firstname=like:%john%&surname=like:%hansen%&[boolean]=and
```

The above URL would fetch only items containing both the text _"john"_ in its firstname, **AND** the value of _"hansen"_
in its surname. More complex queries, such as join operations, and richer SQL queries, can be constructed using
the extensibility features of the MySQL module. Which we will have a look at later.
