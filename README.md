# Salve, straggler.

## Instructions

I have made an intelligent design choice of not including an install script
since I cannot really think of a situation where it would be useful. There are
dependencies that need to be met before an install script can do its job. Making
sure those dependencies are met is not a straightforward process.

So here is how you use these dotfiles:

1. Clone repository in the home directory. This is required for certain scripts
   to work.
2. Manually symlink the included files as needed. The usual path where they need
   to be symlinked to is included in each file as the second line.

## Things that do not matter

![Scotty2Hotty](https://bytebucket.org/kartikynwa/dotty2hotty/raw/master/scotty2hotty.png "Scotty2Hotty")  
© All rights reserved by Scotty2Hotty. (I think.)

Welcome to the humble abode of my _dotfiles_. I once used to be the forlorn
shipwreck much like yourself. Before undertaking this endeavour, I had little
idea of how bash scripts, symlinking, and git work. Through the sheer force of
immense willpower and unwavering tenacity, I succeeded in Googling a lot of
shit and getting this done using information that other peeps had been so kind
to share.

One of the things that bothered me about the dotfile git repositories of 
other "_developers_" was that there was no way of reliably knowing where
the symlink was supposed to be made. A lot of them had a loop over the names
of the files that would simple be placed in `~/.<name>` followed by edge cases.
Some would have the files placed in a folder like  `config` then use black
magic fuckery to append a `.` before them.

One of the more genius solutions was making a bare git repository in the home
directory. It is talked about in
[**THIS**](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/)
blog post. Any file in the home directory can then be added to it.  This does
away with the need to symlink. However, I chose to not follow this approach for
two reason:

1. This method requires you to have more than just surface knowledge of how git
   works. I, being the greatness that I am, do not have the time to trifle with
   such trivialities.
2. Can't put my finger on it but something about it makes it look like a
   little bit like a जुगाड़. It works, yeah. But something doesn't seem right
   about turning my home directory into _possibly_ a git directory. U feel me?

As such I came up with my own patent pending IQ 150 method. I add the path where
the symlink has to be created relating to the home directory as a comment in the
second line. The path exists in the second line to accomodate shell scipts,
where the first line is the shebang.  Does it need to be? I really do not
know. All I know is that it works and is really fucking cool. One flaw that
stings me is that the repo folder _NEEDS_ to be created in the home
directory. This can be fixed by making the scripts aware of their residing
directories but who has got the time for that?

If you stumbled upon this untraversed corner of git repos looking for answers, I
hope you have found something helpful that may let you be more like me and less
like yourself.

Adieu, friend.
