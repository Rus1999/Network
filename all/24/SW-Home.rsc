# jan/02/1970 00:10:31 by RouterOS 7.4
# software id = YQ5A-GPPK
#
# model = RouterBOARD 941-2nD
# serial number = 661705430745
/interface bridge
add name=br-VLAN10
add name=br-VLAN20
add name=br-VLAN30
/interface wireless
set [ find default-name=wlan1 ] ssid=MikroTik
/interface vlan
add interface=ether1 name=ether1_VLAN10 vlan-id=10
add interface=ether1 name=ether1_VLAN20 vlan-id=20
add interface=ether1 name=ether1_VLAN30 vlan-id=30
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/interface bridge port
add bridge=br-VLAN10 interface=ether1_VLAN10
add bridge=br-VLAN20 interface=ether1_VLAN20
add bridge=br-VLAN30 interface=ether1_VLAN30
add bridge=br-VLAN30 interface=ether3
/system identity
set name=SW-Home
