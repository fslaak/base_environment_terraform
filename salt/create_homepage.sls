{%- set users =  salt['pillar.get']('users') %}

{%- for key, data in users.items() %}
{%-   if data.homepage is defined %}
{%-     if data.homepage %}
{{ key }}homepage:
  file.managed:
    - name: /usr/share/nginx/html/{{ key }}.html
    - user: root
    - group: root
    - mode: 0644
    - source: salt://{{ slspath }}/templates/template.html
    - show_changes: True
    - template: jinja
    - context:
        user: {{ key }}
{%-     endif %}
{%-   endif %}
{%- endfor %}
