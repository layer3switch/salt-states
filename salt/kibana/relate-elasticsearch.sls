# vi: set ft=yaml.jinja :

{% set minions = salt['roles.dict']('elasticsearch') %}

include:
  -  kibana

{% if minions['elasticsearch'] %}

/usr/share/kibana/config.js:
  file.replace:
    - pattern:    'elasticsearch: .*'
    - repl:       'elasticsearch: "http://{{ minions['elasticsearch'][0]|default('localhost') }}:9200",'
    - require:
      - file:     /usr/share/kibana
    - watch_in:
      - service:   nginx-common

{% endif %}
