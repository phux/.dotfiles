.PHONY: all provision update-versions

all: provision

provision:
	./install.sh

update-versions:
	./scripts/update-versions.sh
