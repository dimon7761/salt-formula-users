######################################################################################################################################################################################
#																						     
#                      Formula for manage users v1.0 
#                      Dmitriy Litvin 2018
#
######################################################################################################################################################################################
#
#   Introduction:  This formula add and remove user from systems. Optionally, packages can be added: sudo, mc, nano if you specify this in your top.sls 
#
######################################################################################################################################################################################
#
# Install:
#
# 1. Put formula files in to your directory specified in the master-server settings and deploy formulas in your top.sls file, for one or more minion.                                 
# 2. Put pillar files (tests/pillar) in to your pillar directory specified in the master-server settings and deploy pillars in your top.sls pillar directory, for one or more minion.
# 3. Edit pillar users/minion_1.sls and users/minion_2.sls etc for your settings observing keys, if action is not required, leave value blank.
#
######################################################################################################################################################################################
#
# Example config:                   # Add user petya with optional parameters and delete user vasya
#
# userdata:
#   uuser: vasya                    # Specify the user to remove from system, if name blank - nothing will not be deleted. 
#   user: petya                     # Specify name of the user you are creating, if name blank - user will not created.
#   full_name: Petya S.             # Optional, identify full user name. (if blank will be default)
#   home: /home/petya666            # Optional, identify user home directory. (if blank will be default)
#   uid: 1010                       # Optional, identify user uid. (if blank will be default)
#   gid: 1010                       # Optional, identify user gid. (if blank will be default)
#   groups:                         # Optional, identify user additional groups.
#     - games                       # Add one or more.
#     - root
#   sudo: true                      # If true, user will use "sudo su" command (without entering password).
#   clear_key: false                # If true, will be deleted all previously added ssh public key for added/modified user.
#   pub_key:                        # Ssh public keys for authorization.
#     - tests/key1.pub              # Add one or more.
#     - tests/key2.pub
#
######################################################################################################################################################################################
#
# Example_1 config:                 # Add for exist user petya new key and delete all old keys and modify home directory.
#
# userdata:
#   uuser:                    
#   user: petya                     # Specify name of the user you are creating, if name blank - user will not created.
#   full_name: Petya S.             # Optional, identify full user name. (if blank will be default)
#   home: /home/petya777            # Modify home directory.
#   uid: 1010                       # Optional, identify user uid. (if blank will be default)
#   gid: 1010                       # Optional, identify user gid. (if blank will be default)
#   groups:                         # Optional, identify user additional groups.
#     - games                       # Add one or more.
#     - root
#   sudo: true                      # If true, user will use "sudo su" command (without entering password).
#   clear_key: true                 # If true, will be deleted all previously added ssh public key for added/modified user.
#   pub_key:                        # Ssh public keys for authorization.
#     - tests/key3.pub              # Add one or more.
#
######################################################################################################################################################################################
#
# Example_2 config:                 # Add user without optional parameters and not delete anyone
#
# userdata:
#   uuser:                         
#   user: microsoft                 # Specify name of the user you are creating, if name blank - user will not created.
#   full_name:                      # Default value.
#   home:                           # Default value.
#   uid:                            # Default value.
#   gid:                            # Default value.
#   groups:                         # Without additional groups.
#   sudo: false                     # User can not use "sudo su".
#   clear_key: true                 # Previously keys are deleted, if they were created earlier.
#   pub_key:                        # Ssh public keys for authorization.
#     - tests/key666.pub            # Add one or more.
#
######################################################################################################################################################################################
#
# Example_3 config:                 # Delete user
#
# userdata:
#   uuser: dazdraperma              # Delete user and his group and home.                                                                                        
#   user:                           # Not create anyone.
#   full_name:                                                                    
#   home:                                                                               
#   uid:                                                                    
#   gid:                                                                     
#   groups:                                          
#   sudo:                           
#   clear_key:                                        
#   pub_key:                        
#
######################################################################################################################################################################################
#
# Thanks for use my solt formula, do you have any questions? write to dmitriy.litvin@dlnet.kharkov.com
#
######################################################################################################################################################################################
