_default:
    @just --list --list-heading $'Ansible bootstrap tasks\n-----------------------\n\n'

standard host: (new-user host) (dev host)

new-user host:
    #!/usr/bin/env bash
    ansible-galaxy collection install ansible.posix
    read -s -p "Password for new account: " password  && \
        ansible-playbook create_user.yml -i ubuntu@{{ host }}, --extra-vars "{'user_password': "$password"}"

bootstrap-dev host:
    ansible-playbook dev.yml -K -i {{ host }}, --ssh-common-args='-o ForwardAgent=yes'

bootstrap-ronin-gpu host tags="":
    ansible-galaxy install nvidia.nvidia_driver
    ansible-playbook ronin_gpu.yml -i {{ host }}, -K --ssh-common-args="-o ForwardAgent=yes" {{ if tags != "" { "--tags="+tags } else { "" } }}

# vim: set ft=just:
