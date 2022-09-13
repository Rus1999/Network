# aug/10/2022 11:19:46 by RouterOS 7.2.1
# software id = MUD1-WY0Q
#
# model = RouterBOARD 941-2nD
# serial number = 8B0F08A762F5
/interface wireless
set [ find default-name=wlan1 ] band=2ghz-b/g/n country=thailand disabled=no \
    frequency=auto mode=station-pseudobridge ssid="  .AP-BUUSK WiFi"
/interface vlan
add interface=ether4 name=ether4_VLAN10 vlan-id=10
add interface=ether4 name=ether4_VLAN20 vlan-id=20
add interface=ether4 name=ether4_VLAN30 vlan-id=30
/interface list
add name=LAN
add name=WAN
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=dhcp_pool0 ranges=172.16.1.2-172.16.1.254
add name=dhcp_pool2 ranges=10.1.10.2-10.1.10.254
add name=dhcp_pool3 ranges=10.2.10.2-10.2.10.254
add name=dhcp_pool4 ranges=10.3.10.2-10.3.10.254
/ip dhcp-server
add address-pool=dhcp_pool0 interface=ether3 lease-time=1d10m name=LAN172.16
add address-pool=dhcp_pool2 interface=ether4_VLAN10 lease-time=1d10m name=\
    dhcp1
add address-pool=dhcp_pool3 interface=ether4_VLAN20 lease-time=1d10m name=\
    dhcp2
add address-pool=dhcp_pool4 interface=ether4_VLAN30 lease-time=1d10m name=\
    dhcp3
/interface list member
add interface=ether1 list=WAN
add interface=wlan1 list=WAN
/ip address
add address=172.16.1.1/24 interface=ether3 network=172.16.1.0
add address=10.1.10.1/24 interface=ether4_VLAN10 network=10.1.10.0
add address=10.2.10.1/24 interface=ether4_VLAN20 network=10.2.10.0
add address=10.3.10.1/24 interface=ether4_VLAN30 network=10.3.10.0
/ip dhcp-client
add interface=ether1
add interface=wlan1
/ip dhcp-server network
add address=10.1.10.0/24 gateway=10.1.10.1
add address=10.2.10.0/24 gateway=10.2.10.1
add address=10.3.10.0/24 gateway=10.3.10.1
add address=172.16.1.0/24 gateway=172.16.1.1
/ip firewall nat
add action=masquerade chain=srcnat disabled=yes out-interface=ether1
add action=masquerade chain=srcnat disabled=yes out-interface=wlan1
add action=masquerade chain=srcnat out-interface-list=WAN
/system clock
set time-zone-name=Asia/Bangkok
/system identity
set name=RO-Home
/tool romon
set enabled=yes
