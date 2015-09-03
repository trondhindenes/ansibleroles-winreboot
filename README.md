win_reboot
=========
[![Platforms](http://img.shields.io/badge/platforms-windows-lightgrey.svg?style=flat)](#)

This Ansible role lets you check for an optionally perform reboots on Windows nodes. During the reboot cycle it will use a local task on the control node to check when the node is back online.


Requirements
------------

N/A

Role Variables (with defaults indicated)
--------------

###winreboot_simulate: no
Setting winreboot_simulate to yes will force the role to think the node has a pending reboot and act accordingly

###winreboot_reboot_behavior: if_required
winreboot_reboot_behavior controls when to reboot the node. valid options are: never, if_required, always

###winreboot_cooldown_period: 10
winreboot_cooldown_period: amount of time (in seconds) after reboot is initiated before we start testing if the node is back up.
for systems which take time to shutdown this can be increased (although it slows down the overall execution)

###winreboot_winrm_retries: 30
Number of retries before giving up waiting for the node to come back online

###winreboot_winrm_delay: 3
delay is the interval between each test if the node is back online (in seconds).
This number is in addition to the 10-second timeout of the winrm command itself, so 10 here= 20


Dependencies
------------

N/A

Example Playbook
----------------

    - hosts: windows-web
      roles:
        - role: trondhindenes.win_reboot
      vars:
        winreboot_simulate: yes

    - hosts: windows-db
      roles:
        - role: trondhindenes.win_reboot

License
-------

BSD

Author Information
------------------

Trond Hindenes. Module has been tested on Windows Server 2012R2 with Ubuntu 14.04 as the control node.
