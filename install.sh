#!/bin/bash
self="$(realpath "$(dirname $0)")";
usage() {
    echo -e "Usage: $0 [-hyrN] [-c a] [-l a] [-p a] [-s a] [-n a] [-I a]
Arguments:
    -h            show this help
    -y            force installation (no questions)
    -r            no reloading configs
    -n <entry>    skip installation of <entry>
    -N            clean installation list (may be useful with -I)
    -I <entry>    add entry to installation list
    -c <config>   path to ~/.config (default to XDG_CONFIG_HOME or ~/.config)
    -l <.local>   path to ~/.local (default to XDG_SHARED or ~/.local/share)
    -p <monitor>  primary monitor name (from xrandr)
    -s <monitor>  secondary monitor name (from xrandr)

Available entries:
    ${!install_entries[@]}" 1>&2;
    exit 1;
}

config="${XDG_CONFIG_HOME:-$HOME/.config}";
share="${XDG_SHARED:-$HOME/.local/share}"
no_questions="";
no_reload_config="";
default_primary_monitor="";
default_secondary_monitor="";
declare -A install_entries=(
    [bin]=yes
    [i3]=yes
    [mocp]=yes
    [ncmpc]=yes
    [polybar]=yes
    [dunst]=yes
    [nvim]=yes
    [xresources]=yes
    [zsh]=yes,
    [tmux]=yes,
    [mpd]=no,
    [xkb]=yes,
);


while getopts "hryNc:l:p:s:n:I:" k; do
    case "$k" in
        h) usage;;
        y) no_questions="yes";;
        r) no_reload_config="yes";;
        c) config="${OPTARG}";;
        l) share="${OPTARG}";;
        n) install_entries["${OPTARG}"]="no";;
        N) declare -A install_entries=() ;;
        I) install_entries["${OPTARG}"]="yes";;
        p) default_primary_monitor="${OPTARG}";;
        s) default_secondary_monitor="${OPTARG}";;
        *) usage;;
    esac;
done



if [[ "$no_questions" == "yes" ]]; then
    echo -e "\e[31m[*] Forced installation\e[0m";
else
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
fi;


if [[ "${install_entries[i3]}" == "yes" ]]; then
    echo -e "\e[32m[*] Guessing displays...\e[0m";
    PRIMARY_DISPLAY="$default_primary_monitor";
    SECONDARY_DISPLAY="$default_secondary_monitor";
    while true; do
        b=$(printf "\e[34m");
        y=$(printf "\e[33m");
        g=$(printf "\e[32m");
        p=$(printf "\e[36m");
        n=$(printf "\e[0m");

        if [[ "$no_questions" == "" ]]; then
            echo -e "$y[I] $b DISPLAY     $g CONNECTED $p RESOLUTION";
            echo -e "$y[I] ------------ ----------- ----------\e[0m";
            xrandr | grep -P '^[A-Z]{2,}' | while read info; do
                name=$(echo $info | awk '{print$1}')
                connected=$(echo $info | grep -oP '\bconnected\b');
                size=$(echo $info | grep -oP '\d+x\d+');
                if [[ "$connected" == "connected" ]]; then
                    sta_color=32;
                else
                    sta_color=31;
                    connected=" no data ";
                fi;
                printf "$y[I] [$b%-10s$y] (\e[%sm%9s$y) $p%s$n\n" \
                       "$name" "$sta_color" "$connected" "$size";
            done;
        fi;

        G_MON0=$(xrandr|grep primary|awk '{print$1}');
        G_MON1=$(xrandr|grep -oP '^[A-Z\d]{2,}'|grep -v $G_MON0 |head -n1);
        if [[ "$no_questions" == "yes" ]]; then
            PRIMARY_DISPLAY="${PRIMARY_DISPLAY:-$G_MON0}"
            SECONDARY_DISPLAY="${SECONDARY_DISPLAY:-$G_MON1}"
            echo -e "\e[32m[*] Primary display  : $PRIMARY_DISPLAY\e[0m";
            echo -e "\e[32m[*] Secondary display: $SECONDARY_DISPLAY\e[0m";
            break;
        fi;
        G_MON0="${default_primary_monitor:-$G_MON0}";
        G_MON1="${default_secondary_monitor:-$G_MON1}";
        read -p "$b[I]   Primary display $y[$G_MON0]: $n" _PRIMARY_DISPLAY;
        read -p "$b[I] Secondary display $y[$G_MON1]: $n" _SECONDARY_DISPLAY;
        PRIMARY_DISPLAY=${_PRIMARY_DISPLAY:-$G_MON0};
        SECONDARY_DISPLAY=${_SECONDARY_DISPLAY:-$G_MON1};
        echo -e "\e[32m[*] Primary display  : $PRIMARY_DISPLAY\e[0m";
        echo -e "\e[32m[*] Secondary display: $SECONDARY_DISPLAY\e[0m";
        echo -ne "\e[33m[?] All correct? [yNq]: \e[0m"; read -n1; echo
        case "$REPLY" in
            y) break;;
            Y) break;;
            q) exit 1;;
            Q) exit 1;;
            *) echo -e "\e[31m[*] Retrying...\e[0m";;
        esac;
    done;
fi;

echo -e "\e[32m[*] Creating folders...\e[0m";
[ -d "$config" ] || mkdir -p "$config";
[ -d "$HOME/.local/bin" ] || mkdir -p "$HOME/.local/bin";
[ -d "$share" ] || mkdir -p "$share";

echo -e "\e[32m[*] Installing dotfiles...\e[0m";

