_default:
    @just --list --list-heading $'Ansible bootstrap tasks\n-----------------------\n\n'

all host: (new-user host) (bootstrap-ronin-gpu host)

bootstrap-ronin-gpu host tags="":
    ansible-galaxy install nvidia.nvidia_driver
    ansible-playbook ronin_gpu.yml -i {{ host }}, -K --ssh-common-args="-o ForwardAgent=yes" {{ if tags != "" { "--tags="+tags } else { "" } }}

new-user host:
    #!/usr/bin/env bash
    ansible-galaxy collection install ansible.posix
    read -s -p "Password for new account: " password  && \
        ansible-playbook create_user.yml -i ubuntu@{{ host }}, --extra-vars "{'user_password': "$password"}"

# vim: set ft=just:
