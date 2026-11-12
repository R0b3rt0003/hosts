#!/bin/bash

cat /etc/hosts | while read ip name rest; do
	if [ -z "$ip" ] || [[ "$ip" == \#* ]]; then
		continue
	fi

	if [[ "$name" == "localhost" ]] || [[ "$ip" == "127."* ]] || [[ "$ip" == *":"* ]]; then
		continue
	fi

	ok=0
	nslookup "$name" 2>/dev/null | while read nume real rest; do
		if [[ "$nume" == "Address:" ]] && [[ "$ok" == 0 ]]; then
			ok=1
			continue
		fi

		if [[ "$nume" != "Address:" ]]; then
			continue
		fi
		if [ "$real" != "$ip" ]; then
                echo "Bogus IP for $name in /etc/hosts!"
		fi
		break
	done
done
