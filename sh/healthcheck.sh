#!/bin/bash

set -Eeuo pipefail

export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
export ORACLE_SID=XE
export PATH=$PATH:$ORACLE_HOME/bin

db_status=$(sqlplus -s system/oracle << EOF
   set heading off;
   set pagesize 0;
   SELECT status FROM v\$instance;
   exit;
EOF
)

if [ "${db_status}" == "OPEN" ]; then
   exit 0;
else
   exit 1;
fi;
