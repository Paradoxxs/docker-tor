FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy
LABEL maintainer="Paradoxxs"
# title
ENV TITLE=TOR
RUN mkdir /tor
ENV TOR_HOME=/tor
workdir $TOR_HOME

# Install Tor Browser dependencies
RUN apt update
RUN apt install -y \
    xz-utils \
    wget \
    libgtk-3-0 \
    libdbus-glib-1-2 \
    dos2unix

COPY ./scripts/ $TOR_HOME/scripts/
RUN dos2unix $TOR_HOME/scripts/install_torbrowser.sh
RUN /bin/bash $TOR_HOME/scripts/install_torbrowser.sh 


RUN chown -R abc $TOR_HOME

COPY /root /

VOLUME /config
# Expose VNC and Tor Browser ports
EXPOSE 3000 