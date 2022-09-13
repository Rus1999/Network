# jan/02/1970 00:49:38 by RouterOS 7.2.1
# software id = MUD1-WY0Q
#
# model = RouterBOARD 941-2nD
# serial number = 8B0F08A762F5
/interface bridge
add name=br_VLAN10
add name=br_VLAN20
add name=br_VLAN30
/interface vlan
add interface=ether1 name=eth1_VLAN10 vlan-id=10
add interface=ether1 name=eth1_VLAN20 vlan-id=20
add interface=ether1 name=eth1_VLAN30 vlan-id=30
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
add authentication-types=wpa2-psk mode=dynamic-keys name=Guest-Rus \
    supplicant-identity=""
add authentication-types=wpa2-psk mode=dynamic-keys name=Staff-Rus \
    supplicant-identity=""
/interface wireless
set [ find default-name=wlan1 ] band=2ghz-b/g/n disabled=no security-profile=\
    Staff-Rus ssid=.Staff-Rus
add disabled=no keepalive-frames=disabled mac-address=CE:2D:E0:A6:59:0B \
    master-interface=wlan1 multicast-buffering=disabled name=wlan2 \
    security-profile=Guest-Rus ssid=.Guest-Rus wds-cost-range=0 \
    wds-default-cost=0 wps-mode=disabled
/interface bridge port
add bridge=br_VLAN10 interface=eth1_VLAN10
add bridge=br_VLAN20 interface=eth1_VLAN20
add bridge=br_VLAN30 interface=eth1_VLAN30
add bridge=br_VLAN10 interface=ether2
add bridge=br_VLAN20 interface=ether3
add bridge=br_VLAN30 interface=ether4
add bridge=br_VLAN10 interface=wlan1
add bridge=br_VLAN20 interface=wlan2
/system identity
set name=SW-Home
