bootstrap_ronin_gpu host tags="":
    {{ if tags == "" { "just _new_user {{ host }}" } else { "" } }}
    ansible-playbook ronin_gpu.yml -i {{ host }}, -K --ssh-common-args="-o ForwardAgent=yes" {{ if tags != "" { "--tags="+tags } else { "" } }} -v

_new_user host:
    ansible-galaxy install nvidia.nvidia_driver
    read -s -p "Password for new account: " password  && \
        ansible-playbook create_user.yml -i ubuntu@{{ host }}, --extra-vars '{"user_password": $password}'
