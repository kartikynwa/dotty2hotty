# Change default shell

`chsh`

# Add power commands to NOPASSWD

Edit `\etc\sudoers` using the `visudo` command. Add the following line.

```
%wheel ALL=(ALL) NOPASSWD: /usr/bin/halt, /usr/bin/poweroff, /usr/bin/reboot, \
            /usr/bin/shutdown, /usr/bin/zzz, /usr/bin/ZZZ
```

# Install PulseAudio

Because it works(TM). Packages needed are included in `packages.txt`.

```
$ echo 'Start ALSA service'
# ln -s /etc/sv/alsa /var/service/
# ln -s /etc/sv/dbus /var/service/
# ln -s /etc/sv/cgmanager /var/service/
# ln -s /etc/sv/consolekit /var/service/
```

# Configure laptop lid behaviour

In `/etc/acpi/handler.sh`. You know the rest (I hope haha).
