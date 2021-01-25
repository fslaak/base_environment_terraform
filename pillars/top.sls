base:
  '*':
    - basic_config
    - bind-pillar
    - postfix-pillar
    - nginx-pillar
    - firewall-settings
    - dhcpd
    - desktops
    - servers
    - users
  'hv-vm2.dasbo.nl':
    - firewall-hv-vm1
  'hv-vm1.dasbo.nl':
    - firewall-hv-vm2
