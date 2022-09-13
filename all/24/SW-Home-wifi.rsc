# jan/02/1970 00:43:31 by RouterOS 7.4
# software id = YQ5A-GPPK
#
# model = RouterBOARD 941-2nD
# serial number = 661705430745
/interface bridge
add name=br-VLAN10
add name=br-VLAN20
add name=br-VLAN30
/interface vlan
add interface=ether1 name=ether1_VLAN10 vlan-id=10
add interface=ether1 name=ether1_VLAN20 vlan-id=20
add interface=ether1 name=ether1_VLAN30 vlan-id=30
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
add authentication-types=wpa-psk,wpa2-psk mode=dynamic-keys name=\
    profile-Staff supplicant-identity=""
add authentication-types=wpa-psk,wpa2-psk mode=dynamic-keys name=\
    profile_Guest supplicant-identity=""
/interface wireless
set [ find default-name=wlan1 ] band=2ghz-b/g/n country=thailand disabled=no \
    frequency=2437 mode=ap-bridge security-profile=profile-Staff ssid=\
    WiFi-Staff_Rus
add disabled=no keepalive-frames=disabled mac-address=E6:8D:8C:B1:AF:C2 \
    master-interface=wlan1 multicast-buffering=disabled name=wlan2 \
    security-profile=profile_Guest ssid=WiFi-Guest_Rus wds-cost-range=0 \
    wds-default-cost=0 wps-mode=disabled
/interface bridge port
add bridge=br-VLAN10 interface=ether1_VLAN10
add bridge=br-VLAN20 interface=ether1_VLAN20
add bridge=br-VLAN30 interface=ether1_VLAN30
add bridge=br-VLAN30 interface=ether3
add bridge=br-VLAN10 interface=wlan1
add bridge=br-VLAN20 interface=wlan2
/system identity
set name=SW-Home
