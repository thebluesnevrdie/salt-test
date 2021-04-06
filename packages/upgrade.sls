Upgrade all packages:
{% if grains['os'] == "Windows" %}
  wua.uptodate
{% else %}
  pkg.uptodate:
    - refresh: True
{% endif %}
