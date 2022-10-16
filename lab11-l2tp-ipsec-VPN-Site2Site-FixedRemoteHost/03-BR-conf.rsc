# oct/16/2022 22:51:48 by RouterOS 7.2.1
# software id = M2LV-NX37
#
# model = RouterBOARD 941-2nD
# serial number = 661706652A48
/interface wireless
set [ find default-name=wlan1 ] ssid=MikroTik
/interface pppoe-client
add add-default-route=yes disabled=no interface=ether1 keepalive-timeout=20 \
    name=pppoe-out1 use-peer-dns=yes user=ppp01@isp02
/interface l2tp-client
add connect-to=10.100.10.254 disabled=no name=l2tp-out1 use-ipsec=yes \
    use-peer-dns=yes user=l2tp01
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=pptp_pool ranges=172.27.72.2-172.27.72.254
add name=dhcp_pool ranges=192.168.200.2-192.168.200.254
/ip dhcp-server
add address-pool=dhcp_pool interface=ether3 lease-time=1d10m name=dhcp1
/ppp profile
add local-address=172.27.72.1 name=pptp_profile remote-address=pptp_pool
/ip address
add address=192.168.200.1/24 interface=ether3 network=192.168.200.0
/ip dhcp-server network
add address=192.168.7.0/24 gateway=192.168.7.1
add address=192.168.200.0/24 gateway=192.168.200.1
/ip firewall nat
add action=masquerade chain=srcnat out-interface=pppoe-out1
/ip route
add check-gateway=ping disabled=no dst-address=192.168.3.0/24 gateway=\
    172.16.61.1 routing-table=main suppress-hw-offload=no
add check-gateway=ping disabled=no distance=1 dst-address=192.168.250.0/24 \
    gateway=172.16.61.1 pref-src="" routing-table=main scope=30 \
    suppress-hw-offload=no target-scope=10
/ppp secret
add name=pptp01 profile=pptp_profile service=pptp
add name=pptp02 profile=pptp_profile service=pptp
/system clock
set time-zone-name=Asia/Bangkok
/system identity
set name=03-BR
/tool romon
set enabled=yes
