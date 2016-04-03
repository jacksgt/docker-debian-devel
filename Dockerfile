FROM debian:testing
MAINTAINER devel@olbat.net

# Add debian sources repository to the /etc/apt/sources.list file
RUN sed -i \
  '/testing[[:space:]]\+main[[:space:]]*$/\
  {p; s/^\([[:space:]]*\)deb\([[:space:]]\+.*\)$/\1deb-src\2/}' \
  /etc/apt/sources.list

# Install debian development and packaging tools
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    sudo \
    build-essential \
    debhelper \
    dh-systemd \
    devscripts \
    fakeroot \
    dpatch \
    equivs \
    lintian \
    quilt \
    nvi \
    git-buildpackage \
    pristine-tar


# Add debian user
RUN useradd \
  --groups=sudo \
  --create-home \
  --home-dir=/home/debian \
  --shell=/bin/bash \
  debian

# Disable sudo password checking for users of the sudo group
RUN sed -i '/%sudo[[:space:]]/ s/ALL[[:space:]]*$/NOPASSWD:ALL/' /etc/sudoers

# Display a warning if the the DEBFULLNAME or DEBEMAIL variables
# were not overridden at launch time
RUN /bin/echo -e \
  '[ "$DEBEMAIL" == "user@domaim.tld" -o "$DEBFULLNAME" == "Debian" ] \\\n'\
  '  && echo "WARNING: please do not forget to customize" \\\n'\
  '    "DEBFULLNAME and DEBEMAIL env vars"' \
  >> /home/debian/.bashrc

# Clean image
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* && mkdir /var/lib/apt/lists/partial

# Setup environment
ENV DEBFULLNAME Debian
ENV DEBEMAIL user@domain.tld
USER debian
WORKDIR /home/debian

# Default shell
CMD ["/bin/bash","--login","-i"]
