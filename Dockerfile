FROM ghcr.io/linuxserver/baseimage-kasmvnc:alpine319
LABEL maintainer="Paradoxxs"
# title
ENV TITLE=TOR

RUN apk add --no-cache tor
# Install xz-utils to handle xz-compressed files
RUN apk add --no-cache xz
RUN apk add --no-cache zenity


ENV TOR_HOME=/home/tor-browser/
RUN mkdir -p $TOR_HOME

# Create a non-root user
#RUN adduser -D -h /tor toruser



workdir $TOR_HOME
run wget https://www.torproject.org/dist/torbrowser/13.0.9/tor-browser-linux-x86_64-13.0.9.tar.xz
run tar -xf tor-browser-linux-x86_64-13.0.9.tar.xz
run chmod -R 777 $TOR_HOME
# Change ownership and permissions of /docker-mods



# add local files
COPY /root /

RUN cp $TOR_HOME/tor-browser/start-tor-browser.desktop $TOR_HOME/tor-browser/start-tor-browser.desktop.bak
RUN cp $TOR_HOME/tor-browser/Browser/browser/chrome/icons/default/default128.png /usr/share/icons/tor.png
RUN chown 1000:0 /usr/share/icons/tor.png
RUN sed -i 's/^Name=.*/Name=Tor Browser/g' $TOR_HOME/tor-browser/start-tor-browser.desktop
RUN sed -i 's/Icon=.*/Icon=\/usr\/share\/icons\/tor.png/g' $TOR_HOME/tor-browser/start-tor-browser.desktop
RUN sed -i 's/Exec=.*/Exec=sh -c \x27"$HOME\/tor-browser\/tor-browser\/Browser\/start-tor-browser" --detach || ([ !  -x "$HOME\/tor-browser\/tor-browser\/Browser\/start-tor-browser" ] \&\& "$(dirname "$*")"\/Browser\/start-tor-browser --detach)\x27 dummy %k/g'  $TOR_HOME/tor-browser/start-tor-browser.desktop

RUN mkdir -p /tmp/tor-browser/Browser/
RUN ln -s $TOR_HOME/tor-browser/start-tor-browser.desktop /tmp/tor-browser/Browser/start-tor-browser.desktop 

RUN mkdir -p $HOME/Desktop/
RUN chown -R 1000:0 $TOR_HOME/
RUN cp $TOR_HOME/tor-browser/start-tor-browser.desktop $HOME/Desktop/
RUN chown 1000:0  $HOME/Desktop/start-tor-browser.desktop



# ports and volumes
EXPOSE 3000

VOLUME /config
