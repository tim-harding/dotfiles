switch (uname)
case Linux
fish_ssh_agent
end

set IS_SSH_ADDED $(ps -ef | rg 'ssh-agent' | rg -v 'rg' | wc -l)
if test $IS_SSH_ADDED -eq 0
    ssh-add
end

if test -z "$SSH_ENV"
    set -xg SSH_ENV $HOME/.ssh/environment
end

if not __ssh_agent_is_started
    __ssh_agent_start
end
