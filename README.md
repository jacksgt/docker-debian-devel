# Debian development image

## Overview
Docker image including Debian development and packaging tools.

## Configuration
The _sudo_ package is installed by default, password checking has been disabled.

_Note:_ don't forget to customize `DEBFULLNAME` and `DEBEMAIL` environment variables.

## Run examples
Run dch (in the current directory)
```bash
docker run -it --rm -v $(pwd):/src -w /src \
  -e DEBFULLNAME='Name' -e DEBEMAIL='name@domain.tld' \
  olbat/docker-debian-devel:stable dch -i
```

Run debuild
```bash
docker run -it --rm -v $(pwd):/src -w /src \
  -e DEBFULLNAME='Name' -e DEBEMAIL='name@domain.tld' \
  olbat/docker-debian-devel:stable debuild -us -uc
```

Open a shell
```bash
docker run -it --rm -v $(pwd):/src -w /src \
  -e DEBFULLNAME='Name' -e DEBEMAIL='name@domain.tld' \
  olbat/docker-debian-devel:stable /bin/bash
```

### Included packages
* build-essential
* debhelper
* dh-systemd
* devscripts
* fakeroot
* dpatch
* equivs
* lintian
* quilt
* nvi
* git
* git-buildpackage
* pristine-tar
* dh-make
* dh-make-perl
* python3-stdeb
* gem2deb
* npm2deb
