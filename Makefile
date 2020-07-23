tasmota:
	ansible-playbook --vault-password-file .vault_pass playbooks/tasmota.yml -i hosts.yml
raspberry:
	ansible-playbook --vault-password-file .vault_pass playbooks/raspberry.yml -i hosts.yml
herbert:
	ansible-playbook --vault-password-file .vault_pass playbooks/herbert.yml -i hosts.yml
git:
	ansible-playbook --vault-password-file .vault_pass playbooks/git-server.yml -i hosts.yml
mail:
	ansible-playbook --vault-password-file .vault_pass playbooks/mail-server.yml -i hosts.yml

copy_keys_to_storagebox:
	scp -P 23 roles/basic/users/public_keys/all_for_storagebox u220998@u220998.your-storagebox.de:.ssh/authorized_keys
