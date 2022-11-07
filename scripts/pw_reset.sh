#!/bin/bash
for i in `cat hosts`; do echo $i; ssh $i 'echo -e "p@ssw0rd\np@ssw0rd"| passwd serigineni'; done 

