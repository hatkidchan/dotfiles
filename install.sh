#!/bin/bash
self="$(realpath "$(dirname $0)")";
config="${XDG_CONFIG_HOME:-$HOME/.config}";
share="${XDG_SHARED:-$HOME/.local/share}"

echo -e "\e[33mThis script will install a \e[31mLOT\e[33m of files.";
echo -e "Some of them may \e[31mbreak your environment\e[33m.";
echo -e "Do you \e[32mreally\e[33m want to install this dots?";
echo -e "Type \e[34m\"Yes, install this shit!\"\e[33m to install;";
echo -e "Type \e[34msomething else\e[33m to exit\e[0m";
read -p "> " reply;

if [[ "$reply" == "something else" ]]; then
    echo -e "\e[34mMr. Logic lmao\e[0m";
    exit;
else
    if [[ ! "$reply" == "Yes, install this shit!" ]]; then
        exit;
    fi;
fi;

echo -e "\e[32m[*] Creating folders...\e[0m";
[ -d "$config" ] || mkdir -p "$config";
[ -d "$HOME/.local/bin" ] || mkdir -p "$HOME/.local/bin";
[ -d "$share" ] || mkdir -p "$share";
echo -e "\e[32m[*] Installing dotfiles...\e[0m";
set -x
cp -r "$self/bin/." "$HOME/.local/bin/.";

[ -d "$config/i3" ] || mkdir -p "$config/i3";
cp -r "$self/i3/." "$config/i3/.";

[ -d "$HOME/.moc" ] || mkdir -p "$HOME/.moc";
cp -r "$self/other/mocp/." "$HOME/.moc/.";

[ -d "$config/ncmpc" ] || mkdir -p "$config/ncmpc";
cp -r "$self/other/ncmpc/." "$config/ncmpc";

[ -d "$config/polybar" ] || mkdir -p "$config/polybar";
cp -r "$self/polybar/." "$config/polybar/.";

[ -d "$config/nvim" ] || mkdir -p "$config/nvim";
cp -r "$self/editor/nvim/." "$config/nvim/.";

[ -f "$HOME/.Xresources" ] && cp "$HOME/.Xresources" "$HOME/.Xresources.bak";
cp "$self/xresources/dot.Xresources" "$HOME/.Xresources";
[ -d "$config/xresources" ] || mkdir -p "$config/xresources";
cp -r "$self/xresources/xresources/." "$config/xresources/.";
[ -d "$config/xresources-colors" ] || mkdir -p "$config/xresources-colors";
cp -r "$self/xresources/xresources-colors/." "$config/xresources-colors/.";

[ -d "$HOME/.oh-my-zsh" ] && mv "$HOME/.oh-my-zsh/" "$share/oh-my-zsh";
[ -f "$HOME/.zshrc" ] && cp "$HOME/.zshrc" "$HOME/.zshrc.old";
cp "$self/zsh/dot.zshrc" "$HOME/.zshrc";
[ -d "$share/oh-my-zsh-custom" ] || mkdir -p "$share/oh-my-zsh-custom";
cp -r "$self/zsh/oh-my-zsh-custom/." "$share/oh-my-zsh-custom/."
set +x

echo -e "\e[31mMPD config change requires Superuser privileges, skipped."
echo -e "You can just run following if you want:";
echo -e "\e[34m $ sudo cp $self/other/mpd/mpd.conf /etc/mpd.conf\e[0m";

echo -e "\e[32m[*] Reloading X configuration...\e[0m";
xrdb $HOME/.Xresources;
echo -e "\e[32m[*] Refreshing XST windows...\e[0m"
killall -USR1 xst;
