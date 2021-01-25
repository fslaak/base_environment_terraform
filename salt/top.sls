base:
  '*':
    - basic_config
    - users
    - users.sudo
    - users.bashrc
  'hv-vm1.dasbo.nl':
    - bind
    - bind.config
    - dhcpd
    - dhcpd.config
    - dhcp_static_leases
    - postfix
    - postfix.config
  'hv-vm2.dasbo.nl':
    - nginx.pkg
    - nginx.config
    - nginx.service
    - nginx.servers
    - create_homepage
