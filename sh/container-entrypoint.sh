#!/bin/bash

service oracle-xe restart

export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
export ORACLE_SID=XE
export PATH=$PATH:/u01/app/oracle/product/11.2.0/xe/bin

sqlplus sys/oracle as sysdba << EOF
   set heading off;
   set pagesize 0;
   alter profile default limit PASSWORD_LIFE_TIME UNLIMITED;
   alter user sys identified by oracle;
   alter user system identified by oracle;
   exit;
EOF

for f in /docker-entrypoint-initdb.d/*; do
  [ -f "$f" ] || continue
  case "$f" in
    *.sh)     echo "$0: running $f"; . "$f" ;;
    *.sql)    echo "$0: running $f"; echo "exit" | sqlplus "SYS/oracle" AS SYSDBA @"$f"; echo ;;
    *)        echo "$0: ignoring $f" ;;
  esac
  echo
done

echo "#########################"
echo "DATABASE IS READY TO USE!"
echo "#########################"

tail -f /dev/null 
