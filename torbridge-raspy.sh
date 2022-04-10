#!/bin/bash

clear
echo ""
echo "!!! If your bridge is behind a firewall or NAT, make sure to open TCP port: ORPort and obfs4proxy !!!"
echo ""
echo "- Tested on Raspberry Pi Zero W 1.1 Version and RaspiOS Bullseye Lite."
echo "- Run update and install tor, torsocks, obfs4proxy, nyx (tor monitor) and vnstat (network traffic monitor)"
echo "- Generate /etc/tor/torrc for bridge with:"
echo "  notices.log (/var/log/tor/notices.log)"
echo "  ControlPort (9051)"
echo "  HashedControlPassword"
echo "  BandwidthRate"
echo "  BandwidthBurst"
echo "  MaxAdvertisedBandwidth"
echo ""
echo -n "Press <any_key> to continue or <ctrl+c> for terminate."
read randomkey
echo ""

if [[ $EUID -ne 0 ]]; then
   echo "!!! This script must be run as root !!!" 
   exit 1
fi

clear
apt update
apt install -y tor obfs4proxy nyx vnstat

clear
printf 'Please enter SOCKSPort port, value 0 disable it (ex: 9050):'
read socks_port
echo ""
printf 'Write your Password for generate HashControlPassword and copy it (ex: my_control_password):'
read password
tor --hash-password ${password}
echo ""
printf 'Please write your HashControlPassword just generated (ex: 16:55432A...):'
read hash_control_passwd
echo ""
printf 'Please enter your public DNS or IP or leave blank and press enter (ex: mybridge.dyndns.org or 128.128.128.128):'
read dns_ip
echo ""
printf 'Please enter ORport port. If your bridge is behind a FIREWALL or NAT, make sure to open/forward port (ex: 9001):'
read orport_port
echo ""
printf 'Please enter ORport port internet protocol type, if is only IPV4 write "IPv4Only", if is only IPV6 write "IPv6Only", if BOTH leave blank and press enter:'
read orport_port_type
echo ""
printf 'Please enter obfs4proxy port, must be greater than 1024. If your bridge is behind a FIREWALL or NAT, make sure to open/forward port (ex: 9002):'
read obfs4_port
echo ""
printf 'Please enter your Contact Info (ex: john[DOT]doe[AT]google[DOT]com - [DOT] and [AT] for avoid spam etc...):'
read contact_info
echo ""
printf 'Please enter your Nickname (ex: JohnDoe):'
read nickname
echo ""
printf 'Please enter BandwidthRate value in KBytes (ex: 512):'
read band_rate
echo ""
printf 'Please enter BandwidthBurst value in KBytes (ex: 768):'
read band_brust
echo ""
printf 'Please enter MaxAdvertisedBandwidth value in KBytes (ex: 640):'
read max_band
echo ""
printf 'Please enter PublishServerDescriptor value for bridge. 0 your bridge is private and 1 is public:'
read pub_pvt

config_file_path="/etc/tor/torrc"
config=$(printf "\
SOCKSPort ${socks_port}
Log notice file /var/log/tor/notices.log
BridgeRelay 1
RunAsDaemon 1
ExitPolicy reject *:*
ControlPort 9051
HashedControlPassword ${hash_control_passwd}
Address ${dns_ip}
ORPort ${orport_port} ${orport_port_type}
ServerTransportPlugin obfs4 exec /usr/bin/obfs4proxy
ServerTransportListenAddr obfs4 0.0.0.0:${obfs4_port}
ExtORPort auto
ContactInfo ${contact_info}
Nickname ${nickname}
BandwidthRate ${band_rate} KBytes
BandwidthBurst ${band_brust} KBytes
MaxAdvertisedBandwidth ${max_band} KBytes
PublishServerDescriptor ${pub_pvt}
")

echo "${config}" > "${config_file_path}"

sed -i '$ a [Install]' /lib/systemd/system/tor@default.service
sed -i '$ a WantedBy=multi-user.target' /lib/systemd/system/tor@default.service
sed -i 's/NoNewPrivileges=yes/NoNewPrivileges=no/g' /lib/systemd/system/tor@default.service
sed -i 's/NoNewPrivileges=yes/NoNewPrivileges=no/g' /lib/systemd/system/tor@.service

systemctl daemon-reload
systemctl enable --now tor@default
systemctl restart tor

clear
echo ""
echo "## TOR PATH ##"
echo "bin            /usr/bin"
echo "config         /etc/tor/torrc"
echo "config_default /usr/share/tor"
echo "data           /var/lib/tor"
echo "log            /var/log/tor"
echo ""
echo "## TOR SERVICE AND USEFUL COMMANDS ##"
echo "systemctl daemon-reload"
echo "systemctl enable tor"
echo "systemctl disable tor"
echo "systemctl start tor"
echo "systemctl stop tor"
echo "systemctl restart tor"
echo "systemctl status tor"
echo "netstat -tlpn | grep tor"
echo "cat /var/log/tor/notices.log"
echo "tail -f /var/log/tor/notices.log"
echo "nyx"
echo "vnstat"
echo "htop"
echo ""
echo "## GET BRIDGE LINE AND IDENTIFY KEY FINGERPRINT ##"
echo "cat /var/lib/tor/pt_state/obfs4_bridgeline.txt"
echo "cat /var/lib/tor/fingerprint"
echo ""
echo "## USEFUL LINK FOR TOR BRIDGE STATUS (look on notices.log hashed identity key fingerprint) ##"
echo "https://metrics.torproject.org/rs.html#details/HASHED_IDENTIFY_KEY_FINGERPRINT"
echo "https://bridges.torproject.org/status?id=HASHED_IDENTIFY_KEY_FINGERPRINT"
echo "https://metrics.torproject.org/rs.html#search/type:bridge%20running:true"
echo "https://bridges.torproject.org/scan"
echo ""
echo -n "Press <any_key> to terminate."
read randomkey

exit 0
