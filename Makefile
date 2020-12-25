all: bootstrap

bootstrap:
	sudo apt -y install ansible

provision:
	ansible-playbook -i ./hosts playbook.yml

test:
	vagrant up --provision
