# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi


. $(dirname `readlink -f $0`)/common.sh


