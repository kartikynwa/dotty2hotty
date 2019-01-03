# Salve, straggler.

## Instructions

Initiatie your Void Linux installation using these awesome AI MACHINE LEARNING
BLOCKCHAIN powered AGILE scripts which allow quick deployment of amazing
FEATURES.

### Install Dependencies

```
# xbps-install `cat packages.txt | tr '\n' ' '`
```

### Symlink Dotfiles 

Be careful while doing this. Do not forget to look at which files the script
symlinks. For now, the script doesn't overwrite any files but caution is advised
anyway.
```
$ ./install.sh
```

### Change default shell

`chsh`

### Add power commands to NOPASSWD

Edit `\etc\sudoers` using the `visudo` command. Add the following line:

```
%wheel ALL=(ALL) NOPASSWD: /usr/bin/halt, /usr/bin/poweroff, /usr/bin/reboot, \
            /usr/bin/shutdown, /usr/bin/zzz, /usr/bin/ZZZ
```

### Install PulseAudio

Because it works(TM). Packages needed are included in `packages.txt`.

```
$ echo 'Start ALSA service'
# ln -s /etc/sv/alsa /var/service/
# ln -s /etc/sv/dbus /var/service/
# ln -s /etc/sv/cgmanager /var/service/
# ln -s /etc/sv/consolekit /var/service/
```

### Configure laptop lid behaviour

In `/etc/acpi/handler.sh`. You know the rest (I hope haha).

### GTK Theme

My preference is [Materia](https://github.com/nana-4/materia-theme). Install
instructions are on the Github page.


## Things that do not matter

![Scotty2Hotty](https://gitlab.com/kartikynwa/dotty2hotty/raw/master/scotty2hotty.png "Scotty2Hotty")  
© All rights reserved by Scotty2Hotty. (I think.)

Welcome to the humble abode of my _dotfiles_. I once used to be the forlorn
shipwreck much like yourself. Before undertaking this endeavour, I had little
idea of how bash scripts, symlinking, and git work. Through the sheer force of
immense willpower and unwavering tenacity, I succeeded in Googling a lot of
shit and getting this done using information that other people had been so kind
to share.

I have tried to automate this setup as much as I can. The files that I want to
copy over have a path in their second line in the form of a comment. This kinda
works out but the scope of improvements is infinite.

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
   This may be just beacuse of the lack of knowledge on my part.

As such I came up with my own patent pending IQ 150 method. I add the path where
the symlink has to be created relating to the home directory as a comment in the
second line. The path exists in the second line to accomodate shell scipts,
where the first line is the shebang.  Does it need to be? I really do not
know. All I know is that it works and is really fucking cool. One flaw that
stings me is that the repo folder _NEEDS_ to be created in the home
directory. This can be fixed by making the scripts aware of their residing
directories but who has time for that?

If you stumbled upon this untraversed corner of git repositories looking for
answers, I hope you have found something helpful that may let you be more like
me and less like yourself.

Adieu, friend.
