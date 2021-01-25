### General config options                  ###
bind:
  lookup:
    log_dir: /var/named/data
    local_config: /etc/named/local.config
    named_directory: /var/named
### If we want to include additional files ###
#  includes:                                     # Include any additional configuration file(s) in
#    - /etc/named/dns_key              # named.conf
### Configuration file /etc/named.conf   ###
  config:
    user: named                                   # File & Directory user
    group: named                                  # File & Directory group
    mode: 640                                     # File & Directory mode
    enable_logging: true                          # Enable basic query logging
### Options we want to specify - /etc/named/options.conf ###
  options:
    allow-recursion: '{ localnets; localhost; }'                 # Never include this on a public resolver
# RedHat defaults, needed to generate default config file
    listen-on: 'port 53 { 192.168.25.11; }'
    listen-on-v6: 'port 53 { ::1; }'
    allow-query: '{ any; }'
    recursion: 'yes'
    dnssec-enable: 'yes'
    dnssec-validation: 'yes'
# End RedHat defaults
  protocol: 4                                   # Force bind to serve only one IP protocol
                                                # (ipv4: 4, ipv6: 6). Omitting this reverts to

  configured_zones:
    dasbo.nl:
      type: master
      file: dasbo.nl.txt
      notify: false

    105.100.145.in-addr.arpa:
      type: master
      file: 105.100.145.in-addr.arpa.txt
      notify: false

    50.0.10.in-addr.arpa:
      type: master
      file: 50.0.10.in-addr.arpa.txt
      notify: false

    127.0.10.in-addr.arpa:
      type: master
      file: 127.0.10.in-addr.arpa.txt
      notify: false

    42.0.10.in-addr.arpa:
      type: master
      file: 42.0.10.in-addr.arpa.txt
      notify: false

  available_zones:
    dasbo.nl:
      file: dasbo.nl.txt
      soa:                                        # Declare the SOA RRs for the zone
        ns: hv-vm1.dasbo.nl.                   # Required
        contact: admin.dasbo.nl.               # Required
        serial: auto                              # Alternatively, autoupdate serial on each change
        class: IN                                 # Optional. Default: IN
        refresh: 8600                             # Optional. Default: 12h
        retry: 900                                # Optional. Default: 15m
        expiry: 86000                             # Optional. Default: 2w
        nxdomain: 500                             # Optional. Default: 1m
        ttl: 8600                                 # Optional. Not set by default
      records:
        NS:
          'dasbo.nl.':
            - hv-vm.dasbo.nl.                                  # Records for the zone, grouped by type
        MX:
          'dasbo.nl.':
            - 10 mail.dasbo.nl.
        A:
          hv-vm1.dasbo.nl.: 145.100.105.185
          mail.dasbo.nl.:  145.100.105.185
          web01.dasbo.nl.: 145.100.105.186
          www.dasbo.nl.: 145.100.105.186
          desktop1.dasbo.nl.: 10.0.50.1
          desktop2.dasbo.nl.: 10.0.50.2
          desktop3.dasbo.nl.: 10.0.50.3
          desktop4.dasbo.nl.: 10.0.50.4
          desktop5.dasbo.nl.: 10.0.50.5
          desktop6.dasbo.nl.: 10.0.50.6
          desktop7.dasbo.nl.: 10.0.50.7
          desktop8.dasbo.nl.: 10.0.50.8
          desktop9.dasbo.nl.: 10.0.50.9
          desktop10.dasbo.nl.: 10.0.50.10
          desktop11.dasbo.nl.: 10.0.50.11
          desktop12.dasbo.nl.: 10.0.50.12
          desktop13.dasbo.nl.: 10.0.50.13
          desktop14.dasbo.nl.: 10.0.50.14
          desktop15.dasbo.nl.: 10.0.50.15
          desktop16.dasbo.nl.: 10.0.50.16
          desktop17.dasbo.nl.: 10.0.50.17
          desktop18.dasbo.nl.: 10.0.50.18
          desktop19.dasbo.nl.: 10.0.50.19
          desktop20.dasbo.nl.: 10.0.50.20
          desktop21.dasbo.nl.: 10.0.50.21
          desktop22.dasbo.nl.: 10.0.50.22
          desktop23.dasbo.nl.: 10.0.50.23
          desktop24.dasbo.nl.: 10.0.50.24
          desktop25.dasbo.nl.: 10.0.50.25
          server1.dasbo.nl.: 10.0.127.1
          server2.dasbo.nl.: 10.0.127.2
          server3.dasbo.nl.: 10.0.127.3
          server4.dasbo.nl.: 10.0.127.4
          server5.dasbo.nl.: 10.0.127.5
          server6.dasbo.nl.: 10.0.127.6
          server7.dasbo.nl.: 10.0.127.7
          server8.dasbo.nl.: 10.0.127.8
          server9.dasbo.nl.: 10.0.127.9
          server10.dasbo.nl.: 10.0.127.10
          server11.dasbo.nl.: 10.0.127.11
          server12.dasbo.nl.: 10.0.127.12
          server13.dasbo.nl.: 10.0.127.13
          server14.dasbo.nl.: 10.0.127.14
          server15.dasbo.nl.: 10.0.127.15
          server16.dasbo.nl.: 10.0.127.16
          server17.dasbo.nl.: 10.0.127.17
          server18.dasbo.nl.: 10.0.127.18
          server19.dasbo.nl.: 10.0.127.19
          server20.dasbo.nl.: 10.0.127.20
          server21.dasbo.nl.: 10.0.127.21
          server22.dasbo.nl.: 10.0.127.22
          server23.dasbo.nl.: 10.0.127.23
          server24.dasbo.nl.: 10.0.127.24
          server25.dasbo.nl.: 10.0.127.25
          adrac.server1.dasbo.nl.: 10.0.42.1
          adrac.server2.dasbo.nl.: 10.0.42.2
          adrac.server3.dasbo.nl.: 10.0.42.3
          adrac.server4.dasbo.nl.: 10.0.42.4
          adrac.server5.dasbo.nl.: 10.0.42.5
          adrac.server6.dasbo.nl.: 10.0.42.6
          adrac.server7.dasbo.nl.: 10.0.42.7
          adrac.server8.dasbo.nl.: 10.0.42.8
          adrac.server9.dasbo.nl.: 10.0.42.9
          adrac.server10.dasbo.nl.: 10.0.42.10
          adrac.server11.dasbo.nl.: 10.0.42.11
          adrac.server12.dasbo.nl.: 10.0.42.12
          adrac.server13.dasbo.nl.: 10.0.42.13
          adrac.server14.dasbo.nl.: 10.0.42.14
          adrac.server15.dasbo.nl.: 10.0.42.15
          adrac.server16.dasbo.nl.: 10.0.42.16
          adrac.server17.dasbo.nl.: 10.0.42.17
          adrac.server18.dasbo.nl.: 10.0.42.18
          adrac.server19.dasbo.nl.: 10.0.42.19
          adrac.server20.dasbo.nl.: 10.0.42.20
          adrac.server21.dasbo.nl.: 10.0.42.21
          adrac.server22.dasbo.nl.: 10.0.42.22
          adrac.server23.dasbo.nl.: 10.0.42.23
          adrac.server24.dasbo.nl.: 10.0.42.24
          adrac.server25.dasbo.nl.: 10.0.42.25

    25.168.192.in-addr.arpa:                      # auto-generated reverse zone
      file: 25.168.192.in-addr.arpa.txt
      soa:                                        # Declare the SOA RRs for the zone
        ns: hv-vm1.dasbo.nl.                     # Required
        contact: admin.dasbo.nl.                    # Required
        serial: auto                              # autoupdate serial on each change
        class: IN                                 # Optional. Default: IN
        refresh: 8600                             # Optional. Default: 12h
        retry: 900                                # Optional. Default: 15m
        expiry: 86000                             # Optional. Default: 2w
        NS:
        nxdomain: 500                             # Optional. Default: 1m
        ttl: 8600                                 # Optional. Not set by default
      records:
        NS:                                    # Records for the zone, grouped by type
          '@':
            hv-vm1.dasbo.nl.
      generate_reverse:                           # take all A records from example.com that are in 1.2.3.0/24 subnet
        net: 192.168.25.0/24                           # and generate reverse records for them
        for_zones:
          - dasbo.nl                         # example.com is a zone defined in pillar, see above

    127.0.10.in-addr.arpa:                      # auto-generated reverse zone
      file: 127.0.10.in-addr.arpa.txt
      soa:                                        # Declare the SOA RRs for the zone
        ns: hv-vm1.dasbo.nl                     # Required
        contact: admin.dasbo.nl                    # Required
        serial: auto                              # autoupdate serial on each change
        class: IN                                 # Optional. Default: IN
        refresh: 8600                             # Optional. Default: 12h
        retry: 900                                # Optional. Default: 15m
        expiry: 86000                             # Optional. Default: 2w
        NS:
        nxdomain: 500                             # Optional. Default: 1m
        ttl: 8600                                 # Optional. Not set by default
      records:
        NS:                                    # Records for the zone, grouped by type
          '@':
            hv-vm1.dasbo.nl.
      generate_reverse:                           # take all A records from example.com that are in 1.2.3.0/24 subnet
        net: 10.0.127.0/24                           # and generate reverse records for them
        for_zones:
          - dasbo.nl                         # example.com is a zone defined in pillar, see above

    50.0.10.in-addr.arpa:                      # auto-generated reverse zone
      file: 50.0.10.in-addr.arpa.txt
      soa:                                        # Declare the SOA RRs for the zone
        ns: hv-vm1.dasbo.nl                     # Required
        contact: admin.dasbo.nl                    # Required
        serial: auto                              # autoupdate serial on each change
        class: IN                                 # Optional. Default: IN
        refresh: 8600                             # Optional. Default: 12h
        retry: 900                                # Optional. Default: 15m
        expiry: 86000                             # Optional. Default: 2w
        NS:
        nxdomain: 500                             # Optional. Default: 1m
        ttl: 8600                                 # Optional. Not set by default
      records:
        NS:                                    # Records for the zone, grouped by type
          '@':
            hv-vm1.dasbo.nl.
      generate_reverse:                           # take all A records from example.com that are in 1.2.3.0/24 subnet
        net: 10.0.50.0/24                           # and generate reverse records for them
        for_zones:
          - dasbo.nl                         # example.com is a zone defined in pillar, see above


    42.0.10.in-addr.arpa:                      # auto-generated reverse zone
      file: 42.0.10.in-addr.arpa.txt
      soa:                                        # Declare the SOA RRs for the zone
        ns: hv-vm1.dasbo.nl                     # Required
        contact: admin.dasbo.nl                    # Required
        serial: auto                              # autoupdate serial on each change
        class: IN                                 # Optional. Default: IN
        refresh: 8600                             # Optional. Default: 12h
        retry: 900                                # Optional. Default: 15m
        expiry: 86000                             # Optional. Default: 2w
        NS:
        nxdomain: 500                             # Optional. Default: 1m
        ttl: 8600                                 # Optional. Not set by default
      records:
        NS:                                    # Records for the zone, grouped by type
          '@':
            hv-vm1.dasbo.nl.
      generate_reverse:                           # take all A records from example.com that are in 1.2.3.0/24 subnet
        net: 10.0.42.0/24                           # and generate reverse records for them
        for_zones:
          - dasbo.nl                         # example.com is a zone defined in pillar, see above
