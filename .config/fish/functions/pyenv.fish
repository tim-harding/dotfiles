# https://github.com/pyenv/pyenv#set-up-your-shell-environment-for-pyenv
# https://github.com/pyenv/pyenv/issues/32#issuecomment-21019171
set --export PYENV_ROOT $HOME/.pyenv
fish_add_path --global $PYENV_ROOT/bin
fish_add_path --global $PYENV_ROOT/shims
if command -q pyenv
    pyenv rehash
    pyenv init - | source
end
