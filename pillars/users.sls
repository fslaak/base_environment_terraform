


groups:
  www-data:
    state: present

users:
  www-data:
    fullname: www-data
    createhome: true
    system: true
    home: /var/www
    homedir_owner: www-data
    homedir_group: www-data
    user_dir_mode: 774
    manage_vimrc: false
    allow_gid_change: false
    manage_bashrc: false
    manage_profile: false
    shell: /bin/false
    groups:
      - users
    sudouser: false
  ## Minimal required pillar values
  freek:
    fullname: freek
    createhome: true
    groups:
      - users
    ssh_key_type: ecdsa
    sudouser: true
    homepage: true
