Ubuntu-vector
=========

Install vector and configure it to use witch Clickhouse

Requirements
------------

Ubuntu 20.04+

Role Variables
--------------

| Variable | Default | Description
|-|-|-|
| `vector_version`  | `latest` | Vector version for install |
| `clickhouse_host` | `127.0.0.1` | Clickhouse host |
| `clickhouse_port` | `8123` | Clickhouse http-port |
| `clickhouse_db`   | `logs` | DB-name on clickhoouse |
| `db_table` | `access_logs` | Table on DB |
| `src` |  `/var/log/auth.log` | Source file for logs |

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: vector-hosts
      roles:
         - vector
      become: true
      vars:
         - clickhouse_host: "clickhouse"
         - clickhouse_db: "syslog"
         - db_table: "vector_logs"
         - src: "/var/log/system.log"


License
-------

MIT

Author Information
------------------

Kirill Kirsanov for Netology HW