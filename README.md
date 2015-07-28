win_pendingreboot
=========

This Ansible role lets you check for an optionally perform reboots on Windows nodes. During the reboot cycle it will use a local task on the control node to check when the node is back online.


Requirements
------------

N/A

Role Variables
--------------
Setting simulate to yes will force the role to think the node has a pending reboot and act accordingly
simulate: no

#reboot_behavior controls when to reboot the node. valid options are: never, if_required, always
reboot_behavior: if_required

#cooldown_period: amount of time (in seconds) after reboot is initiated before we start testing if the node is back up.
#for systems which take time to shutdown this can be increased (although it slows down the overall execution)
cooldown_period: 10

#Number of retries before giving up waiting for the node to come back online
winrm_retries: 30

#delay is the interval between each test if the node is back online (in seconds).
#This number is in addition to the 10-second timeout of the winrm command itself, so 10 here= 20
winrm_delay: 3

Dependencies
------------

N/A

Example Playbook
----------------

    - hosts: windows01*
      roles:
        - role: winreboot
          simulate: yes
    - hosts: windows02*
      roles:
        - role: winreboot

License
-------

BSD

Author Information
------------------

Trond Hindenes. Module has been tested on Windows Server 2012R2 with Ubuntu 14.04 as the control node.
