[![Build Status](https://travis-ci.org/mediapeers/ansible-role-logrotate.svg?branch=master)](https://travis-ci.org/mediapeers/ansible-role-logrotate)

# Ansible Logrotate role

Installs and configures logrotate (adds files to `/etc/logrotate.d/`).

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
    - mediapeers.logrotate
```
Assuming you pulled the role into your projects role dir (like `roles/mediapeers.logrotate`).

## License
BSD

## Author Information
Stefan Horning for Mediapeers.com
