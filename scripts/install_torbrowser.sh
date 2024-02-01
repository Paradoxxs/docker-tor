#!/usr/bin/env bash
echo "Install TorBrowser"


TOR_URL=$(curl -q https://www.torproject.org/download/ | grep downloadLink | grep linux | sed 's/.*href="//g'  | cut -d '"' -f1 | head -1)
FULL_TOR_URL="https://www.torproject.org/${TOR_URL}"

wget --quiet "${FULL_TOR_URL}" -O /tmp/torbrowser.tar.xz
tar -xJf /tmp/torbrowser.tar.xz -C $TOR_HOME
#rm /tmp/torbrowser.tar.xz


cp $TOR_HOME/tor-browser/start-tor-browser.desktop $TOR_HOME/tor-browser/start-tor-browser.desktop.bak
cp $TOR_HOME/tor-browser/Browser/browser/chrome/icons/default/default128.png /usr/share/icons/tor.png
chown 1000:0 /usr/share/icons/tor.png
sed -i 's/^Name=.*/Name=Tor Browser/g' $TOR_HOME/tor-browser/start-tor-browser.desktop
sed -i 's/Icon=.*/Icon=\/usr\/share\/icons\/tor.png/g' $TOR_HOME/tor-browser/start-tor-browser.desktop
sed -i 's/Exec=.*/Exec=sh -c \x27"$HOME\/tor-browser\/tor-browser\/Browser\/start-tor-browser" --detach || ([ !  -x "$HOME\/tor-browser\/tor-browser\/Browser\/start-tor-browser" ] \&\& "$(dirname "$*")"\/Browser\/start-tor-browser --detach)\x27 dummy %k/g'  $TOR_HOME/tor-browser/start-tor-browser.desktop


cat >> $TOR_HOME/tor-browser/Browser/TorBrowser/Data/Browser/profile.default/prefs.js <<EOL
user_pref("app.update.download.promptMaxAttempts", 0);
user_pref("app.update.elevation.promptMaxAttempts", 0);
user_pref("app.update.checkInstallTime", false);
user_pref("app.update.background.interval", 315360000);
user_pref("extensions.torlauncher.prompt_at_startup", false);
user_pref("extensions.torlauncher.quickstart", true);
user_pref("browser.download.lastDir", "/home/kasm-user/Downloads");
user_pref("torbrowser.settings.bridges.builtin_type", "");
user_pref("torbrowser.settings.bridges.enabled", false);
user_pref("torbrowser.settings.bridges.source", -1);
user_pref("torbrowser.settings.enabled", true);
user_pref("torbrowser.settings.firewall.enabled", false);
user_pref("torbrowser.settings.proxy.enabled", false);
user_pref("torbrowser.settings.quickstart.enabled", true);
EOL


echo "Done Installing TorBrowser"