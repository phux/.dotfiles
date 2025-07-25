all: bootstrap

bootstrap:
	ansible-galaxy collection install community.crypto
	# ansible-galaxy collection install community.general
	sudo apt update
	sudo apt install software-properties-common
	sudo add-apt-repository --yes --update ppa:ansible/ansible
	sudo apt install ansible

update-versions:
	./scripts/update-versions.sh

provision:
	# ansible-playbook -i ./hosts playbook.yml -e ansible_python_interpreter=/usr/bin/python3 --tags="tf"
	ansible-playbook -i ./hosts playbook.yml -e ansible_python_interpreter=/usr/bin/python3
