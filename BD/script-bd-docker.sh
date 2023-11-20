docker run --name some-mysql -v C:\Users\User\Documents\docker-volumenes\mysql:/var/lib/mysql -e MYSQL_ALLOW_EMPTY_PASSWORD=yes -p 3306:3306 -p 33060:33060 -d mysql

# docker kill some-mysql
# docker rm some-mysql