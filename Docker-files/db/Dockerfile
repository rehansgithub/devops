FROM mysql:8.0.33 
LABEL ""
LABEL
ENV MYSQL_ROOT_PASSWORD=""
ENV MYSQL_DATABASE""

ADD db_backup.sql docker-entrypoint-initdb.d/db_backup.sql
