#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

BROWSER=/usr/bin/chromium
EDITOR=/usr/bin/nano

function _update_ps1() {
    PS1="$(powerline-go \
        -error $? \
        -newline \
        -path-aliases \~/src/github.com/xillio=Xillio,\~/src/github.com/chappio=ChappIO \
        -modules venv,user,cwd,git
    )"
}

if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1; ${PROMPT_COMMAND}"
fi

# GO
export GOPATH="${HOME}"
PATH="${PATH}:${GOPATH}/bin"

# NPM
export NPM_PACKAGES="${HOME}/.npm-packages"
PATH="${PATH}:${NPM_PACKAGES}/bin:node_modules/.bin"
unset MANPATH
export MANPATH="${NPM_PACKAGES}/share/man:$(manpath)"

# MC AGENT
if ! pgrep -u "${USER}" mc-agent > /dev/null; then
    mc-agent > ~/.mc-agent-env
fi
if [[ "${SSH_AUTH_SOCK}" == "" ]]; then
    eval "$(<~/.mc-agent-env)"
fi

# FUCK
eval $(thefuck --alias)

# PATH
export CDPATH=".:${HOME}:${GOPATH}/src/github.com"
export PATH="${PATH}:$(find /opt -maxdepth 2 -name bin | paste -sd ':' -):${HOME}/.gem/ruby/2.5.0/bin"

