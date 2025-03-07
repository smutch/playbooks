_default:
    @just --list --list-heading $'Ansible bootstrap tasks\n-----------------------\n\n'

standard host: (new-user host) (bootstrap-dev host)

new-user host:
    #!/usr/bin/env bash
    ansible-galaxy collection install ansible.posix
    read -s -p "Password for new account: " password  && \
        ansible-playbook create_user.yml -i ubuntu@{{ host }}, --extra-vars "{'user_password': "$password"}"

bootstrap-dev host extra-vars="":
    ansible-playbook dev.yml -k -K -i {{ host }}, --ssh-common-args='-o ForwardAgent=yes' --extra-vars "{{ extra-vars }}"

bootstrap-ronin-gpu host tags="" extra-vars="":
    ansible-galaxy install nvidia.nvidia_driver
    ansible-playbook ronin_gpu.yml -i {{ host }}, -K --ssh-common-args="-o ForwardAgent=yes" {{ if tags != "" { "--tags="+tags } else { "" } }}

# vim: set ft=just:
