#!/bin/bash

OS=$(uname -s)

MAINPATH=$HOME/.wiki

init()
{
	if [[ -e $MAINPATH ]]; then rm -rf $MAINPATH; fi
	git clone https://github.com/goncharoman/wiki.git $MAINPATH

	if [[ "$os" == "Linux" ]]
	then
		su -c "ln -s $MAINPATH/wiki.sh /usr/local/bin/wiki"
	elif [[ "$os" == "Darwin" ]]
	then
		sudo "ln -s $MAINPATH/wiki.sh /usr/local/bin/wiki"
	fi
}

init
