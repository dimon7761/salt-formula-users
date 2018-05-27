{% from "users/map.jinja" import userdata with context %}

{% if userdata.uuser %}
{{ userdata.uuser }}:
  user.absent:
    - force: True
    - purge: True

/etc/sudoers.d/{{ userdata.uuser }}:
  file.absent
{% endif %}

{% if userdata.clear_key == True %}
cat /dev/null > $(echo ~{{ userdata.user }})/.ssh/authorized_keys:
  cmd.run
{% endif %}

{% if userdata.user %}
{{ userdata.user }}:  
  
  {% if userdata.gid %}
  group.present:
    - gid: {{ userdata.gid }}
  {% endif %}
  
  user.present:
    {% if userdata.full_name %}
    - fullname: {{ userdata.full_name }}
    {% endif %}
    - shell: /bin/bash
    {% if userdata.home %}
    - home: {{ userdata.home }}
    {% endif %}
    {% if userdata.uid %}
    - uid: {{ userdata.uid }}
    {% endif %}
    {% if userdata.gid %}
    - gid: {{ userdata.gid }}
    {% endif %}
    {% if userdata.groups %}
    - groups: {{ userdata.groups }}
    {% endif %}

{% if userdata.pub_key %}
{% for key in userdata.pub_key  %}
{{ key }}:
  ssh_auth.present:
    - source: salt://{{ key }}
    - config: /%h/.ssh/authorized_keys
    - user: {{ userdata.user }}
{% endfor %}
{% endif %}

{% if userdata.sudo == True %}
/etc/sudoers.d/{{ userdata.user }}:
  file.managed:
    - source: salt://users/templates/sudoers
    - user: root
    - group: root
    - mode: 440
    - template: jinja
    - context:
       user_name: {{ userdata.user }}
{% else %}
/etc/sudoers.d/{{ userdata.user }}:
 file.absent:
    - name: /etc/sudoers.d/{{ userdata.user }}
{% endif %}
{% endif %}



