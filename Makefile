all: bootstrap

bootstrap:
	sudo apt install ansible

provision:
	ansible-playbook playbook.yml

test:
	vagrant up --provision
