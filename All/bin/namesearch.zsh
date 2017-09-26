while true
do
    domain="$(cat /dev/urandom| tr -dc 'a-z'|head -c 4).net"
    output="$(nslookup $domain | grep NXDOMAIN)"
    if [[ -n $output ]]; then echo $domain; fi
done
