# About DockerNuke

This is a quick shell script to destroy `/var/lib/docker` and restart Docker with no images whatsoever aka ```Make Docker Clean Again```.

I wrote it because all other approaches sucks, are not fast enough, left garbage layers, etc...

# Requirements

* mv
* rm
* docker
* sudo
* systemctl

# Screenshot

```
$ ./dockernuke.sh
[1/4] Stopping Docker...[OK]
[2/4] Moving directory...[OK]
[3/4] Erasing old directory...[OK]
[4/4] Starting Docker...[OK]
```

# Issues

When you do it to often, you will get this error:

```
$ ./dockernuke.sh
[1/4] Stopping Docker...[OK]
[2/4] Moving directory...[OK]
[3/4] Erasing old directory...[OK]
[4/4] Starting Docker...Job for docker.service failed because start of the service was attempted too often. See "systemctl status docker.service" and "journalctl -xe" for details.
To force a start use "systemctl reset-failed docker.service" followed by "systemctl start docker.service" again.
```
