FROM ubuntu:18.04

ENV container docker
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive

ENV PERSISTENT_DIR /etc/persistent
ENV DATA_DIR /mnt/data

RUN apt-get update \
	&& apt-get install -y \
		systemd systemd-sysv \
		dnsmasq \
	&& apt-get install -y --no-install-recommends \
		openssh-client openssh-server openssh-sftp-server \
		git rsync \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# system cleanup
#RUN find /lib/systemd/system/sysinit.target.wants/ -type f \
#	| grep -v systemd-tmpfiles-setup | xargs rm -f
#RUN find /lib/systemd/system/multi-user.target.wants/ -type f \
#	| xargs rm -f

RUN find /etc/systemd/system \
    /lib/systemd/system \
    -path '*.wants/*' \
    -not -name '*dbus*' \
    -not -name '*journald*' \
    -not -name '*systemd-tmpfiles*' \
    -not -name '*systemd-user-sessions*' \
    -exec rm \{} \;
RUN sed -i -e 's:^IPAddressDeny:#IPAddressDeny:' /lib/systemd/system/systemd-journald.service
RUN systemctl set-default multi-user.target
RUN systemctl mask dev-hugepages.mount sys-fs-fuse-connections.mount

COPY files/etc /etc

ADD https://raw.githubusercontent.com/promitilus/rr-ssh/production/rr-ssh /usr/local/bin

RUN touch /etc/.NOT_CONFIGURED

RUN rm -vf /etc/ssh/ssh_host_*
RUN systemctl enable inherit-env boot.d ssh

# external volumes
VOLUME ["/sys/fs/cgroup", "/tmp", "/run", "/run/lock"]
VOLUME [ "$PERSISTENT_DIR" ]
VOLUME [ "$DATA_DIR" ]

ENTRYPOINT [ "/sbin/init" ]

EXPOSE 22:2222
