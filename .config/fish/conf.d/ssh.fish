switch (uname)
    case Darwin
        if not ssh-add -l >/dev/null
            ssh-add --apple-use-keychain ~/.ssh/id_ed25519
        end
end
