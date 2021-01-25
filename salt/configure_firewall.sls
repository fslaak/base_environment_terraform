{%- set profiles = pillar.get('firewall_profiles') %}
{%- set services = pillar.get('firewall_services') %}

firewalld_package:
  pkg.installed:
    - name: firewalld
    - allow_updates: True

firewall_service:
  service.running:
    - name: firewalld
    - reload: True

{%- for service, data in services.items() %}
firewall_{{ service }}:
  firewalld.service:
    - name: {{ data['name'] }}
    - ports:
{%-   for port in data['ports'] %}
      - {{ port }}
{%-   endfor %}
{%- endfor %}

{%- for profile, zones in profiles.items() %}
{%-  if profile == pillar.get('firewall_profile') %}
{%-   for zone, data in zones.items() %}
{{ profile }}_{{ zone }}:
  firewalld.present:
    - name: {{ data['name'] }}
{%-     if data['services'] is defined %}
    - services:
{%-       for service in data['services'] %}
      - {{ service }}
{%-       endfor %}
{%-       endif %}
{%-     if data['default'] is defined %}
    - default: {{ data['default'] }}
{%-     endif %}
{%-     if data['block_icmp'] is defined %}
    - block_icmp:
{%-       for block in data['block_icmp'] %}
      - {{ block }}
{%-        endfor %}
{%-     endif %}
{%-     if data['prune_block_icmp'] is defined %}
    - prune_block_icmp: {{ data['prune_block_icmp'] }}
{%-     endif %}
{%-     if data['ports'] is defined %}
    - ports:
{%-       for port in data['ports'] %}
      - {{ port }}
{%-        endfor %}
{%-     endif %}
{%-     if data['prune_ports'] is defined %}
    - prune_ports: {{ data['prune_ports'] }}
{%-     endif %}
{%-     if data['port_fwd'] is defined %}
    - port_fwd:
{%-       for forward in data['port_fwd'] %}
      - {{ forward }}
{%-        endfor %}
{%-     endif %}
{%-     if data['prune_port_fwd'] is defined %}
    - prune_port_fwd: {{ data['prune_port_fwd'] }}
{%-     endif %}
{%-     if data['prune_services'] is defined %}
    - prune_services: {{ data['prune_services'] }}
{%-     endif %}
{%-     if data['interfaces'] is defined %}
    - interfaces:
{%-       for interface in data['interfaces'] %}
      - {{ interface }}
{%-        endfor %}
{%-     endif %}
{%-     if data['prune_interfaces'] is defined %}
    - prune_interfaces: {{ data['prune_interfaces'] }}
{%-     endif %}
{%-     if data['prune_sources'] is defined %}
    - prune_sources: {{ data['prune_sources'] }}
{%-     endif %}
{%-     if data['sources'] is defined %}
    - sources:
{%-       for source in data['sources'] %}
      - {{ source }}
{%-        endfor %}
{%-     endif %}
{%-     if data['rich_rules'] is defined %}
    - rich_rules:
{%-       for rich in data['rich_rules'] %}
      - {{ rich }}
{%-        endfor %}
{%-     endif %}
{%-     if data['prune_rich_rules'] is defined %}
    - prune_rich_rules: {{ data['prune_rich_rules'] }}
{%-     endif %}
{%-   endfor %}
{%-  endif %}
{%- endfor %}
