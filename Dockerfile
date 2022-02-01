FROM debian:buster

RUN apt-get update \
  && apt-get install -y \
    wget \
    curl \
    gnupg2 \
    python3-distutils \
    python3-pip

ARG MOPDIY_VERSION=3.2.0-1

# Dependencyies for mopidy base
RUN wget -q -O - https://apt.mopidy.com/mopidy.gpg | apt-key add -
RUN wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/buster.list

RUN apt-get update \
  && apt-get install -y \
    mopidy=${MOPDIY_VERSION} \
    mopidy-dleyna

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
