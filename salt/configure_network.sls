{% set network_settings = pillar.get('network_settings') %}

system:
    network.system:
      - enabled: {{ network_settings['system']['enabled'] }}
      - hostname: {{ network_settings['system']['hostname'] }}
      - gateway: {{ network_settings['system']['gateway'] }}
      - gatewaydev: {{ network_settings['system']['gatewaydev'] }}
      - nozeroconf: {{ network_settings['system']['nozeroconf'] }}
      - nisdomain: {{ network_settings['system']['nisdomain'] }}
      - require_reboot: {{ network_settings['system']['require_reboot'] }}

{% for interface,details in network_settings['interfaces'].items() %}
{{ interface }}:
    network.managed:
      - enabled: {{ details.enabled }}
      - type: {{ details.type }}
      - proto: {{ details.proto }}
      - ipaddr: {{ details.ipaddr }}
      - netmask: {{ details.netmask }}
      - gateway: {{ details.gateway }}
      - mtu: {{ details.mtu }}
# Need ip address to of gatewaydev to update hosts file.
{%-   if interface == network_settings.system.gatewaydev %}
{{ details.ipaddr }}:
  host.only:
    - hostnames: {{ network_settings['system']['hostname'] }}
{%   endif %}
{% endfor %}

