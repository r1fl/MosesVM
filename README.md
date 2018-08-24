# MosheVM

This is an attempt to provide a secure sandbox for researching executables safetly and easily.

## Installation

1. Install a hypervisor. The following hypervisors are supported:
	- VirtualBox (default, recommended)
2. Install Vagrant:
	- OSX: ``brew cask install vagrant``
	- Linux: ``sudo pacman -S vagrant``
3. Clone this project and ``cd`` to clone dir.
4. Build VM and provision:
	- If using VirtualBox: ``vagrant up``

### Note

Vagrant installation on Linux may vary between distributions, please refeer to the [docs](https://www.vagrantup.com/docs/installation/) for father detail.

## Usage

``vagrant ssh``

## Includes

- GDB pwndbg
- pwntools
- radare2
- tmux, vim
