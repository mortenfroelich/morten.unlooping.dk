----
title: TKD Challenge! First status!
description:  TKD Challenge! First status!
author: Morten Frølich
----

So one week into [The Kanji Damage](http://http://www.kanjidamage.com) Challenge! I'm writing this and enjoying the sweet and bitter taste of my first Sierra Nevada Pale Ale!

I finished off last night learning [切 cut / important](http://www.kanjidamage.com/kanji/165-cut-important-%E5%88%87) number 167 according to the official Kanji Damage list! So I passed my goal by 48 symbols!

I have been using [Anki](http://www.ankirs.net) and [The Ultimate Kanji Damage deck](https://ankiweb.net/shared/info/748570187). I modified the deck slightly to move the stroke order to the bottom since I wont be focusing on stroke order for the time being. I believe modern dictionary tools are able to ignore a faulty stroke order and I don't plan on writing Japanese on anything but the computer for the foreseeable future.

To make sure I reach my goal of 17 Kanji a day I setup Anki to show 40 new cards a day. 40 since the deck contains both a card for reading and writing each Kanji and I want a bit of leeway if I'm forced to skip a days practice. I also think it will be desirable to have some time in the end of the challenge to review all the Kanji I've picked up.

So far it is going very smoothly. The mnemonics and radical based approach of Kanji Damage clicks amazingly well with my memory.

I am a bit worried that my basic Japanese skill is falling behind my Kanji knowledge but so far it is just a great incentive to get more into the rest of Japanese.

To combine the efforts I will also try to piece together a secondary Anki deck with sentences using the frequently used Kanji (having many stars in Kanji Damage).

Ideally the front of each card should be a short meaningful sentence and the back the Kanji with kana and a translation. Hopefully this will strengthen my reading skills and let me pickup some of the Kunyomi and Jukugo.

## Japanese input in Emacs ##
After spending a bit of time setting up Mint to allow Japanese input using iBus and Anthy I tried to actually enter some text in Emacs only to realize that Emacs (of course) has its own method of Japanese input.

This can be activated with `set-input-method` and selecting `japanese`. The shortcut key `C-\` allows for quicker access to change input methods. To have any chance of actually reading the Kanji with my current skill level I needed to greatly increase the font-size. I figured out how to do this by either `shift-mouse button 1` and selecting `Increase Buffer Text Size` or running the function `text-scale-increase`.

Since I have very different desires for how I edit text files containing Japanese and those that don't I set out to configure Emacs to switch to Japanese input and increase the font size dramatically when opening Japanese text files. With a bit of help with the freenode #emacs irc channel I got the following snippet in my .emacs file.

~~~~
;;Set up hooks so that .jptxt and .jpmd files are treated as japanese with japanese input and large font size.
(defun my-set-text-japanese ()
  (when (and (stringp buffer-file-name)
             (or (string-match "\\.jp.txt\\'" buffer-file-name)
		 (string-match "\\.jp.md\\'" buffer-file-name)))
    (set-input-method "japanese")
    (text-scale-set 10)))

(add-hook 'find-file-hook 'my-set-text-japanese)
~~~~

Now I am all set to start typing the answers to Genki exercises and creating an Anki deck to practice readingxb.
