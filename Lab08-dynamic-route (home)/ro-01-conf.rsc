# oct/02/2022 20:18:22 by RouterOS 7.2.1
# software id = MUD1-WY0Q
#
# model = RouterBOARD 941-2nD
# serial number = 8B0F08A762F5
/interface bridge
add name=loopback
/interface wireless
set [ find default-name=wlan1 ] ssid=MikroTik
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=dhcp_pool0 ranges=192.168.10.2-192.168.10.254
/ip dhcp-server
add address-pool=dhcp_pool0 interface=ether3 lease-time=1d10m name=dhcp1
/routing id
add disabled=no id=10.1.1.1 name=id-1 select-dynamic-id=""
/routing ospf instance
add disabled=no name=ospf-instance-1 router-id=id-1 routing-table=main
/routing ospf area
add disabled=no instance=ospf-instance-1 name=backbone
/ip address
add address=192.168.10.1/24 interface=ether3 network=192.168.10.0
add address=10.1.10.1/30 interface=ether4 network=10.1.10.0
add address=10.1.1.1 interface=loopback network=10.1.1.1
/ip dhcp-client
add interface=ether1
/ip dhcp-server network
add address=192.168.10.0/24 dns-server=10.202.1.5,10.202.1.6 gateway=\
    192.168.10.1
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1
/routing ospf interface-template
add area=backbone auth=md5 auth-id=0 auth-key=1234 disabled=no interfaces=\
    ether4 type=ptp
add area=backbone auth=md5 auth-key=1234 disabled=no interfaces=all passive
/system clock
set time-zone-name=Asia/Bangkok
/system identity
set name=38
/tool romon
set enabled=yes
