Ubuntu-lighthouse
=========

Install Nginx+Lighthouse

Requirements
------------

Ubuntu 20.04+

Role Variables
--------------

| Variable | Default | Description
|-|-|-|
| `path`  | `/home/{{ansible_user}}/lightgouse` | Path to install Lighthouse |

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: lighthouse-hosts
      roles:
         - lighthouse
      become: true
      vars:
         - path: "/home"

License
-------

MIT

Author Information
------------------

Kirill Kirsanov for Netology HW