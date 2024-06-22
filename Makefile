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

update:
	git stash
	git pull
	make ansible

ansible:
	@scripts/ansible.sh

ansible-check:
	@scripts/ansible.sh --check
