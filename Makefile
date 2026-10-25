.PHONY: all provision stow shell dev desktop fonts verify update

all: provision

provision:
	./install.sh

stow:
	./install.sh 01-stow

shell:
	./install.sh 02-shell

dev:
	./install.sh 03-dev-tools

desktop:
	./install.sh 04-desktop

fonts:
	./install.sh 05-fonts

verify:
	./install.sh 06-verify

update:
	git pull
	./install.sh 01-stow
