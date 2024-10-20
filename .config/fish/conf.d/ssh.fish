switch (uname)
case Linux
    if test (tty) != /dev/tty1
        # set --erase SSH_AGENT_PID
        # set SSH_AUTH_SOCK "$(gpgconf --list-dirs agent-ssh-socket)"
        # set GPG_TTY "$(tty)"
        # gpg-connect-agent updatestartuptty /bye >/dev/null
    end
case Darwin
    if not ssh-add -l > /dev/null
        ssh-add --apple-use-keychain ~/.ssh/id_ed25519
    end
end
