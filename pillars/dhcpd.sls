# Note that underscores ( _ ) become dashes ( - ) in the configuration.
dhcpd:
    domain_name: dasbo.nl
    file_include:
      - /etc/dhcp/dhcpd_leases.conf
    authoritative: false
    next_server: 10.0.0.1
    ddns_update_style: none
    allow:
      - booting
      - bootp
    domain_name_servers:
        - hv-vm1.dasbo.nl     # replace and add the local dns server if exists
    default_lease_time: 43200
    max_lease_time: 86400
    log_facility: local7
    listen_interfaces:
        - eth0

    subnets:
        10.0.0.0:
            comment: |
                No service will be given on this subnet, but declaring it helps the
                DHCP server to understand the network topology.
            netmask: 255.0.0.0
            range:
              - 10.0.1.50
              - 10.0.2.240
        192.168.25.0:
            comment: |
                No service will be given on this subnet, but declaring it helps the
                DHCP server to understand the network topology.
            netmask: 255.255.255.0
            range:
              - 192.168.25.100
              - 192.168.25.190
