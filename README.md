# Linux Setup

## SSH KEYS
```bash
# generate key
# and save as /home/user/.ssh/hostname_ed25519 (has to be absolute path)
ssh-keygen -t ed25519 -C "user@hostname.local"

# print pub key
cat /home/user/.ssh/hostname_ed25519.pub

# ssh config: ~/.ssh/config
# Host github.com
#   HostName github.com # this is the important part
#   User git
#   IdentityFile ~/.ssh/hostname_ed25519
#   IdentitiesOnly yes
```
