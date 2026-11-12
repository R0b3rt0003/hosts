#!/bin/bash
validate_ip() {
    local host=$1
    local ip=$2
    local dns=$3
    nslookup "$host" "$dns" 2>/dev/null | grep -q "Address: $ip" || echo "Bogus IP for $host in /etc/hosts!"
}

cat /etc/hosts | while read ip name rest; do
    [[ -z "$ip" || "$ip" =~ ^# ]] && continue
    [[ "$name" == "localhost" ]] && continue
    validate_ip "$name" "$ip" "8.8.8.8"
done
#mihnea
