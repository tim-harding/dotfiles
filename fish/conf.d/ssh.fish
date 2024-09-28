switch (uname)
case Linux
    set IS_SSH_ACTIVE $(ps -ef | rg 'ssh-agent' | rg -v 'rg' | wc -l)
    if test $IS_SSH_ACTIVE -eq 0
        fish_ssh_agent
    end
end

if test $(ssh-add -l) = "The agent has no identities."
    switch (uname)
    case Linux
        ssh-add
    case Darwin
        ssh-add --apple-use-keychain ~/.ssh/id_ed25519
    end
end
