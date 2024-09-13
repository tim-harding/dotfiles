# From https://github.com/pyenv/pyenv#set-up-your-shell-environment-for-pyenv
set --export PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin
pyenv init - | source
