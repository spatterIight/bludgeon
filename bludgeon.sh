#!/bin/bash                                                                                                                                                     
while true                                                                                                                                                      
do                                                                                                                                                              
        suspect="$(tac access.log | grep -m 1 ".*\.m3u8")"                                                                                                      
        if [ -n "$suspect" ]; then                                                                                                                              
                suspect="$(echo $suspect | cut -c 1-15 | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')"                                            
                if $(ipset list | grep -q $suspect); then                                                                                                       
                        :                                                                                                                                       
                else                                                                                                                                            
                        ipset -A blockedip $suspect                                                                                                             
                fi                                                                                                                                              
        fi                                                                                                                                                      
        sleep 5                                                                                                                                                 
done