if [[ "${install_entries[bin]}" == "yes" ]]; then
    echo -e "\e[32m[*] Installing userscripts\e[0m";
    cp -r "$self/bin/." "$HOME/.local/bin/.";
fi;

if [[ "${install_entries[i3]}" == "yes" ]]; then
    echo -e "\e[32m[*] Installing i3 config\e[0m";
    [ -d "$config/i3" ] || mkdir -p "$config/i3";
    cp -r "$self/i3/." "$config/i3/.";
    sed -i.bak "s/LVDS1/$PRIMARY_DISPLAY/g" "$config/i3/autostart.sh";
    sed -i.bak "s/VGA1/$SECONDARY_DISPLAY/g" "$config/i3/autostart.sh";
fi;

if [[ "${install_entries[moc]}" == "yes" ]]; then
    echo -e "\e[32m[*] Installing moc config\e[0m";
    [ -d "$HOME/.moc" ] || mkdir -p "$HOME/.moc";
    cp -r "$self/other/mocp/." "$HOME/.moc/.";
fi;

if [[ "${install_entries[ncmpc]}" == "yes" ]]; then
    echo -e "\e[32m[*] Installing ncmpc config\e[0m";
    [ -d "$config/ncmpc" ] || mkdir -p "$config/ncmpc";
    cp -r "$self/other/ncmpc/." "$config/ncmpc";
fi;

if [[ "${install_entries[polybar]}" == "yes" ]]; then
    echo -e "\e[32m[*] Installing polybar config\e[0m";
    [ -d "$config/polybar" ] || mkdir -p "$config/polybar";
    cp -r "$self/polybar/." "$config/polybar/.";
fi;

if [[ "${install_entries[dunst]}" == "yes" ]]; then
    echo -e "\e[32m[*] Installing dunst config\e[0m";
    [ -d "$config/dunst" ] || mkdir -p "$config/dunst";
    cp -r "$self/dunst/." "$config/dunst/.";
fi;

if [[ "${install_entries[nvim]}" == "yes" ]]; then
    echo -e "\e[32m[*] Installing nvim config\e[0m";
    [ -d "$config/nvim" ] || mkdir -p "$config/nvim";
    cp -r "$self/editor/nvim/." "$config/nvim/.";
fi;

if [[ "${install_entries[xresources]}" == "yes" ]]; then
    echo -e "\e[32m[*] Installing xresources config\e[0m";
    [ -f "$HOME/.Xresources" ] && cp "$HOME/.Xresources" "$HOME/old.Xresources";
    cp "$self/xresources/dot.Xresources" "$HOME/.Xresources";
    [ -d "$config/xresources" ] || mkdir -p "$config/xresources";
    cp -r "$self/xresources/xresources/." "$config/xresources/.";
    [ -d "$config/xresources-colors" ] || mkdir -p "$config/xresources-colors";
    cp -r "$self/xresources/xresources-colors/." "$config/xresources-colors/.";
fi;


if [[ "${install_entries[zsh]}" == "yes" ]]; then
    echo -e "\e[32m[*] Installing keyboard mapping\e[0m";
    cp "$self/other/xkb" "$share/xkb.conf";
fi;

if [[ "${install_entries[zsh]}" == "yes" ]]; then
    echo -e "\e[32m[*] Installing zsh config\e[0m";
    [ -d "$HOME/.oh-my-zsh" ] && mv "$HOME/.oh-my-zsh/" "$share/oh-my-zsh";
    [ -f "$HOME/.zshrc" ] && cp "$HOME/.zshrc" "$HOME/.zshrc.old";
    cp "$self/zsh/dot.zshrc" "$HOME/.zshrc";
    [ -d "$share/oh-my-zsh-custom" ] || mkdir -p "$share/oh-my-zsh-custom";
    cp -ur "$self/zsh/oh-my-zsh-custom/." "$share/oh-my-zsh-custom/."
fi;


if [[ "${install_entries[tmux]}" == "yes" ]]; then
    echo -e "\e[32m[*] Installing tmux.conf\e[0m";
    [ -f "$HOME/.tmux.conf" ] && cp "$HOME/.tmux.conf" "$HOME/.tmux.conf.bak";
    cp "$self/other/tmux.conf" "$HOME/.tmux.conf";
fi;

if [[ "${install_entries[mpd]}" == "yes" ]]; then
    echo -e "\e[32m[*] Installing mpd config\e[0m";
    sudo cp -v "/etc/mpd.conf" "/etc/mpd.conf.old";
    sudo cp -v "$self/other/mpd/mpd.conf" "/etc/mpd.conf";
else
    if [[ "${install_entries[mpd]}" == "no" ]]; then
        echo -e "\e[31m[!] MPD config change requires sudo, skipped."
        echo -e "[!] You can just run following if you want:";
        echo -e "[!] \e[34m# cp $self/other/mpd/mpd.conf /etc/mpd.conf\e[0m";
    fi;
fi;

if [[ "$no_reload_config" == "" ]]; then
    echo -e "\e[32m[*] Reloading X configuration...\e[0m";
    xrdb $HOME/.Xresources;
    echo -e "\e[32m[*] Refreshing XST windows...\e[0m"
    killall -USR1 xst; sleep 1;
    echo -e "\e[32m[*] Reloading i3 confiuration...\e[0m"
    i3-msg reload;
    echo -e "\e[32m[*] Restarting dunst...\e[0m"
    killall -9 dunst; dunst & disown;
fi;
echo -e "\e[32m[I] Done!\e[0m"
