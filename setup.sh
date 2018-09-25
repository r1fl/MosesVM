#!/bin/bash

# === CONSTANTS ===

HOME="/home/vagrant"
INSTALLDIR="/usr/local"

ONLOGIN="gdb"
PYTHONVER="2"

# === EVENT FUNCTIONS ===

START_HOOK () {
	export HOME
	cd $INSTALLDIR
}

FINISH_HOOK () {
	# login shell
	echo 'if [ $(pgrep -c '$ONLOGIN') -eq 0 ]; then '$ONLOGIN'; logout; fi' >> $HOME/.bashrc
	chown vagrant: $HOME/.bashrc

	# python version
	ln -sf "/usr/bin/python$PYTHONVER" "/usr/bin/python"
	ln -sf "/usr/bin/pip$PYTHONVER" "/usr/bin/pip"

	# gdb init
	cp -f /vagrant/gdbinit $HOME/.gdbinit
}

START_HOOK

# == 32 bit ===

dpkg --add-architecture i386 

apt-get update -y
apt-get upgrade -y
apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386

# === TOOLS ===

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
	sed -i -e 's/ENUM_P_TYPE/ENUM_P_TYPE_BASE/g' '/usr/local/lib/python2.7/dist-packages/pwnlib/elf/elf.py'
else
	git clone https://github.com/arthaud/python3-pwntools
	python3 -m pip install ./python3-pwntools
	rm -rf ./python3-pwntools
fi

FINISH_HOOK
