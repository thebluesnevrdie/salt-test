# -*- coding: utf-8; mode:yaml; tab-width:2; indent-tabs-mode:nil; -*-
# vim: syntax=yaml ts=2 sw=2 sts=2 et si ai

{% set ttyd_port = "22022" %}
{% set ttyd_source = "https://github.com/tsl0922/ttyd/releases/download" %}
{% set ttyd_version = "1.6.1" %}

Get ttyd binary:
  file.managed:
    - name: /usr/local/bin/ttyd
    - user: root
    - group: root
    - mode: 700
    - source: {{ ttyd_source }}/{{ ttyd_version }}/ttyd_linux.x86_64
    - source_hash: {{ ttyd_source }}/{{ ttyd_version }}/SHA256SUMS

Create systemd ttyd service:
  file.managed:
    - name: /lib/systemd/system/ttyd.service
    - source: salt://ttyd/files/ttyd.service.jinja
    - template: jinja
    - defaults:
        port: {{ ttyd_port }}
    
Run ttyd:
  service.running:
    - name: ttyd.service
    - enable: True
    - watch:
      - Create systemd ttyd service
    - require:
      - Create systemd ttyd service
      - Get ttyd binary
