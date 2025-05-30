# bindkey -v '^?' vi-backward-delete-char
#
# # key bindings
# bindkey "e[1~" beginning-of-line
# bindkey "e[4~" end-of-line
# bindkey "e[5~" beginning-of-history
# bindkey "e[6~" end-of-history
# bindkey "e[3~" delete-char
# bindkey "e[2~" quoted-insert
# bindkey "e[5C" forward-word
# bindkey "eOc" emacs-forward-word
# bindkey "e[5D" backward-word
# bindkey "eOd" emacs-backward-word
# bindkey "ee[C" forward-word
# bindkey "ee[D" backward-word
# bindkey "^H" backward-delete-word
# # for rxvt
# bindkey "e[8~" end-of-line
# bindkey "e[7~" beginning-of-line
# # for non RH/Debian xterm, can't hurt for RH/DEbian xterm
# bindkey "eOH" beginning-of-line
# bindkey "eOF" end-of-line
# # for freebsd console
# bindkey "e[H" beginning-of-line
# bindkey "e[F" end-of-line
# # completion in the middle of a line
# bindkey '^i' expand-or-complete-prefix

# Dont want Vi mode
bindkey -e

# Delete till / or word
backward-kill-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    zle backward-kill-word
    zle -f kill
}
zle -N backward-kill-dir
bindkey '^[^?' backward-kill-dir

bindkey "^[[H"   beginning-of-line
bindkey "^[[F"   end-of-line
bindkey "^[[3~"  delete-char
bindkey "^W"     kill-whole-line
bindkey "^U"     autosuggest-accept
