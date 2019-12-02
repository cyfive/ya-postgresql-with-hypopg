FROM centos:8

LABEL maintainer="Stanislav V. Emets <emetssv@mail.ru>"

RUN dnf -y install glibc-langpack-en && \
	dnf -y install https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm && \
	dnf -y install epel-release dnf-utils && \
	dnf -y module disable postgresql && \
	dnf -y install postgresql12-server postgresql12 hypopg_12 && \
	dnf -y clean all 

COPY ./entrypoint.sh /entrypoint.sh

ENV LANG en_US.utf8
ENV PGDATA /var/lib/pgsql/12/data/

EXPOSE 5432

#USER postgres

ENTRYPOINT ["/entrypoint.sh"]
