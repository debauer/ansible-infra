tasmota:
	ansible-playbook --vault-password-file .vault_pass tasmota.yml -i hosts.yml
raspberry:
	ansible-playbook --vault-password-file .vault_pass raspberry.yml -i hosts.yml
server:
	ansible-playbook --vault-password-file .vault_pass server.yml -i hosts.yml