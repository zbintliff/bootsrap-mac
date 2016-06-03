SHELL := /bin/bash

# Tool Paths
BREW := $(shell which brew || echo /usr/local/bin/brew)
ANSIBLE := $(shell which ansible || echo /usr/local/bin/ansible)
RBENV := $(shell which rbenv || echo /usr/local/bin/rbenv)
RBENV_VERSIONS := $(HOME)/.rbenv/versions/2.2.5

# Tool Installs
tools: $(ANSIBLE)
$(BREW):
	/usr/bin/ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

$(ANSIBLE): $(BREW)
	brew install ansible

tools all: $(BREW) $(ANSIBLE)
	git pull
	ansible-playbook -vD -i playbooks/hosts playbooks/osx.yml
	rbenv install 2.2.5
	RBENV_VERSION=2.2.5 ~/.rbenv/shims/gem install --no-document bundler:1.10.5

# Debug (make print-YOUR_VARIABLE to see values)
print-%: ; @echo $*=$($*)
