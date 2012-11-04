#!/bin/bash
# ranger supports enhanced previews.  If the option "use_preview_script"
# is set to True and this file exists, this script will be called and its
# output is displayed in ranger.  ANSI color codes are supported.

# NOTES: This script is considered a configuration file.  If you upgrade
# ranger, it will be left untouched. (You must update it yourself.)
# Also, ranger disables STDIN here, so interactive scripts won't work properly

# Meanings of exit codes:
# code | meaning    | action of ranger
# -----+------------+-------------------------------------------
# 0    | success    | success. display stdout as preview
# 1    | no preview | failure. display no preview at all
# 2    | plain text | display the plain content of the file
# 3    | fix width  | success. Don't reload when width changes
# 4    | fix height | success. Don't reload when height changes
# 5    | fix both   | success. Don't ever reload

# Meaningful aliases for arguments:
path="$1"    # Full path of the selected file
width="$2"   # Width of the preview pane (number of fitting characters)
height="$3"  # Height of the preview pane (number of fitting characters)

maxln=200    # Stop after $maxln lines.  Can be used like ls | head -n $maxln

# Find out something about the file:
mimetype=$(file --mime-type -Lb "$path")
extension=${path##*.}

# Functions:
# "have $1" succeeds if $1 is an existing command/installed program
function have { type -P "$1" > /dev/null; }
# "success" returns the exit code of the first program in the last pipe chain
function success { test ${PIPESTATUS[0]} = 0; }

case "$extension" in
	# HTML Pages:
	htm|html|xhtml)
		have w3m    && w3m    -dump "$path" | head -n $maxln | fmt -s -w $width && exit 4
		;; # fall back to highlight/cat if theres no lynx/elinks
esac

case "$mimetype" in
	# Syntax highlight for text files:
	text/* | */xml)
		highlight --out-format=ansi "$path" | head -n $maxln
		success && exit 5 || exit 2;;
esac

exit 1
