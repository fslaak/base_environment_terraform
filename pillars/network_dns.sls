network_settings:
  system:
    enabled: True
    hostname: hv-vm1.dasbo.nl
    gateway: 192.168.25.254
    gatewaydev: eth0
    nozeroconf: True
    nisdomain: dasbo.nl
    require_reboot: False

  interfaces:
    eth0:
        enabled: True
        type: eth
        proto: static
        ipaddr: 192.168.25.12
        netmask: 255.255.255.0
        gateway: 192.168.25.254
        mtu: 1500
