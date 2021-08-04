bootstrap_ronin_gpu host tags="":
    ansible-galaxy install nvidia.nvidia_driver
    read -s -p "Password for new account: " password  && \
        ansible-playbook create_user.yml -i ubuntu@{{ host }}, --extra-vars '{"user_password": "${password}"}'
    ansible-playbook ronin_gpu.yml -i {{ host }}, -K --ssh-common-args="-o ForwardAgent=yes" {{ if tags != "" { "--tags="+tags } else { "" } }}
