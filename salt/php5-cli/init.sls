# vi: set ft=yaml.jinja :

{% from 'php5-cli/map.jinja' import map with context %}

include:
  -  php5

php5-cli:
  pkg.installed:
    - name:     {{ map.get('pkg', {}).get('name') }}
   {% if salt['config.get']('os_family') == 'RedHat' %}
    - require:
      - pkgrepo:   ius
   {% endif %}
