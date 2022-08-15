FROM wnameless/oracle-xe-11g-r2

ADD sh /tmp/sh

ENV DEBIAN_FRONTEND=noninteractive TZ=Asia/Tokyo

RUN apt-get update \
    && apt install -y tzdata \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    && chmod 777 -R /tmp/sh \
    && mv /tmp/sh/healthcheck.sh /u01/app/oracle \
    && mv /tmp/sh/container-entrypoint.sh /u01/app/oracle \
    && /usr/sbin/startup.sh \
    && sed -i "s/HOST = .*)(/HOST = 0.0.0.0)(/g" /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora \
    && su oracle -c '/tmp/sh/createdb.sh'

ENV ORACLE_BASE=/u01/app/oracle \
    ORACLE_BASE_CONFIG=/u01/app/oracle/product/11.2.0/xe \
    ORACLE_BASE_HOME=/u01/app/oracle/product/11.2.0/xe \
    ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe \
    ORACLE_SID=XE \
    PATH=${PATH}:/u01/app/oracle/product/11.2.0/xe/bin:/u01/app/oracle \
    NLS_LANG=.AL32UTF8

WORKDIR ${ORACLE_BASE}

ENTRYPOINT ["container-entrypoint.sh"]
