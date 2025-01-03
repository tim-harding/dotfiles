switch $platform
    case Linux
        set -x SSH_AGENT_PID ""
        set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh
    case Darwin
        if not ssh-add -l >/dev/null
            ssh-add --apple-use-keychain ~/.ssh/id_ed25519
        end
end
