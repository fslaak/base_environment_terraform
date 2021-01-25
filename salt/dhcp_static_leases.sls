
dhcpd_leases_file:
  file.managed:
    - name: /etc/dhcp/dhcpd_leases.conf
    - user: root
    - group: root
    - mode: 0644
    - source: salt://{{ slspath }}/templates/dhcpd_leases.conf
    - show_changes: True
    - template: jinja
