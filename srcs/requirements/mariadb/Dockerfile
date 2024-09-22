FROM debian:bullseye

RUN apt update && apt install -y mariadb-server
RUN chown -R mysql:mysql /var/lib/mysql/

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY tools/setup-mysql.sh .

RUN mkdir /run/mysqld && chmod +x setup-mysql.sh

CMD ["./setup-mysql.sh"]