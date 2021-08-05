_default:
    @just --list

all host: (new-user host) (bootstrap_ronin_gpu host)

bootstrap_ronin_gpu host tags="":
    ansible-galaxy install nvidia.nvidia_driver
    ansible-playbook ronin_gpu.yml -i {{ host }}, -K --ssh-common-args="-o ForwardAgent=yes" {{ if tags != "" { "--tags="+tags } else { "" } }} -v

new-user host:
    #!/usr/bin/env bash
    ansible galaxy install ansible.posix
    read -s -p "Password for new account: " password  && \
        ansible-playbook create_user.yml -i ubuntu@{{ host }}, --extra-vars '{"user_password": $password}'

# vim: set ft=just:
