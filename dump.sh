#!/bin/sh
self="$(realpath "$(dirname $0)")";
config="${XDG_CONFIG_HOME:-$HOME/.config}";
share="${XDG_SHARED:-$HOME/.local/share}"

cp -vr "$config/i3/." "$self/i3/.";
# cp -r "$HOME/.moc/." "$self/other/mocp/.";
cp -vr "$config/ncmpc/." "$self/other/ncmpc/.";
cp -vr "$config/polybar/." "$self/polybar/.";
cp -vr "$config/dunst/." "$self/dunst/.";
cp -vr "$config/nvim/." "$self/editor/nvim/.";
cp -v "$HOME/.Xresources" "$self/xresources/dot.Xresources";
cp -vr "$config/xresources/." "$self/xresources/xresources/.";
cp -vr "$config/xresources-colors/." "$self/xresources/xresources-colors/.";
cp -v "$HOME/.zshrc" "$self/zsh/dot.zshrc";
cp -vr "$share/oh-my-zsh-custom/." "$self/zsh/oh-my-zsh-custom/.";
cp -v "/etc/mpd.conf" "$self/other/mpd/mpd.conf";
cp -v "$HOME/.tmux.conf" "$self/other/tmux.conf";
rm -v "$self/editor/nvim/.netrwhist";
read -p "Press enter for screenshot ...";
clear;
neofetch || true;
notify-send --icon starred \
            --app-name ".files" \
            "Dotfiles from github.com/hatkidchan" \
            "<s>Bloooat</s>";
scrot -z ./scrot.png -a 0,0,1024,600;
