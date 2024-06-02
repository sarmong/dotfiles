ANSIBLE_PLAYBOOK = ansible/main.yml
ANSIBLE_CONFIG_FILE = ansible/ansible.cfg

.PHONY: init ansible

init:
	@echo "Initializing submodules..."
	@git submodule init
	@git submodule update
	@echo "Done."

ansible:
	ANSIBLE_CONFIG=$(ANSIBLE_CONFIG_FILE) ansible-playbook $(ANSIBLE_PLAYBOOK) --ask-become-pass $(ANSIBLE_ARGS)

ansible-check:
	ANSIBLE_CONFIG=$(ANSIBLE_CONFIG_FILE) ansible-playbook $(ANSIBLE_PLAYBOOK) --ask-become-pass --check
