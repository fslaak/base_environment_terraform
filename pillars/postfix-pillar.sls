# -*- coding: utf-8 -*-
# vim: ft=yaml
---
postfix:
  manage_master_config: true
  master_config:
    # Preferred way of managing services/processes. This allows for finegrained
    # control over each service. See postfix/services.yaml for defaults that can
    # be overridden.
    services:
      smtp:
        # Limit to no more than 10 smtp processes
        maxproc: 5
      # Enable oldstyle TLS wrapped SMTP
      smtps:
        enable: true
      # Enable submission service on port 587/tcp with custom options
      submission:
        enable: true
        args:
          - "-o smtpd_tls_security_level=encrypt"
          - "-o smtpd_sasl_auth_enable=yes"
          - "-o smtpd_client_restrictions: permit_sasl_authenticated,reject"
      tlsproxy:
        enable: true
        chroot: true
      uucp:
        enable: true

    # Backwards compatible definition of submission listener in master.cf
    enable_submission: false
    # To replace the defaults use this:
    submission:
      smtpd_tls_security_level: encrypt
      smtpd_sasl_auth_enable: 'yes'
      smtpd_client_restrictions: permit_sasl_authenticated,reject

  enable_service: true
  reload_service: true


  policyd-spf:
    enabled: true
    time_limit: 7200s

  config:
    default_database_type: hash
    smtpd_banner: $myhostname ESMTP $mail_name
    smtp_tls_CApath: /etc/ssl/certs
    biff: 'no'
    append_dot_mydomain: 'yes'
    readme_directory: 'no'
    mydomain: dasbo.nl
    myhostname: mail.dasbo.nl
    myorigin: dasbo.nl
    mydestination: localhost, mail.dasbo.nl, hv-vm1, hv-vm1.dasbo.nl, dasbo.nl
    mynetworks: 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128 145.100.105.176/28 145.100.96.0/24
    mailbox_size_limit: 0
    recipient_delimiter: +
    inet_interfaces: all
    inet_protocols: all
    mailbox_command: procmail -a "$EXTENSION"
    virtual_mailbox_base: /var/spool/mail

    # Alias
    alias_maps: hash:/etc/aliases
    # This is the list of files for the newaliases
    # cmd to process (see postconf(5) for details).
    # Only local hash/btree/dbm files:
    alias_database: hash:/etc/aliases

    local_transport: virtual
#    local_recipient_maps: $virtual_mailbox_maps
#    transport_maps: hash:/etc/postfix/transport

    # SMTP server
    smtpd_tls_session_cache_database: btree:${data_directory}/smtpd_scache
    smtpd_use_tls: 'no'
    smtpd_sasl_auth_enable: 'no'
    smtpd_sasl_type: dovecot
    smtpd_sasl_path: /var/run/dovecot/auth-client
    smtpd_recipient_restrictions: >-
      permit_mynetworks,
      permit_sasl_authenticated,
      reject_unauth_destination
    smtpd_relay_restrictions: >-
      permit_mynetworks,
      permit_sasl_authenticated,
      reject_unauth_destination
    smtpd_sasl_security_options: noanonymous
    smtpd_sasl_tls_security_options: $smtpd_sasl_security_options
    smtpd_tls_auth_only: 'no'
    smtpd_sasl_local_domain: $mydomain
    smtpd_tls_loglevel: 1
    smtpd_tls_session_cache_timeout: 3600s

    relay_domains: '$mydestination'

    # SMTP server certificate and key (from pillar data)
    smtpd_tls_cert_file: /etc/postfix/ssl/server-cert.crt
    smtpd_tls_key_file: /etc/postfix/ssl/server-cert.key

    # SMTP client
    smtp_tls_session_cache_database: btree:${data_directory}/smtp_scache
    smtp_use_tls: 'no'

    smtp_sasl_password_maps: hash:/etc/postfix/sasl_passwd
    sender_canonical_maps: hash:/etc/postfix/sender_canonical
    relay_recipient_maps: hash:/etc/postfix/relay_domains
#    virtual_alias_maps: hash:/etc/postfix/virtual

  mapping:
    sender_canonical_maps:
      - root: admin@dasbo.nl

    relay_recipient_maps:
      - dasbo.nl: OK


  aliases:
    # manage single aliases
    # this uses the aliases file defined in the minion config, /etc/aliases by default
    use_file: true
    present:
      root: fr@dasbo.nl
      postmaster: fr@dasbo.nl
