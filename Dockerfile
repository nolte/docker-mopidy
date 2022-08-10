FROM debian:bullseye

RUN apt-get update \
  && apt-get install -y \
    wget \
    curl \
    gnupg2 \
    libffi-dev \
    python3-distutils \
    python3-pip \
    # Clean-up
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache

ARG MOPDIY_VERSION=3.3.0-1

# Dependencyies for mopidy base
RUN mkdir -p /usr/local/share/keyrings \
  && wget -q -O /usr/local/share/keyrings/mopidy-archive-keyring.gpg \
    https://apt.mopidy.com/mopidy.gpg \
  && wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/buster.list

RUN apt-get update \
  && apt-get install -y \
    mopidy=${MOPDIY_VERSION} \
    mopidy-dleyna \
    mopidy-mpd \
 # Clean-up
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache

COPY requirements.txt /tmp/requirements.txt

RUN pip3 install --upgrade pip \
  && pip3 install -r /tmp/requirements.txt --upgrade

# Default configuration
ADD mopidy.conf /var/lib/mopidy/.config/mopidy/mopidy.conf

RUN chown mopidy:audio -R /var/lib/mopidy/.config

# Run as mopidy user
USER mopidy

VOLUME /var/lib/mopidy/local
VOLUME /var/lib/mopidy/media

EXPOSE 6600
EXPOSE 6680

CMD ["/usr/bin/mopidy"]
