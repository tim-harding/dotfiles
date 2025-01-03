switch $platform
    case Linux
        # One-time setup:
        # systemctl --user enable ssh-agent
        set -e SSH_AGENT_PID
        set -xg SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket

        # To run an agent per login shell:
        #
        # ssh-agent -c | fish 
        ### or ###
        # fish_ssh_agent

        # To use GnuPG SSH agent:
        #
        # set -e SSH_AGENT_PID
        # set -xg SSH_AUTH_SOCK $XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh

    case Darwin
        if not ssh-add -l >/dev/null
            ssh-add --apple-use-keychain ~/.ssh/id_ed25519
        end
end
