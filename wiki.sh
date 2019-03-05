#!/bin/bash

MAINDIR=$HOME/.wiki

check_dir()
{
	if [[ ! -d $MAINDIR ]]
	then
		return 0
	fi
	return 1
}

init()
{
	git clone https://github.com/goncharoman/wiki.git $MAINDIR
}

query()
{
	python $MAINDIR/main.py $1
}


if [[ check_dir -eq 0 ]]
then
	init
fi

while [[ "$1" =~ ^- ]]
do
	case $1 in
		-f)
			shift
			query $1 1
			;;
		-a)
			shift
			query $2 -1
			;;
		-n)
			shift
			arg=$1; shift
			query $1 $arg

		-p)
			shift
			pager $1
			;;
		*)
			echo "usage $0"
			;;
	esac
	shift
done
