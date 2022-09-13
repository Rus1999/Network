# jan/02/1970 00:59:33 by RouterOS 7.2.1
# software id = MUD1-WY0Q
#
# model = RouterBOARD 941-2nD
# serial number = 8B0F08A762F5
/interface bridge
add name=br-vlan10
add name=br-vlan20
add name=br-vlan30
/interface wireless
set [ find default-name=wlan1 ] ssid=MikroTik
/interface vlan
add interface=ether4 name=ether4-vlan10 vlan-id=10
add interface=ether4 name=ether4-vlan20 vlan-id=20
add interface=ether4 name=ether4-vlan30 vlan-id=30
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=dhcp_pool0 ranges=10.1.10.2-10.1.10.254
add name=dhcp_pool1 ranges=10.1.20.2-10.1.20.254
add name=dhcp_pool2 ranges=10.1.30.2-10.1.30.254
/ip dhcp-server
add address-pool=dhcp_pool0 interface=br-vlan10 lease-time=1d10m name=dhcp1
add address-pool=dhcp_pool1 interface=br-vlan20 lease-time=1d10m name=dhcp2
add address-pool=dhcp_pool2 interface=br-vlan30 lease-time=1d10m name=dhcp3
/interface bridge port
add bridge=br-vlan10 interface=ether4-vlan10
add bridge=br-vlan20 interface=ether4-vlan20
add bridge=br-vlan30 interface=ether4-vlan30
add bridge=br-vlan30 interface=ether3
/ip address
add address=10.1.10.1/24 interface=br-vlan10 network=10.1.10.0
add address=10.1.20.1/24 interface=br-vlan20 network=10.1.20.0
add address=10.1.30.1/24 interface=br-vlan30 network=10.1.30.0
/ip dhcp-server network
add address=10.1.10.0/24 gateway=10.1.10.1
add address=10.1.20.0/24 gateway=10.1.20.1
add address=10.1.30.0/24 gateway=10.1.30.1
/system identity
set name=MikroTik38
/tool romon
set enabled=yes
