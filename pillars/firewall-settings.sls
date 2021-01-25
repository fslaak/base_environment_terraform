
firewall_profiles:
  web:
    public:
      name: public
      services:
        - ssh
        - web

firewall_services:
  web:
    name: web
    ports:
      - 80/tcp
      - 443/tcp
  mail:
    name: mail
    ports:
      - 25/tcp
      - 587/tcp
      - 465/tcp
