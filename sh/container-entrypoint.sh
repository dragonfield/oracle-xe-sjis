#!/bin/bash

service oracle-xe restart

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
