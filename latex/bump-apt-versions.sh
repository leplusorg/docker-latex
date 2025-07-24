#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

cd "$(\dirname "$0")"

if [ -f /.dockerenv ]; then

	\apt-get update

	\sed -e :a -e '/\\$/N; s/\\\n//; ta' Dockerfile | \grep -o -e 'apt-get[^\&\;]*install[^\&\;]*' | \grep -o -e '[^ ]*\=[^ ]*' | while IFS= read -r l; do
		p="${l%=*}"
		v1="${l#*=}"
		v2="$(\apt-cache policy "${p}" | \grep -o -e 'Candidate: [^ ]*' | \sed -e 's/^Candidate: //')"
		if [ "${v1}" != "${v2}" ]; then
			\echo "${p} ${v1} -> ${v2}"
			\perl -i -p -e "s|\Q${l}\E|${p}=${v2}|g" Dockerfile
		fi
	done

else

	\docker run --pull always --rm -t --user root -v "$(pwd):/opt/bump" "leplusorg/${PWD##*/}:main" /opt/bump/"$(\basename "${0}")"

fi
