# -*- coding: utf-8; mode:yaml; tab-width:2; indent-tabs-mode:nil; -*-
# vim: syntax=yaml ts=2 sw=2 sts=2 et si ai

Install xrdp:
  pkg.installed:
    - name: xrdp

Manage xrdp config:
  file.managed:
    - name: /etc/xrdp/xrdp.ini
    - source: salt://xrdp/files/xrdp.ini
    - require:
      - Install xrdp

Run xrdp:
  service.running:
    - name: xrdp.service
    - enable: True
    - watch:
      - Manage xrdp config
    - require:
      - Manage xrdp config

Install x11vnc:
  pkg.installed:
    - name: x11vnc

Create systemd x11vnc service:
  file.managed:
    - name: /lib/systemd/system/vnc.service
    - source: salt://xrdp/files/vnc.service

Run vnc:
  service.running:
    - name: vnc.service
    - enable: True
    - watch:
      - Create systemd x11vnc service
    - require:
      - Create systemd x11vnc service
      - Install x11vnc

