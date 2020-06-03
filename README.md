# ansible-home

## get dependencies
```` bash
ansible-galaxy install -r requirements.yml -p roles --ignore-errors
````
## Clone repo
```` bash
git clone --recurse-submodules git@github.com:fablab-ka/ansible-flka.git
````
## list all available facts for a host
```` bash
ansible -m setup hostname
````
## run an playbook
```` bash
ansible-playbook --vault-password-file .vault_pass raspberry.yml -i hosts.yml
ansible-playbook --vault-password-file .vault_pass tasmota.yml -i hosts.yml
ansible-playbook --vault-password-file .vault_pass x86.yml -i hosts.yml
````
or use makefile
```` bash
make raspberry
make tasmota
make herbert
````

## shortcuts with vault passfile
first add to bashrc
```` bash
function avault() { ansible-vault "$1" --vault-password-file .vault_pass "$2";}
function aplaybook() { ansible-playbook --vault-password-file .vault_pass -i hosts.yml "$@";}
````
then just use
```` bash
avault edit secrets.yml
aplaybook tasmota.yml
````