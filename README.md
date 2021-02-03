[![Ansible-Test](https://github.com/mediafellows/ansible-role-logrotate/workflows/Ansible-Test/badge.svg)](https://github.com/mediafellows/ansible-role-logrotate/actions?query=workflow%3AAnsible-Test)

# Ansible role for Logrotate

Installs and configures logrotate (adds files to `/etc/logrotate.d/`).

This role is somehat opinionated to make the list of parameters more concise.
It uses a bunch of good practise flags you commonly won't want to override (compress, copytruncate etc.).
It also has some fallback settings if you don't want to define each log file settings seperately, those can be overriden though.
See below.

## Requirements
No additional requirements. Meant to be run against an Ubuntu machine, might also work for other Debian flavors.

## Role Variables

The role add configuration for all files specified in a list of dictionaries. Like this:

```yaml
logrotate_file_list:
  - { name: my_app, path: /path/to/log/file.log }
```

Unless specified in file list it will use the global variables for logrotate settings:

```yaml
logrotate_interval: weekly
logrotate_max_size: 100M
logrotate_max_files: 8
```

Which you can set to your liking too by just overriding them in your playbook,
or by adding file specific params like this:

```yaml
logrotate_file_list:
  - { name: my_app, path: /my/file.log, interval: daily, max_size: 50M, max_files: 2 }
```
Those variables have precendence over the global ones.

## Dependencies
Depends on no other Ansible roles.

## Example Playbook
This is an example on how you can include this role into your playbook:

```yaml
- name: My playbook
  hosts: servers
  vars:
    logrotate_file_list:
      - { name: webapp1, path: /opt/webapps/my_webapp_1/logs/production.log }
      - { name: webapp2, path: /opt/webapps/my_webapp_2/logs/production.log }
    logrotate_max_size: 50M
    logrotate_max_files: 7
  roles:
    - mediafellows.logrotate
```
Assuming you pulled the role into your projects role dir (like `roles/mediafellows.logrotate`).

## License
BSD, as-is.

## Author Information
Stefan Horning for Mediafellows.com
