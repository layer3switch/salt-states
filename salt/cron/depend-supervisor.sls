# vi: set ft=yaml.jinja :

{% set psls = sls.split('.')[0] %}

include:
  -  cron
  -  supervisor

cron:
  supervisord.running:
    - watch:
      - service:   supervisor
      - file:     /usr/bin/cron

/etc/supervisor/conf.d/{{ psls }}.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ psls }}/etc/supervisor/conf.d/{{ psls }}.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - require:
      - file:     /usr/bin/supervisord
    - require_in:
      - service:   supervisor
    - watch_in:
      - cmd:       supervisorctl update &
