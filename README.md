# ansible-home

## general

```` bash
# get dependencies
ansible-galaxy install -r requirements.yml -p roles --ignore-errors

# Clone repo
git clone --recurse-submodules git@github.com:fablab-ka/ansible-flka.git

# list all available facts for a host
ansible -m setup hostname

# run an playbook
ansible-playbook gpu-system.yml -i hosts

````