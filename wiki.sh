#!/bin/bash

MAINDIR=$HOME/.wiki

init()
{
	git clone https://github.com/goncharoman/wiki.git $MAINDIR
	ln -s $MAINDIR/wiki.sh /usr/local/bin/wiki
}

query()
{
	case $2 in
		p) python3 $MAINDIR/main.py $1 | "$PAGER";;
		a) python3 $MAINDIR/main.py $1 ;;
		*) python3 $MAINDIR/main.py $1 | head -n 1 ;;
	esac
}

error_fora()
{
	echo "illegal options"
	exit
}

if [[ ! -e "$MAINDIR" ]]
then
	init
fi

option=''

if [[ "$1" =~ ^- ]]
then
	case $1 in
		-f)
			if [[ -z $FORA ]]; then option='f'; else error_fora;fi
			;;
		-a)
			if [[ -z $FORA ]]; then option='a'; else error_fora;fi
			;;
		-p)
			if [[ -z $FORA ]]; then option='p'; else error_fora;fi
			;;
		*)
			echo "usage $0"
			;;
	esac
shift
fi

query $1 $option
