#!/bin/bash

cd `dirname $0` || exit
read -p"user: " user
[[ -z "$user" ]] && echo "error: empty user" && exit
echo "$user" > key/user
stty -echo
read -p"pass: " pass
stty echo
echo
[[ -z "$pass" ]] && echo "error: empty pass" && exit
echo -n "$pass" | openssl rsautl -inkey key/bnac.pem -pubin -encrypt > key/pass
echo "done"
