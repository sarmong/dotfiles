ANSIBLE_PLAYBOOK = ansible/main.yml
ANSIBLE_CONFIG = ansible/ansible.cfg
ANSIBLE_LOG_PATH = log/ansible.log
ANSIBLE_CHECK_LOG_PATH = log/ansible-check.log

.PHONY: init ansible

init:
	@echo "Initializing submodules..."
	@git submodule init
	@git submodule update
	@echo "Done."

ansible:
	@mkdir -p logs
	ANSIBLE_CONFIG=$(ANSIBLE_CONFIG) ANSIBLE_LOG_PATH=$(ANSIBLE_LOG_PATH) ansible-playbook $(ANSIBLE_PLAYBOOK) --ask-become-pass

ansible-check:
	@mkdir -p logs
	ANSIBLE_CONFIG=$(ANSIBLE_CONFIG) ANSIBLE_LOG_PATH=$(ANSIBLE_CHECK_LOG_PATH) ansible-playbook $(ANSIBLE_PLAYBOOK) --ask-become-pass --check
