FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy
LABEL maintainer="Paradoxxs"
# title
ENV TITLE=TOR

ENV TOR_HOME=/tor
workdir $TOR_HOME

# Install Tor Browser dependencies
RUN apt update
RUN apt install -y \
    xz-utils \
    wget \
    libgtk-3-0 \
    libdbus-glib-1-2 

COPY ./scripts/ $TOR_HOME/scripts/
RUN /bin/bash $TOR_HOME/scripts/install_torbrowser.sh 
RUN chown -R abc $TOR_HOME

COPY /root /

VOLUME /config
# Expose VNC and Tor Browser ports
EXPOSE 3000 