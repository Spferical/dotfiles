iptables-restore < /etc/iptables/empty.rules
iptables -N TCP
iptables -N UDP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# allow existing connections
iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

# allow loopback access
iptables -I INPUT 1 -i lo -j ACCEPT

# drop invalid sessions
iptables -A INPUT -m conntrack --ctstate INVALID -j DROP

# allow pings
iptables -A INPUT -p icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT

# fwd udp + tcp to separate chains
iptables -A INPUT -p udp -m conntrack --ctstate NEW -j UDP
iptables -A INPUT -p tcp --syn -m conntrack --ctstate NEW -j TCP

# avahi
iptables -A INPUT -p udp -m udp --dport 5353 -j ACCEPT

# ssh
iptables -A TCP -p tcp --dport 22 -j ACCEPT

#ipfs
# swarm address
iptables -A TCP -p tcp --dport 4001 -j ACCEPT
# web gui
iptables -A TCP -p tcp --dport 5001 -j ACCEPT

# mosh
iptables -A INPUT -p udp --dport 60000:61000 -j ACCEPT

# I2P
iptables -A INPUT -p udp --dport 25116 -j ACCEPT
iptables -A INPUT -p tcp --dport 25116 -j ACCEPT

# secure scuttlebutt
iptables -A TCP -p tcp --dport 8008 -j ACCEPT

# log blocked packets
# iptables -A INPUT -m limit --limit 5/min -j LOG --log-prefix "iptables denied: " --log-level 7

iptables -A INPUT -p udp -j REJECT --reject-with icmp-port-unreachable
iptables -A INPUT -p tcp -j REJECT --reject-with tcp-rst
iptables -A INPUT -j REJECT --reject-with icmp-proto-unreachable
iptables -P INPUT DROP

# restart monitorix
# it adds its own rules
systemctl restart monitorix

iptables-save > /etc/iptables/iptables.rules
systemctl enable iptables.service
systemctl start iptables.service
systemctl status iptables.service
# sudo iptables -A INPUT -p tcp --dport 27015 -j ACCEPT # Team Fortress 2 server
