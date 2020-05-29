export PATH="$HOME/bin:/usr/bin:$PATH:$HOME/.local/bin:/usr/local/bin:/bin/snap:/usr/local/go/bin";
export ZSH="$HOME/.local/share/oh-my-zsh"
ZSH_CUSTOM="${ZSH}-custom"
if [ -z "$ZSH_THEME" ]; then ZSH_THEME="uv"; fi
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="false"
DISABLE_AUTO_UPDATE="false"
export UPDATE_ZSH_DAYS=13
DISABLE_LS_COLORS="false"
DISABLE_AUTO_TITLE="false"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd"

# duh
plugins=(sudo git httpie python autopep8 screen extract cp virtualenv)
[ -e "$ZSH_CUSTOM/extras/environ" ] && . "$ZSH_CUSTOM/extras/environ"
[ -e "$ZSH_CUSTOM/extras/aliases" ] && . "$ZSH_CUSTOM/extras/aliases"
[ -e "$ZSH_CUSTOM/extras/functions" ] && . "$ZSH_CUSTOM/extras/functions"

source $ZSH/oh-my-zsh.sh
export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8
export EDITOR='vi'
export ARCHFLAGS="-arch i686"
export SSH_KEY_PATH="$HOME/.ssh/id_rsa"
export PYTHONPATH="/usr/share"

