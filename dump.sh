#!/bin/bash
self="$(realpath "$(dirname $0)")";
config="${XDG_CONFIG_HOME:-$HOME/.config}";
share="${XDG_SHARED:-$HOME/.local/share}"

cp -r "$config/i3/." "$self/i3/.";
cp -r "$HOME/.moc/." "$self/other/mocp/.";
cp -r "$config/ncmpc/." "$self/other/ncmpc/.";
cp -r "$config/polybar/." "$self/polybar/.";
cp -r "$config/dunst/." "$self/dunst/.";
cp -r "$config/rofi/." "$self/rofi/.";
cp -r "$config/nvim/." "$self/editor/nvim/.";
cp "$HOME/.Xresources" "$self/xresources/dot.Xresources";
cp -r "$config/xresources/." "$self/xresources/xresources/.";
cp -r "$config/xresources-colors/." "$self/xresources/xresources-colors/.";
cp "$HOME/.zshrc" "$self/zsh/dot.zshrc";
cp -r "$share/oh-my-zsh-custom/." "$self/zsh/oh-my-zsh-custom/.";
echo -e "\e[31m[!] Edit $self/zsh/oh-my-zsh-custom/extras/environ !\e[0m";
cp /etc/mpd.conf $self/other/mpd/mpd.conf;
rm "$self/editor/nvim/.netrwhist";
read -p "Press for screenshot ..."; scrot ./scrot.png
