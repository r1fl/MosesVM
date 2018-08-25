#!/bin/bash

# === CONSTANTS ===

HOME="/home/vagrant"
INSTALLDIR="/usr/local"

ONLOGIN="gdb; logout"
PYTHONVER="2"

# === EVENT FUNCTIONS ===

START_HOOK () {
	export HOME
	cd $INSTALLDIR
}

FINISH_HOOK () {
	# login shell
	echo 'if [ $(pgrep -c '$ONLOGIN') -eq 0 ]; then '$ONLOGIN'; fi' >> $HOME/.bashrc
	chown vagrant: $HOME/.bashrc

	# python version
	ln -sf "/usr/bin/python$PYTHONVER" "/usr/bin/python"
	ln -sf "/usr/bin/pip$PYTHONVER" "/usr/bin/pip"

	# gdb init
	cp -f /vagrant/gdbinit $HOME/.gdbinit
}

START_HOOK

# === TOOLS ===

apt-get update

apt-get install -y gcc
apt-get install -y gdb
apt-get install -y radare2
apt-get install -y tmux
apt-get install -y git

if [ $PYTHONVER -eq "2" ]; then apt-get install -y ipython
else apt-get install -y ipython$PYTHONVER; fi

# pwndbg
git clone https://github.com/pwndbg/pwndbg; cd pwndbg; ./setup.sh; cd .. 

# peda
git clone https://github.com/longld/peda

# pwntools
if [ $PYTHONVER -eq "2" ]; then
	pip2 install --upgrade pwntools
else
	git clone https://github.com/arthaud/python3-pwntools
	python3 -m pip install ./python3-pwntools
	rm -rf ./python3-pwntools
fi

FINISH_HOOK
