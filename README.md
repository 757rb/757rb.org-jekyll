
<div style="float: left">
  <img src="https://raw.github.com/757rb/757rb.org-jekyll/master/_assets/images/mermaid_16ppp.png" width="80" style="padding:0px 15px 5px 0px;" />
</div>

# 757rb.org Website Source

Our website is built using [jekyll](http://jekyllrb.com), a static website and blog generator written in Ruby. Our blog is hosted on GitHub using [GitHub Pages](http://pages.github.com). The [repository that hosts](https://github.com/757rb/757rb.org/tree/gh-pages) the static site is different than this one but you never need to manually think about that. This repo does all the driving.


# Setup

These steps rarely need to be done after your initial setup. 

First, install some dependencies. Use MacPorts or Homebrew as desired. Also, our current required `.ruby-version` is 2.0.0, any patch version. We highly suggest using [rbenv](https://github.com/sstephenson/rbenv) for installing ruby versions.

```shell
$ brew install optipng
$ brew install tidy
$ bundle install
```

* The `optipng` binary is not required.
* The `tidy` binary is required as part of the deploy task.
* The `rsync` binary. This is installed already on most POSIX systems. Used for deploy task.


# Developing

After all things are installed, consult each file in the tasks directory for some development tips. Since we use Bundler bin stubs, make sure to have the local `.bin` folder is high in your `$PATH`. See [rbenv's for recommendations](https://github.com/sstephenson/rbenv/wiki/Understanding-binstubs#adding-project-specific-binstubs-to-path).


### Technology

We use the following technology along with jekyll.

* [jekyll-assets](https://github.com/ixti/jekyll-assets#readme) - Enables the sprockets asset pipeline for jekyll.
* [Sass](http://sass-lang.com) - Sass makes CSS fun again!. We use the `.scss` format.
* [Compass](http://compass-style.org) - The best Sass CSS framework ever!.
* [CoffeeScript](http://coffeescript.org) - High level language which compiles down to JavaScript.
* [Zepto.js](http://zeptojs.com) - Zepto is a minimalist JavaScript library for modern browsers with a largely jQuery-compatible API.
* [jquery-cookie](https://github.com/carhartl/jquery-cookie) - Slighly modified for Zeopt `$` compatability.
* [companimation](http://mikefowler.me/companimation/) - Sass/Compass framework for Dan Eden's Animate.css.


### Server

We suggest using [Pow](http://pow.cx) to host the developent site. Using Pow means you do not have to start up a development server every time you want to work on `757rb.dev`. We acheive Pow compatability by including a simple `config.ru` [rackup file](http://rubylearning.com/blog/a-quick-introduction-to-rack/) that serves all static content via a `public` directory symlink to the generated jekyll `_site` directory. Alternately you can use the `jekyll serve` command to boot up a temporary WEBrick server.

The jekyll server command has a built in `--watch` option so changes will automatically trigger a rebuild of the site. However, if you use Pow, we suggest investing in [LiveReload](http://livereload.com). Point it to your 757rb.org-jekyll directory, turn off all compilation, then enable the "Run a custom command..." option. Set it to the run the `jekyll-livereload` shell script in the tasks directory of this repository.


### Task Scripts

This folder contains a few usefull bash shell scripts that making working on our site more enjoyable. Run them in the command line by just typing `./tasks/name` where name could be any one of the following.

* `jekyll` - Build the site using jekyll and clean up the HTML with tidy.
* `jekyll-livereload` - Loads rbenv for LiveReload and builds the site using the above script.
* `optipng` - Find all PNG images in the _assets/images directory and compress the hell out of em!
* `deploy` - Build and deploys the site to our sister github repo.


# Contribute & Deploy

Simple steps to contirbute and deploy updated code or posts.

* Work on the site.
* Commit and push your changes. Note, your commit message will be used for the deploy message.
* Run the `./tasks/deploy` task.
* Profit!


# License

Blog content and design are Copyright (c) 2013, 757.rb Norfolk, VA Ruby Users Group.

