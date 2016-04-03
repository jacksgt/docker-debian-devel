# Debian development image

## Overview
Docker image including Debian development and packaging tools.

## Configuration
The _sudo_ package is installed by default, password checking has been disabled.

_Note:_ don't forget to customize `DEBFULLNAME` and `DEBEMAIL` environment variables.

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
