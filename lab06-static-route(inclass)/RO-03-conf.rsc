# jan/02/1970 01:17:00 by RouterOS 7.2.1
# software id = M2LV-NX37
#
# model = RouterBOARD 941-2nD
# serial number = 661706652A48
/interface wireless
set [ find default-name=wlan1 ] ssid=MikroTik
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=dhcp_pool0 ranges=192.168.30.2-192.168.30.254
/ip dhcp-server
add address-pool=dhcp_pool0 interface=ether3 lease-time=1d10m name=dhcp1
/ip address
add address=10.2.10.2/30 interface=ether1 network=10.2.10.0
add address=192.168.30.1/24 interface=ether3 network=192.168.30.0
/ip dhcp-server network
add address=192.168.30.0/24 dns-server=10.202.1.5,10.202.1.6 gateway=\
    192.168.30.1
/ip route
add disabled=no dst-address=192.168.10.0/24 gateway=10.2.10.1 routing-table=\
    main suppress-hw-offload=no
add disabled=no distance=1 dst-address=192.168.20.0/24 gateway=10.2.10.1 \
    pref-src="" routing-table=main scope=30 suppress-hw-offload=no \
    target-scope=10
add disabled=no distance=1 dst-address=10.1.10.0/30 gateway=10.2.10.1 \
    pref-src="" routing-table=main scope=30 suppress-hw-offload=no \
    target-scope=10
add disabled=no dst-address=0.0.0.0/0 gateway=10.2.10.1 routing-table=main \
    suppress-hw-offload=no
/system identity
set name="03(RO-03)"
/tool romon
set enabled=yes
