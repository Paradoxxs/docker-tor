FROM ghcr.io/linuxserver/baseimage-kasmvnc:alpine319
LABEL maintainer="Paradoxxs"

# title
ENV TITLE=TOR

RUN apk add --no-cache tor
# Install xz-utils to handle xz-compressed files
RUN apk add --no-cache xz
RUN apk add --no-cache zenity


# Create a non-root user
RUN adduser -D -h /tor toruser



workdir /home/tor
run wget https://www.torproject.org/dist/torbrowser/13.0.9/tor-browser-linux-x86_64-13.0.9.tar.xz
run tar -xf tor-browser-linux-x86_64-13.0.9.tar.xz
run chmod -R 777 /home/tor
# Change ownership and permissions of /docker-mods

workdir /home/tor/tor-browser
# add local files
COPY /root /

# ports and volumes
EXPOSE 3000

VOLUME /config
