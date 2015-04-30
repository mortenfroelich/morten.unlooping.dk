---
title: Getting up and running
description: Dairy of setting up a system for development
author: Morten Frølich
---

Since I just started paternity leave I have a chance to get back into some hobby projects.

This blog/homepage/scratchpad will be my first (of many hopefully). Having mainly a long list of [projects](../projects.html) I thought I would start with a short blog post about how I got this site up and running.

### The machine ###
First thing was getting a Linux box up and running. I got too frustrated messing around with Emacs and `haskell mode` on my Mac during my last stint with Haskell and [Learn You a Haskell for Great Good!](http://learnyouahaskell.com). So I decided to have a go at it running more cleanly on a Linux machine. Luckily my wife had an "old" Dell Studio 1558 lying around that she had replaced with a new mac book pro. Sadly it was sorely in need of a good dust off. Fustratingly cleaning out the fan requires taking apart the entire laptop. Thankfully a bit of googling provided this great [guide](http://www.insidemylaptop.com/how-to-disassemble-dell-studio-1555-laptop/) and then it was just a couple hours with a screwdriver to take everything apart blow some compressed air through the cooling unit and put everything back together again. 

### Which Linux distribution? ###
With a machine all set I just needed to decide on a Linux distribution to roll with. I ended up going with the MATE version of Linux Mint. MATE due to its apperent ease of use with XMonad which I have been wanting to have a go at and its no frills approach also appeals to me. Linux Mint was chosen due to my previous positive experience with Ubuntu and wanting to get up and running fast.

### Hakyll installation ###
After a successfull install of Linux Mint 17.1 I went ahead and attempted a quick install of Hakyll. I went ahead and tried installing the Haskell Platform form the debian package which rolled in nicely. Then I jumped into the [installation guide from the Hakyll website](http://jaspervdj.be/hakyll/tutorials/01-installation.html)

~~~~
$ cabal install hakyll
~~~~

Resulted in a request to --forcereinstalls being somewhat weary of ending up in Cabal-Hell I decided to give it a run. Only to be face with a lovely series of `Exit code 1` from installation of pandoc among others.

This is when I double checked what version of the Haskell Platform was in the debian package. It turns out that only version 2013.2 is present in the repositories. So I went ahead with a bit of `apt-get remove` magic to clean out the old Haskell Platform and went straight to the [source](http://jaspervdj.be/hakyll/tutorials/01-installation.html) for a nice binary tarball. After following the instructions I was up and running with version 2014.2.

Time for a second round of `cabal install hakyll` this time I got a bit deeper in only to be faced with a explosion of `Exit code 1`, `cannot find -lz` thankfully a bit of googling explained that `cannot find -lz` is piglatin for I am missing a lib32z1 dependency. The fix was (atleast to get cabal-install to compile) to install the development package with synaptic.

~~~~
$ sudo apt-get install lib32z1-dev
~~~~
A bit of a wait on compilation and I had a stellar installation of hakyll.

~~~~
$ hakyll-init morten
hakyll-init: command not found
~~~~

Alright so add `$HOME/.cabal/bin` to $PATH too .bash_profle? .profile? .bash_rc? After a bit of searching I hope I correctly understood that .bash_rc was the right place to add the below line code.

~~~~
PATH="$HOME/bin:$HOME/.cabal/bin:$PATH"
~~~~

And Voilá the basic template for this site was born. Quick runs of ghc make and `./site build`, `./site watch` and the template was running on my localhost.

### Emacs Haskell-mode ###
One of reasons for having a run at Emacs was to get access to the great open source tooling that the community has built for Emacs. I am used to working with a full fledged Visual Studio including ReSharper so I will probably have to fidle around with packages for a bit to get the same level of automation. `haskell-mode` seems like a great place to start. I attempt to install it using the debian package but it seemed to be broken. The installation instructions on the [project website](https://github.com/haskell/haskell-mode) worked after adding the `melpa` repositories to my .emacs. Which was done by adding the below lines to my .emacs.

~~~~
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))
~~~~

### Deploying the site ###
Finally on to deploying the site! Thankfully my brother in law has a `LAMP` server up an running and was kind enough to set up a virtual host for me. So a simple `rsync` of the compiled site will work as version 0.1 of deployment. I will have to figure out how to get a smoother deployments later on. Perhaps using a github repository and a cron-job if I can get that working on his host.

### Where to ###
So where to now? First I think I will brush up on my Emacs by redoing the built in tutorial and perhaps a getting started guide. I think I will try using [Anki](http://ankisrs.net/) to get up to speed on shortcuts and maybe expand it to Haskell tidbits later on. After that it is on to defining the project of fleshing out the site!
