# jan/02/1970 02:26:49 by RouterOS 7.2.1
# software id = M2LV-NX37
#
# model = RouterBOARD 941-2nD
# serial number = 661706652A48
/interface bridge
add name=br-vlan10
add name=br-vlan20
add name=br-vlan30
add name=br-vlan88
add name=br-vlan99
/interface vlan
add interface=ether1 name=ether1-vlan10 vlan-id=10
add interface=ether1 name=ether1-vlan20 vlan-id=20
add interface=ether1 name=ether1-vlan30 vlan-id=30
add interface=ether1 name=ether1-vlan88 vlan-id=88
add interface=ether1 name=ether1-vlan99 vlan-id=99
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
add authentication-types=wpa2-psk mode=dynamic-keys name=Guest \
    supplicant-identity=""
add authentication-types=wpa2-psk mode=dynamic-keys name=Staff \
    supplicant-identity=""
/interface wireless
set [ find default-name=wlan1 ] band=2ghz-b/g/n country=thailand disabled=no \
    mode=ap-bridge security-profile=Staff ssid=staff-Rus
add disabled=no keepalive-frames=disabled mac-address=6E:3B:6B:22:EE:68 \
    master-interface=wlan1 multicast-buffering=disabled name=wlan2 \
    security-profile=Guest ssid=guest-Rus wds-cost-range=0 wds-default-cost=0 \
    wps-mode=disabled
/interface bridge port
add bridge=br-vlan10 interface=ether1-vlan10
add bridge=br-vlan20 interface=ether1-vlan20
add bridge=br-vlan30 interface=ether1-vlan30
add bridge=br-vlan20 interface=ether3
add bridge=br-vlan88 interface=wlan1
add bridge=br-vlan99 interface=wlan2
add bridge=br-vlan30 interface=ether4
add bridge=br-vlan10 interface=ether2
add bridge=br-vlan88 interface=ether1-vlan88
add bridge=br-vlan99 interface=ether1-vlan99
/system identity
set name=SW-Home
/tool romon
set enabled=yes
