# oct/14/2022 13:53:37 by RouterOS 7.2.1
# software id = MUD1-WY0Q
#
# model = RouterBOARD 941-2nD
# serial number = 8B0F08A762F5
/interface bridge
add name=bridge1
/interface wireless
set [ find default-name=wlan1 ] ssid=MikroTik
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=dhcp_pool0 ranges=192.168.100.2-192.168.100.254
add name=ISP01-pool ranges=10.100.10.2-10.100.10.254
add name=ISP02-pool ranges=172.31.13.2-172.31.13.254
/ip dhcp-server
add address-pool=dhcp_pool0 interface=ether2 lease-time=1d10m name=dhcp1
/ppp profile
add local-address=10.100.10.1 name=isp01-profile remote-address=ISP01-pool
add local-address=172.31.13.1 name=isp02-profile remote-address=ISP02-pool
/interface bridge port
add bridge=bridge1 interface=ether3
add bridge=bridge1 interface=ether4
/interface l2tp-server server
set enabled=yes use-ipsec=yes
/interface pppoe-server server
add authentication=mschap1,mschap2 disabled=no interface=bridge1 \
    keepalive-timeout=20 service-name=pppoe_services
/ip address
add address=192.168.100.1/24 interface=ether2 network=192.168.100.0
/ip dhcp-client
add interface=ether1
/ip dhcp-server network
add address=192.168.100.0/24 gateway=192.168.100.1
/ip dns
set allow-remote-requests=yes
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1
/ppp secret
add name=ppp01@isp01 profile=isp01-profile service=pppoe
add name=ppp02@isp01 profile=isp01-profile service=pppoe
add name=ppp01@isp02 profile=isp02-profile service=pppoe
add name=ppp02@isp02 profile=isp02-profile service=pppoe
/system clock
set time-zone-name=Asia/Bangkok
/system identity
set name=38-ISP
/tool romon
set enabled=yes
