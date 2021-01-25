KEYBOARD_LAYOUT: en_US
LOCALE: en_US.UTF-8
nameservers:
  - 127.0.0.53


enable_hosts_deny: True
hosts_deny:
  ALL:
    - ALL
    - EXCEPT
    - 192.168.8.0/24
    - 192.168.25.0/24
    - 86.55.30.5
