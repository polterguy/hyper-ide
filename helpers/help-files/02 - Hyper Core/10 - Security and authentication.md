## Security and authentication

Hyper Core indirectly contains highly secure and flexible authentication features to login and logout a user, towards 
the [p5.auth](https://github.com/polterguy/phosphorusfive/tree/master/plugins/extras/p5.auth) authentication/authorization
module in Phosphorus Five. This allows you to easily authenticate your users towards
the user and role based _"auth"_ system in Phosphorus Five. The main URL for this module is `auth`.

### The authentication system's internals

**Notice**, the authentication system in Hyper Core builds upon HTTP cookies. These are served such that
they are not accessible on the client (using JavaScript). This has many advantages, and some few disadvantages.
The main advantage, is that the authentication process becomes _dead simple_ for JavaScript/browser based
authentication, and almost nothing you even have to even worry about, since the browser will
automatically take care of handling these cookies for you. This also makes the authentication process _highly secure_, 
since these cookies by default are being transferred such that the JavaScript runtime in the browser, doesn't even 
have access to them. The server can also easily be configured such that it doesn't serve these cookies,
without an SSL connection from a client, to further prevent a _"man in the middle"_, picking up your credentials,
and performing a _"session highjacking"_.

However, for other types of clients, it requires that you are able to store the cookies returned
from the server, and re-transmit them upon consecutive requests, as a _"user ticket"_. All in all though,
this authentication process, is orders of magnitudes more easy to consume yourself, than stuff such as OAUTH(2),
etc - Even for thick clients, if that is what you are using to access Hyper Core.

### Logging in

Authentication is done by issuing a `POST` HTTP `login` request towards the `auth` module. If you're in JavaScript 
land for instance, you can login with something resembling the following.

```javascript
var xhr = new XMLHttpRequest();
xhr.open('POST', '/hyper-core/auth/login', true);
xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
xhr.onreadystatechange = function() {
  if (xhr.readyState === 4) {
    eval("window.res = " + xhr.responseText);
    alert('You belong to the role; ' + window.res.role);
  }
};
var username = encodeURIComponent ('your_username');
var password = encodeURIComponent ('your_password');
var persist = 'true';
xhr.send('username=' + username + '&password=' + password + '&persist=' + persist;
```

If you set the `persist` query parameter to true, a persistent cookie will be created on the client, making sure
the client will be remembered according to the persistent authentication cookie rules of Phosphorus Five. The default
value for persisting a user's credential cookie using persistent logins are `false`, implying that once the user closes
his browser, or ends his session somehow, he will have to login again. The persistent authentication cookie
rule of Phosphorus Five can be edited in your _"web.config"_ file, by changing the `p5.auth.credential-cookie-valid` key's
value.

### Logging out

If you wish to logout a user, you can issue a `DELETE` HTTP request towards its _"logout"_ counterpart. This will destroy
the authentication cookie on the client. An example can be found beneath.

```javascript
var xhr = new XMLHttpRequest();
xhr.open('DELETE', '/hyper-core/auth/logout', true);
xhr.onreadystatechange = function() {
  if (xhr.readyState === 4) {
    eval("window.res = " + xhr.responseText);
    alert('Status; ' + window.res.status);
  }
};
xhr.send();
```

### [whoami], figuring out a user's status

Since the default authentication of Phosphorus Five allows a client to persist his logged in status in a cookie on disc,
but this cookie is not accessible for the client - It is sometimes necessary to query towards the back end, to find out 
the authentication status of the client. This can be done by issuing an HTTP `GET` request towards the `whoami` submodule 
of the _"auth"_ module. This will return the username and the role of the client, if he is logged in. An example can be found below.

```markdown
/hyper-core/auth/whoami
```

If the user is not logged in, the above will return the guest username and role, which defaults to _"guest"_.

**Notice**, the authentication cookie is not accessible on the client, since this would open up for a whole range
of different types of attacks, such as _"session highjacking"_, etc. Hence, the only way to get information from the
client about the status of your client, is by issuing a `whoami` HTTP request towards the server. This request is *tiny* though,
and also consumes small amounts of server resources.

### Authorisation objects

Hyper Core builds on top of the extendible [p5.auth project](https://github.com/polterguy/phosphorusfive/tree/master/plugins/extras/p5.auth).
Each operation, database, and table within your database, get its own unique URL.
Since Phosphorus Five allows you to grant or deny access to URLs, according to which role your currently
logged in user belongs to - This gives you fine grained control over who are allowed to do what
in regards to your SQL operations. To allow for instance all users, including _"guest"_ visitors, to for instance 
evaluate `select` operations towards your above `todo` database, and its `items` table - But deny everybody 
except your _"developer"_ users to perform all other operations on the same database and table - You could create 
an authorisation object that looks like the following.

```hyperlambda
*
  p5.module.allow:/modules/hyper-core
*
  p5.hyper-core.allow:/hyper-core/mysql/todo/items/select
developer
  p5.hyper-core.allow:/hyper-core/mysql/todo/items
```

The first record above, gives all users access to the module in general. This is necessary
to have the core URL resolver in Phosphorus Five even resolve the URL,
and pass the request onwards to the _"hyper-core"_ module.

The second record, grants all users access to do `select` operations on the `todo` database, 
but only its `items` table. The third record above, gives your `developer` users access to all 
operations on the `todo` database, but only its `items` table. Since the default behaviour is 
to deny access, everything else is denied for everyone, except root users, which have access 
to do everything.

All in all, the above three access control objects, gives your _"developer"_ users complete control
over the `todo.items` database table, while random visitors have only `select` rights on the
same database table.

The default access control, unless explicitly overridden in your access control object, is 
to _deny_ all operations on all databases and all tables. So you'll need to explicitly grant
access for a role, to be able to have that role do anything towards any database in your system.

To create such access objects, you can watch the following video, which explains how to create
and maintain both users and access objects on your server.

https://www.youtube.com/watch?v=TLm0nuYzfoc

### Security

All of the common pitfalls in regards to SQL and security are simply automatically taken care of
for you in Hyper Core. An example is SQL injection attacks, which are completely eliminated.
Another example is how it builds upon the Phosphorus Five authentication/authorization mechanisms,
providing excellent security for you, by for instance salting and hashing passwords, and denying
access to the authentication file, etc. All in all, Hyper Core should for all practical concerns,
be orders of magnitudes more secure, than most things you could possibly create yourself - Assuming
you don't do something really silly yourself, such as concatenating SQL parameters into your SQL,
in your own extension methods, instead of using the SQL paremeter collection objects.
Below is a list of some of the more important security features in Hyper Core.

* Highly secure and flexible role based access control
* Passwords stored securely
* Easy to create and maintain existing users through Peeples
* SQL injection attack prevention
* Protects the code for your own extension methods from being seen
* Persists cookies safely on the client, such that session highjacking becomes impossible
* Brute force password protection, which is _on_ by default
* Optionally, credential cookies can be configured to only be served over an encrypted (SSL) connection

In addition, Hyper Core's features, allows you to store your business logic exclusively on your server, 
eliminating a whole range of security issues, such as malicious attackers modifying your JavaScript, and 
completely bypassing your security implementations, etc.

**Disclaimer**, no system is perfect, and when it comes to security, there are no guarantees. Although I 
have done my very best to make sure Hyper Core (and Phosphorus Five) is as secure as possible, I cannot
guarantee that there does not exist security holes in it somewhere, which I am not aware of myself. You 
still need to make sure your system is secure yourself, even though Hyper Core highly likely makes that job
much easier for you. You should also in addition to these features mentioned in this document, make
sure your server is setup to use the latest upgrades of its software, such as Apache, Linux, and so on.
In addition to take advantage of all other security mechanisms at your disposal, such as Linux' _"ufw_", etc.

If you happen to find a security flaw in Hyper Core (or Phosphorus Five), I would highly appreciate it
if you sent me an email. My email address is thomas@gaiasoul.com.
