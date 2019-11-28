FROM centos:8

LABEL maintainer="Stanislav V. Emets <emetssv@mail.ru>"

#prepare container to use systemd
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
	systemd-tmpfiles-setup.service ] || rm -f $i; done); \
	rm -f /lib/systemd/system/multi-user.target.wants/*;\
	rm -f /etc/systemd/system/*.wants/*;\
	rm -f /lib/systemd/system/local-fs.target.wants/*; \
	rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
	rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
	rm -f /lib/systemd/system/basic.target.wants/*;\
	rm -f /lib/systemd/system/anaconda.target.wants/*;


#sudo yum -y install  yum-utils

RUN dnf -y install https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm && \
	dnf -y install epel-release dnf-utils && \
	dnf -y module disable postgresql && \
	dnf -y install postgresql12-server postgresql12 hypopg_12 && \
	dnf -y clean all && \
	systemctl enable postgresql-12
                     
#RUN yum -y install httpd; yum clean all; systemctl enable httpd.service

VOLUME [ "/sys/fs/cgroup" ]

CMD ["/usr/sbin/init"]