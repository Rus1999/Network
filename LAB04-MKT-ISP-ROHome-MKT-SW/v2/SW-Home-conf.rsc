# jan/02/1970 00:49:45 by RouterOS 7.2.1
# software id = M2LV-NX37
#
# model = RouterBOARD 941-2nD
# serial number = 661706652A48
/interface bridge
add name=br-vlan10
add name=br-vlan20
add name=br-vlan30
/interface vlan
add interface=ether1 name=ether1-vlan10 vlan-id=10
add interface=ether1 name=ether1-vlan20 vlan-id=20
add interface=ether1 name=ether1-vlan30 vlan-id=30
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
add authentication-types=wpa2-psk mode=dynamic-keys name=Guest \
    supplicant-identity=""
add authentication-types=wpa2-psk mode=dynamic-keys name=Staff \
    supplicant-identity=""
/interface wireless
set [ find default-name=wlan1 ] band=2ghz-b/g/n disabled=no frequency=2437 \
    mode=ap-bridge security-profile=Staff ssid=staff
add disabled=no keepalive-frames=disabled mac-address=6E:3B:6B:22:EE:68 \
    master-interface=wlan1 multicast-buffering=disabled name=wlan2 \
    security-profile=Guest ssid=guest wds-cost-range=0 wds-default-cost=0 \
    wps-mode=disabled
/interface bridge port
add bridge=br-vlan10 interface=ether1-vlan10 pvid=10
add bridge=br-vlan20 interface=ether1-vlan20 pvid=20
add bridge=br-vlan30 interface=ether1-vlan30
add bridge=br-vlan10 interface=ether2
add bridge=br-vlan20 interface=ether3
add bridge=br-vlan30 interface=ether4
add bridge=br-vlan10 interface=wlan1
add bridge=br-vlan20 interface=wlan2
/system identity
set name=SW-Home
/tool romon
set enabled=yes
