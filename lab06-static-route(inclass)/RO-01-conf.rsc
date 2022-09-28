# sep/28/2022 10:30:30 by RouterOS 7.2.1
# software id = MUD1-WY0Q
#
# model = RouterBOARD 941-2nD
# serial number = 8B0F08A762F5
/interface wireless
set [ find default-name=wlan1 ] ssid=MikroTik
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=dhcp_pool0 ranges=192.168.10.2-192.168.10.254
/ip dhcp-server
add address-pool=dhcp_pool0 interface=ether3 lease-time=1d10m name=dhcp1
/ip address
add address=10.1.10.1/30 interface=ether4 network=10.1.10.0
add address=192.168.10.1/24 interface=ether3 network=192.168.10.0
/ip dhcp-client
add interface=ether1
/ip dhcp-server network
add address=192.168.10.0/24 dns-server=10.202.1.5,10.202.1.6 gateway=\
    192.168.10.1
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1
/ip route
add disabled=no dst-address=192.168.20.0/24 gateway=10.1.10.2 routing-table=\
    main suppress-hw-offload=no
add disabled=no distance=1 dst-address=192.168.30.0/24 gateway=10.1.10.2 \
    pref-src="" routing-table=main scope=30 suppress-hw-offload=no \
    target-scope=10
add disabled=no distance=1 dst-address=10.2.10.0/30 gateway=10.1.10.2 \
    pref-src="" routing-table=main scope=30 suppress-hw-offload=no \
    target-scope=10
/system clock
set time-zone-name=Asia/Bangkok
/system identity
set name="38(RO-01)"
/tool romon
set enabled=yes
