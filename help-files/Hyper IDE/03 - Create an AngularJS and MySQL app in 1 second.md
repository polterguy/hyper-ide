## Create an AngularJS and MySQL app in 1 second

**Notice**, this tutorial requires that you have MySQL installed on your server/machine.

Select your `/modules/` folder. Then click the `+` button in your toolbar, assuming you 
have enabled the plugin that allows you to create a new module. Then name your app _"todo"_, 
and select the `angular-todo` type. At which point your screen should resemble the following.

https://phosphorusfive.files.wordpress.com/2018/01/angular-todo-screenshot.png

Then simply click the _"Create"_ button, and you're done. If you want to try out your app,
you can [click this link](/todo). The above process will create a new module for you, having the following files.

* _"index.html"_ - Your Angular HTML file
* _"controller.js"_ - Your Angular controller
* _"styles.css"_ - Some default styling
* _"desktop.hl"_ - A desktop icon for Phosphorus Five
* _"launch.hl"_ - Your app's launcher file
* _"startup.hl"_ - Your app's startup file
* _"install.hl"_ - Evaluated when your app is installed, through for instance the _"Bazar"_
* _"uninstall.hl"_ - Evaluated when your app is uninstalled

In the video below, I walk you through the main features of the app you just created, explaining the 
different parts of your app. Unless you're already an AngularJS guru, you will probably benefit from 
watching it. And even for an AngularJS guru, there are a couple of points you would want to understand
which are a part of Phosphorus Five, and not Angular features. The app is using Hyper Core on the server
side, to persist your changes into your MySQL database. We will dive into Hyper Core in later
chapters.

**Notice**, the app will use an old version of AngularJS. You might want to upgrade the JavaScript inclusion
to use a newer version of AngularJS.

https://www.youtube.com/watch?v=Zr5f7oweed8

Below you can find the main parts of our code, first our _"controller.js"_ file.

```javascript

/*
 * Main module for our Angular app.
 */
angular.module ('todoApp', [])

  /*
   * Our only controller, responsible for invoking our server side back end,
   * and databinding our view.
   */
  .controller ('TodoListController', function ($scope, $http) {

    /*
     * Fetching existing items from our server.
     */
    var todoList = this;
    $http.get ('/hyper-core/mysql/todo/items/select').
      then (function successCallback (response) {
        todoList.todos = response.data;
    });
 
    /*
     * Invoked by our view when a new item has been added by user.
     * Updates our view with the item, and invokes server-side back end,
     * by issuing an 'insert' command towards our REST ORM.
     */
    todoList.addTodo = function () {

      /*
       * Invoking our server-side method, to insert item into our database.
       *
       * Notice, server-side back end requires a 'PUT' request.
       */
      $http ({
        method:'PUT', 
        url: '/hyper-core/mysql/todo/items/insert', 

        /*
         * Our server-side requires the data for our insert operation to be URL encoded,
         * hence we'll need to transform from the default serialization logic of Angular,
         * which is JSON, to URL encoded data.
         */
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        transformRequest: function (obj) {
          var str = [];
          for (var p in obj) {
            str.push (encodeURIComponent (p) + '=' + encodeURIComponent (obj [p]));
          }
          return str.join ('&');
        },
        data: {description: document.getElementById ('newItem').value}
      }).then (function successCallback (response) {

        /*
         * Pushing our new item into our list of items, and making sure
         * we set our textbox' value to empty.
         */
        todoList.todos.push ({
          description: todoList.todoText, 
          id:response.data.id
        });
        todoList.todoText = '';
      });
    };
 
    /*
     * Invoked by our view when an item is deleted.
     */
    todoList.delete = function (id) {

      /*
       * Deleting our clicked item from our list of items from our view.
       */
      for(var idx = 0; idx < todoList.todos.length; idx++) {
        if (todoList.todos [idx].id === id) {
          todoList.todos.splice (idx,1);
          break;
        }
      }

      /*
       * Invoking our server-side method, to delete the item from our database.
       *
       * Notice, server-side back end requires a 'DELETE' request.
       */
      $http.delete('/hyper-core/mysql/todo/items/delete?id=' + id);
    }
  });
```

Then our _"index.html"_ file.

```htmlmixed
<!doctype html>
<html ng-app='todoApp'>
  <head>
    <script src='https://ajax.googleapis.com/ajax/libs/angularjs/1.6.6/angular.min.js'></script>
    <script src='/modules/todo/controller.js'></script>
    <link rel='stylesheet' type='text/css' href='/modules/micro/media/main.css' />
    <link rel='stylesheet' type='text/css' href='/modules/micro/media/skins/serious.css' />
    <link rel='stylesheet' type='text/css' href='/modules/todo/styles.css' />
  </head>
  <body>
    <div class='container'>
      <div class='row'>
        <div class='col'>
          <div ng-controller='TodoListController as todoList' class='shaded air-inner bg rounded'>
            <h1>Todo</h1>
            <form ng-submit='todoList.addTodo()'>
              <div class='new-item strip'>
                <input type='text' autocomplete='off' ng-model='todoList.todoText' placeholder='Add item ...' id='newItem'>
                <input type='submit' class='submit-button' value='add'>
              </div>
            </form>
            <div>
              <ul class='todos'>
                <li ng-repeat='todo in todoList.todos' ng-click='todoList.delete(todo.id)'>{{todo.description}}</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
```
