# jan/02/1970 01:33:41 by RouterOS 7.2.1
# software id = M2LV-NX37
#
# model = RouterBOARD 941-2nD
# serial number = 661706652A48
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
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/interface bridge port
add bridge=br-vlan10 interface=ether1-vlan10
add bridge=br-vlan20 interface=ether1-vlan20
add bridge=br-vlan30 interface=ether1-vlan30
add bridge=br-vlan30 interface=ether3
/system identity
set name=MikroTik03
/tool romon
set enabled=yes
