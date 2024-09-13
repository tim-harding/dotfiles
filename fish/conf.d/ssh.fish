fish_ssh_agent

set IS_SSH_ADDED $(ps -ef | rg 'ssh-agent' | rg -v 'rg' | wc -l)
if test $IS_SSH_ADDED -eq 0
    ssh-add
end
