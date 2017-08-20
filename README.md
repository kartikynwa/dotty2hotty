# Salve, straggler.

## Instructions

Nothing too complicated. Have the required stuff installed. This includes:
* i3, polybar, rofi, compton
* zsh with zprezto, termite
* nvim with dein
* miscellaneous bits: fonts and...uh...etc.

```bash
cd ~
git clone https://gitlab.com/kartikynwa/dotty2hotty.git
dotty2hotty/install.sh
```

## Things that do not matter

![Scotty2Hotty](https://gitlab.com/kartikynwa/dotty2hotty/raw/master/scotty2hotty.png "Scotty2Hotty")  
`© All rights reserved by Scotty2Hotty. (I think.)`

Welcome to the humble abode of my _dotfiles_. I once used to be the forlorn
shipwreck that you are. Before undertaking this endeavour, I had little 
idea of how bash scripts, symlinking and git work. Through the sheer force of
my immense willpower and unwavering tenacity, I succeeded in Googling a lot
of shit and getting this done that other peeps had been so kind to share.

One of the things that bothered me about the dotfile git repositories of 
other "_developers_" was that there was no way of reliably knowing where
the symlink was supposed to be made. A lot of them had a loop over the names
of the files that would simple be placed in `~/.<name>` followed by edge cases.
Some would have the files placed in a folder like  `config` then use black
magic fuckery to append a `.` before them.

One of the more ingenious solutions was making a bare git repository in the
home directory. It is talked about in
[**THIS**](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/) 
blog post. Any file in the home directory can then be added to it.
This does away with the need to symlink. However, I chose to not follow this
approach for two reason:

1. This method requires you to have more than just surface knowledge of how git
   works. I, being the greatness that I am, do not have the time to trifle with
   such trivialities.
2. Can't put my finger on it but something about it makes it look like a
   little bit like a जुगाड़. It works, yeah. But something doesn't seem right
   about turning my home directory into _possibly_ a git directory. U feel me?

As such I came up with my own patent pending method. I add the path where the
symlink has to be created as a comment in the first line in the format
`# PATH=<path>`. This is fairly straightfoward, lets me backup before creating
the symlinks and the only edge cases are bash scripts which have a shebang in
the opener. This can be easily taked care of by putting the path in the second
line instead. Unfortunately, even my genius can only materialise so many
innovations in one go. So far, it works for me and if I need to I will pull
the trigger on that change. One flaw that stings me is that the repo folder
_NEEDS_ to be created in the home directory. I might be able to fix that but
to be honest I haven't even begun to care about it.

Also, all the scripts that I saw were so dry. Eugh! Fucking programmers man.

If you stumbled upon this untraversed corner of git repos looking for answers, I
hope you have found something helpful that might let you be more like me and less
like yourself.

Adieu, friend.
