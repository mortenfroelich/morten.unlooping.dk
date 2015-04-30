---
title: Project Gamification
description: Plans for gamification of future projects.
author: Morten Frølich
---

I had great success with gamification of my last project. So I will give it another try!

Since studies (citation needed) show that randomized rewards enhance the effect I wrote a little python script (it can be found at the bottom of this post) that can plays a sound file after a random time interval.

I start this script when I am working on the project. To force myself into better Emacs habits a bit faster I've decided on the following criteria to add one minute to the timer. 

* Use the mouse for any kind of navigation in Emacs.
* Use arrow keys for navigation.
* Forget an already learned shortcut key combination.
* Forget to use modifier keys with the other hand.

I will probably use a shorter average duration to make sure I get some rewards!

## Rewards ##
Rewards are split into three categories. Each category is activated by a different sound bit playing from the script. I am currently using the following distribution of rewards:

* 70 % Small
* 29 % Medium
* 1 % Big

The simplest reward that also goes right into the pleasure centers of the brain is of course candy. While this is not healthy in itself I am usually able to reduce my normal intake by restricting it to candy that is earned through rewards.

### Small ###
- A piece of candy 

### Medium ###
- A specialty beer
- A pack of Oreos
- A bag of 'Canon Balls' chips
- A candy bar 

### Big ###
- SSD upgrade, this laptop is still running an old hard drive.

## Script ##
Below is a quick hack of a script to control the gamification. 

* 'q' exits the script
* 'f' delays the reward

Note the script uses pygyme (python-pygame deb-package) to play the music.

~~~~
from datetime import datetime, timedelta
from random import expovariate, randrange
import pygame
import curses

def main(stdscr):
  smallsong = "small.ogg"
  mediumsong = "medium.ogg"
  bigsong = "big.ogg"
  meanRewardTime = 20
  punishmentDelay = 1

  pygame.init()
  clock = pygame.time.Clock()

  stdscr.nodelay(1)
  
  sample = expovariate(1/float(meanRewardTime))

  end = datetime.now() + timedelta(minutes=sample)

  while datetime.now() < end:
    c = stdscr.getch()
    if c == 102: #f to punish
      stdscr.addstr("PUNISHMENT!\n")
      end += timedelta(minutes=punishmentDelay)
      stdscr.refresh()
    elif c == 113: #q to quit
      return

    clock.tick(60)

  roll = randrange(1,101)

  if roll == 100:
      stdscr.addstr("Time for a Big One!")
      song = bigsong
  elif roll > 80:
      stdscr.addstr("Medium time!")
      song = mediumsong
  else:
      song = smallsong
      stdscr.addstr("Small! Ding Ding Ding!")
  stdscr.refresh()

  pygame.mixer.music.load(song)
  pygame.mixer.music.play()
  while True:
    c = stdscr.getch()
    if c == 113: #q to quit
      return
    clock.tick(60)
    continue

if __name__ == '__main__':
    curses.wrapper(main)
~~~~
