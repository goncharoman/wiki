#!/bin/bash

OS=$(uname -s)

MAINPATH=$HOME/.wiki

init()
{
	if [[ -e $MAINPATH ]]; then rm -rf $MAINPATH; fi
	git clone https://github.com/goncharoman/wiki.git $MAINPATH

	if [[ "$OS" == "Linux" ]]
	then
		su -c "ln -s $MAINPATH/wiki.sh /usr/local/bin/wiki"
	elif [[ "$OS" == "Darwin" ]]
	then
		sudo "ln -s $MAINPATH/wiki.sh /usr/local/bin/wiki"
	fi
}

init
