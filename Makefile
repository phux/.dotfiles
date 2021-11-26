all: bootstrap

bootstrap:
	sudo apt -y install ansible

provision:
	ansible-playbook -i ./hosts playbook.yml -e ansible_python_interpreter=/usr/bin/python3

test:
	vagrant up --provision
