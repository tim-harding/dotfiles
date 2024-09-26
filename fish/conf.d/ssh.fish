switch (uname)
case Linux
    set IS_SSH_ADDED $(ps -ef | rg 'ssh-agent' | rg -v 'rg' | wc -l)
    if test $IS_SSH_ADDED -eq 0
        fish_ssh_agent
    end
end

ssh-add -l | count | read COUNT
if test $COUNT -eq 0
    switch (uname)
    case Linux
        ssh-add
    case Darwin
        ssh-add --apple-use-keychain ~/.ssh/id_ed25519
    end
end
