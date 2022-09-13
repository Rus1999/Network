# sep/10/2022 21:47:27 by RouterOS 7.2.1
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
add name=dhcp_pool0 ranges=10.1.10.2-10.1.10.254
add name=pppoe_pool ranges=172.16.17.2-172.16.17.254
/ip dhcp-server
add address-pool=dhcp_pool0 interface=bridge1 lease-time=1d10m name=dhcp1
/ppp profile
add local-address=172.16.17.1 name=pppoe_profile remote-address=pppoe_pool
/interface bridge port
add bridge=bridge1 interface=ether2
add bridge=bridge1 interface=ether4
add bridge=bridge1 interface=ether3
/interface pppoe-server server
add default-profile=pppoe_profile disabled=no interface=bridge1 service-name=\
    pppoe_service
/ip address
add address=10.1.10.1/24 interface=bridge1 network=10.1.10.0
/ip dhcp-client
add interface=ether1
/ip dhcp-server network
add address=10.1.10.0/24 gateway=10.1.10.1
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1
/ppp secret
add name=ppp01 profile=pppoe_profile service=pppoe
add name=ppp02 profile=pppoe_profile service=pppoe
/system clock
set time-zone-name=Asia/Bangkok
/system identity
set name=MKT-ISP
