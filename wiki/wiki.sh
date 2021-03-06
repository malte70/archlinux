#!/bin/bash

if [ "--help" == "$1" ]; then
	this=`basename $0`
	echo
	echo "Usage: $this archwiki page name"
	echo
	echo "  where archwiki page name is title of page on wiki.archlinux.org"
	echo
	echo "Examples:"
	echo "  $this ssh"
	echo "  $this the arch way"
	echo "  $this beginners guide"
	echo
	exit 0
fi

# try to detect a console browser:
if [ -n "$BROWSER" ];        then run_browser=$BROWSER        # Some users might have set the $BOWSER variable
elif [ -x $(which lynx) ];   then run_browser=$(which lynx)   # Lynx first because of the pretty color output
elif [ -x $(which elinks) ]; then run_browser=$(which elinks) # Elinks second because it newer fork of original Links
elif [ -x $(which links) ];  then run_browser=$(which links)  # If anyone uses...

else  # no console browser found -> exit
	echo "Please install one of the following packages to use this script: elinks links lynx"
	exit 1
fi


query="$*"  # get all params into single query string
query=${query// /_}  # substitute spaces with underscores in the query string

# load ArchWiki page with automatic redirect to the correct URL:
"$run_browser" "https://wiki.archlinux.org/index.php/Special:Search/${query}"

exit $?  # return browser's exit code