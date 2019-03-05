#!/bin/bash

MAINPATH=$HOME/.wiki

display_usage()
{
	echo "usage $0 [-optinon] query"
	echo -e "options:"
	echo -e "\ta - show all ans"
	echo -e "\tf - show first ans"
	echo -e "\tp - show all ans in defaul pager"
}

out_pager()
{
	if [[ -z $PAGER ]]
	then
		if [ less ];then PAGER=less;
		elif [ more ];then PAGER=more;
		else
			echo "Defaul pager not found. Use flag -a for show all ans."
		fi
	fi

	python3 $MAINPATH/main.py "$1" | "$PAGER"
}

query()
{
	case $2 in
		p) out_pager "$1";;
		a) python3 $MAINPATH/main.py "$1" ;;
		*) python3 $MAINPATH/main.py "$1" | head -n 1 ;;
	esac
}

error_flag()
{
	echo "illegal option(s)"
	exit
}

flag=""

if [[ "$1" =~ ^- ]]
then
	case $1 in
		-f)
			if [ -z "$flag" ]; then flag='f'; else error_flag;display_usage;fi
			;;
		-a)
			if [ -z "$flag" ]; then flag='a'; else error_flag;display_usage;fi
			;;
		-p)
			if [ -z "$flag" ]; then flag='p'; else error_flag;display_usage;fi
			;;
		*)
			error_flag
			display_usage
			;;
	esac
shift
fi

if [ "$#" -ne "1" ]
then
	echo "many args"
	display_usage
	exit
fi

query "$1" "$flag"
