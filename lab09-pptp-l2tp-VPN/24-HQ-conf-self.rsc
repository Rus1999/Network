# oct/14/2022 13:52:41 by RouterOS 7.4
# software id = YQ5A-GPPK
#
# model = RouterBOARD 941-2nD
# serial number = 661705430745
/interface wireless
set [ find default-name=wlan1 ] ssid=MikroTik
/interface pppoe-client
add add-default-route=yes disabled=no interface=ether1 keepalive-timeout=20 \
    name=pppoe-out1 use-peer-dns=yes user=ppp01@isp01
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip ipsec proposal
set [ find default=yes ] enc-algorithms=aes-256-cbc
/ip pool
add name=dhcp_pool0 ranges=192.168.3.2-192.168.3.254
add name=pptp_pool ranges=172.21.12.2-172.21.12.254
add name=l2tp_pool ranges=172.16.61.2-172.16.61.254
/ip dhcp-server
add address-pool=dhcp_pool0 interface=ether3 lease-time=1d10m name=dhcp1
/ppp profile
add local-address=172.21.12.1 name=pptp_profile remote-address=pptp_pool \
    use-encryption=yes
add local-address=172.16.61.1 name=l2tp_profile remote-address=l2tp_pool \
    use-encryption=required
/interface pptp-server server
# PPTP connections are considered unsafe, it is suggested to use a more modern VPN protocol instead
set enabled=yes
/ip address
add address=192.168.3.1/24 interface=ether3 network=192.168.3.0
/ip dhcp-server network
add address=192.168.3.0/24 gateway=192.168.3.1
/ip dns
set allow-remote-requests=yes
/ip firewall filter
add action=accept chain=input dst-port=500,4500,1701 protocol=udp
add action=accept chain=input protocol=ipsec-esp
add action=accept chain=input protocol=ipsec-ah
/ip firewall nat
add action=masquerade chain=srcnat out-interface=pppoe-out1
/ppp secret
add name=pptp01 profile=pptp_profile service=pptp
add name=pptp02 profile=pptp_profile service=pptp
add name=l2tp01 profile=l2tp_profile service=l2tp
add name=l2tp02 profile=l2tp_profile service=l2tp
/system clock
set time-zone-name=Asia/Bangkok
/system identity
set name=24-HQ
/tool romon
set enabled=yes
