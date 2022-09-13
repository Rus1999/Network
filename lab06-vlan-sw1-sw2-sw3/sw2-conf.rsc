# jan/02/1970 01:36:27 by RouterOS 7.4
# software id = YQ5A-GPPK
#
# model = RouterBOARD 941-2nD
# serial number = 661705430745
/interface bridge
add name=br-vlan10
add name=br-vlan20
add name=br-vlan30
/interface wireless
set [ find default-name=wlan1 ] ssid=MikroTik
/interface vlan
add interface=ether1 name=ether1-vlan10 vlan-id=10
add interface=ether1 name=ether1-vlan20 vlan-id=20
add interface=ether1 name=ether1-vlan30 vlan-id=30
add interface=ether4 name=ether4-vlan10 vlan-id=10
add interface=ether4 name=ether4-vlan20 vlan-id=20
add interface=ether4 name=ether4-vlan30 vlan-id=30
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/interface bridge port
add bridge=br-vlan10 interface=ether1-vlan10
add bridge=br-vlan20 interface=ether1-vlan20
add bridge=br-vlan30 interface=ether1-vlan30
add bridge=br-vlan20 interface=ether2
add bridge=br-vlan10 interface=ether3
add bridge=br-vlan10 interface=ether4-vlan10
add bridge=br-vlan20 interface=ether4-vlan20
add bridge=br-vlan30 interface=ether4-vlan30
/system identity
set name=MikroTik24
/tool romon
set enabled=yes
