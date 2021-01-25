# -*- coding: utf-8 -*-
# vim: ft=yaml
---
# ========
# nginx (previously named nginx:ng)
# ========

nginx:
  # The following three `install_from_` options are mutually exclusive. If none
  # is used, the distro's provided package will be installed. If one of the
  # `install_from` option is set to `true`, the state will make sure the other
  # two repos are removed.

  # Use the official's nginx repo binaries
  install_from_repo: True
  lookup:
    package: nginx
    service: nginx
    webuser: www-data
    conf_file: /etc/nginx/nginx.conf
    server_available: /etc/nginx/sites-available
    server_enabled: /etc/nginx/sites-enabled
    server_use_symlink: true
    pid_file: /var/run/nginx.pid
  service:
    enable: true  # Whether or not the service will be enabled/running or dead
    opts: {}  # this partially exposes parameters of service.running / service.dead

  ## - - --  - - -- -- - - --- -- - -- - - - -- - - - - -- - - - -- - - - -- - ##
  ## You can use snippets to define often repeated configuration once and
  ## include it later # The letsencrypt example below is consumed by "- include:
  ## 'snippets/letsencrypt.conf'" # Files or Templates can be retrieved by TOFS
  ## with snippet name ( Fallback to server.conf )
  ## - - --  - - -- -- - - --- -- - -- - - - -- - - - - -- - - - -- - - - -- - ##

  server:
    config:
      http:
        ### module ngx_http_log_module example
        log_format: |-
          main '$remote_addr - $remote_user [$time_local] $status '
                              '"$request" $body_bytes_sent "$http_referer" '
                              '"$http_user_agent" "$http_x_forwarded_for"'
  servers:
    managed:
      default:
        deleted: true
        enabled: false
        config: {}

      mysite:
        enabled: true
        config:
          - server:
              - server_name: localhost.john
              - listen:
                  - '80 default_server'
              - index: 'index.html index.htm'
              - location ~ .htm:
                  - try_files: '$uri $uri/ =404'

  dh_param:
    'mydhparam2.pem':
      keysize: 2048
