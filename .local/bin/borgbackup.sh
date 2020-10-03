#!/bin/sh

export BORG_REPO=/mnt/backup

export BORG_PASSCOMMAND="gpg --decrypt $HOME/.local/bin/passphrase.txt.gpg"

borg create                                      \
        --stats --progress $2 $1                 \
        -e 'sh:**/.*'                            \
        -e 'sh:**/*.iso'                         \
        -e 'sh:**/*.db'                          \
        -e 'sh:**/*.tar'                         \
        -e 'sh:**/*.tar.gz'                      \
        -e 'sh:**/*.tgz'                         \
        -e 'sh:**/*.zip'                         \
        -e '*/Downloads'                         \
        -e '*/Documents/Zoom'                    \
        -e '*/R/x86_64-pc-linux-gnu-library'     \
        -e '*/code/google-cloud-sdk'             \
        -e '*/code/gcloud'                       \
        -e '*/code/python-virtual-evironments'   \
        -e '*/README.md'                         \
        -e '*/LICENSE'                           \
        --exclude-if-present '.git'              \
        ::"$HOSTNAME--$(date +%+4Y-%m-%d)"       \
        "$HOME"

backup_exit=$?

info "Pruning repository"

# Use the `prune` subcommand to maintain 7 daily, 4 weekly and 6 monthly
# archives of THIS machine. The '{hostname}-' prefix is very important to
# limit prune's operation to this machine's archives and not apply to
# other machines' archives also:

borg prune                          \
    --list                          \
    --prefix "$HOSTNAME"            \
    --show-rc                       \
    --keep-daily    7               \
    --keep-weekly   4               \
    --keep-monthly  6

prune_exit=$?

# use highest exit code as global exit code
global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))

if [[ ${global_exit} -eq 0 ]]; then
        info "Backup and Prune finished successfully"
elif [[ ${global_exit} -eq 1 ]]; then
        info "Backup and/or Prune finished with warnings"
else
        info "Backup and/or Prune finished with errors"
fi

exit ${global_exit}