## The grid system in Micro

Micro builds upon the _"flexbox grid system"_. This allows you to easily partition your web pages
into rows and columns. The grid system in Micro is also _"responsive"_, which implies that it
renders nicely also on devices with smaller screens. Below is a piece of Hyperlambda that will 
create a wire frame for you.

If you want to test the code in these tutorials, then the best way is to use [Hypereval](/hypereval),
and create a new _"empty snippet"_, and save it as a _"page"_. If you do, you can click the _"preview"_ button
to see the results of what we are going through in these tutorials. If you don't have Hypereval installed,
you can find it [in the bazar](/bazar?app=hypereval).

```hyperlambda
/*
 * Includes Micro's CSS files.
 */
micro.css.include
  skin:serious

/*
 * Creating one container with one row containing one col.
 */
create-widget
  class:container
  widgets
    div
      class:row
      widgets
        div
          class:col
          widgets
            div
              class:air-inner shaded rounded
              widgets
                h3
                  innerValue:Hello World
                p
                  innerValue:Your first Micro application.
```

The 3 most important constructs above are the `container`, `row` and `col` CSS classes. Micro
is built around a similar structure as Bootstrap CSS, and expects you to have a _"container"_ being
your root element. There also exists a `container-fullscreen` alternative. Each container can have 
as many `row` children as you wish, and each row can have multiple `col` elements inside of it again. 
This is what creates your _"grid system"_, and will automatically layout your page accordingly.
The above code will end up looking like the following.

https://phosphorusfive.files.wordpress.com/2018/01/micro-hello-world-screenshot-2.png

**Notice**, we chose to wrap our widgets inside of a div widget with the following classes `air-inner shaded rounded`.
We did this simply to add some _"bling"_ to our page. These classes adds some inner padding, some shade, 
and some rounded borders. Feel free to remove these classes if you'd like to see a more _"vanilla example"_.

The above Hyperlambda will result in something resembling the following HTML.

```htmlmixed
...
<div class="container">
  <div class="row">
    <div class="col">
      <div class="air-inner shaded rounded">
        <h3>Hello World</h3>
        <p>Your first Micro application.</p>
      </div>
    </div>
  </div>
</div>
...
```

### Containers, rows and columns

The normal container is 1120px wide. However this can be changed, by adding your own CSS selector
in your own file. The `container-fullscreen` will take up all available width. Notice, neither
the container nor the fullscreen container will spend more width than you have available in your 
browser. A row will always use the entire width inside of its container.

`col` elements however, will be evenly divided inside of their containers. If you add another `col`
in the above code for instance, then each of your columns will use 50% of the width they have available
from their rows. You can however explicitly declare how many percent of the available width you want
some specific column to use. Below is an example.

```hyperlambda
div
  class:col-20
  widgets
    p
      innerValue:20 percent.
div
  class:col-60
  widgets
    p
      innerValue:60 percent.
div
  class:col-20
  widgets
    p
      innerValue:20 percent.
```

The above example will have two columns of 20% width each, and one 60% column in the middle. If your
total don't add up to 100 though, the columns beyond 100 will wrap onto the next available _"line"_
in your row. The following classes exists for specifically declared widths.

* col-10 - 10%
* col-20 - 20%
* col-25 - 25%
* col-30 - 30%
* col-33 - 33%
* col-40 - 40%
* col-50 - 50%
* col-60 - 60%
* col-67 - 67%
* col-70 - 70%
* col-75 - 75%
* col-80 - 80%
* col-90 - 90%
* col-100 - 100%

In addition to the above grid classes, there also exists `offset` equivalents for all of the above col classes,
except 100. This allows you to _"push"_ your columns further into your page. Below is an example.

```hyperlambda
div
  class:col-20 offset-20
  widgets
    p
      innerValue:20 percent width, offset 20.
div
  class:col-50 offset-10
  widgets
    p
      innerValue:50 percent width, offset 10.
```

The above will give you 20% _"spacing"_ to the left of your first column, and 10% spacing before your
second column.

### Responsive rendering

Micro is designed with the _"mobile first approach"_, which implies that it will render responsively.
If you resize the width of your browser below 800px, then all `col` classes, regardless of their 
initial width, will _"pop"_, and fill 100% of the available width. To see this effect, try to resize 
your browser, and watch how the file explorer to the left on the page, all of a sudden at some threshold
will require 100% width.

This makes the process of supporting mobile devices, and devices width smaller viewports, almost automatically.
However, you should test your apps, also on mobile devices, to make sure they render nicely.


