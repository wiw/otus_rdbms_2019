FROM mysql:8.0

ENV MYSQL_ROOT_PASSWORD=otus

ADD cafe_db.sql /docker-entrypoint-initdb.d/
ADD fill_db.sql /docker-entrypoint-initdb.d/

EXPOSE 3306