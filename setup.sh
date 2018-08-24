#!/bin/bash

# === CONSTANTS ===

HOME="/home/vagrant"
INSTALLDIR="/usr/local"

ONLOGIN="gdb; logout"
PYTHONVER="3"

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
}

START_HOOK

# === TOOLS ===

apt-get update

apt-get install -y gcc
apt-get install -y gdb
apt-get install -y radare2 

# pwndbg
apt-get install -y git
git clone https://github.com/pwndbg/pwndbg; cd pwndbg; ./setup.sh; cd .. 

# pwntools
pip2 install --upgrade pwntools
#pip3 install --upgrade git+https://github.com/arthaud/python3-pwntools.git

FINISH_HOOK
