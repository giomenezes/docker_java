FROM mysql:latest

ENV MYSQL_ROOT_PASSWORD=urubu100

COPY ./init /docker-entrypoint-initdb.d/ 

ENV MYSQL_USER=aluno
ENV MYSQL_PASSWORD=sptech
ENV MYSQL_DATABASE=gct_individual

EXPOSE 3306
