FROM debian:testing
MAINTAINER devel@olbat.net

# Install debian development and packaging tools
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    sudo \
    build-essential \
    debhelper \
    devscripts \
    fakeroot \
    dpatch \
    equivs \
    lintian \
    quilt

# Add debian user
RUN useradd \
  --groups=sudo \
  --create-home \
  --home-dir=/home/debian \
  --shell=/bin/bash \
  debian

# Disable sudo password checking for users of the sudo group
RUN sed -i '/%sudo[[:space:]]/ s/ALL[[:space:]]*$/NOPASSWD:ALL/' /etc/sudoers

# Display a warning if the the DEBFULLNAME or DEBMAIL variables
# were not overridden at launch time
RUN /bin/echo -e \
  '[ "$DEBMAIL" == "user@domaim.tld" -o "$DEBFULLNAME" == "Debian" ] \\\n'\
  '  && echo "WARNING: please do not forget to customize" \\\n'\
  '    "DEBFULLNAME and DEBMAIL env variables"' \
  >> /home/debian/.bashrc

# Clean image
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* && mkdir /var/lib/apt/lists/partial

# Setup environment
ENV DEBFULLNAME Debian
ENV DEBMAIL user@domain.tld
USER debian
WORKDIR /home/debian

# Default shell
CMD ["/bin/bash","--login","-i"]
