#!/bin/bash

export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
export ORACLE_SID=XE
export PATH=$PATH:/u01/app/oracle/product/11.2.0/xe/bin

sqlplus sys/oracle as sysdba <<EOF
shutdown immediate
startup restrict mount
drop database;
quit
EOF

createdb.sh -shiploc -dbchar JA16SJISTILDE
