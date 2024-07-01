FROM alpine:3.19

ARG FS_USER \
    FS_USER_PASS

WORKDIR /var/www/html

RUN apk update && apk upgrade && apk  add --no-cache \
    vsftpd && \
    adduser -h /var/www/html -s /bin/false -D ${FS_USER} && \
    echo "${FS_USER}:${FS_USER_PASS}" | /usr/sbin/chpasswd && \
    adduser ${FS_USER} root && \
    sed -i "s|#chroot_local_user=YES|chroot_local_user=YES|g"  /etc/vsftpd/vsftpd.conf && \
    sed -i "s|#local_enable=YES|local_enable=YES|g"  /etc/vsftpd/vsftpd.conf && \
    sed -i "s|#write_enable=YES|write_enable=YES|g"  /etc/vsftpd/vsftpd.conf && \
    sed -i "s|#local_umask=022|local_umask=007|g"  /etc/vsftpd/vsftpd.conf && \
    echo "allow_writeable_chroot=YES" >> /etc/vsftpd/vsftpd.conf &&\
    echo 'seccomp_sandbox=NO' >> /etc/vsftpd/vsftpd.conf && \
    echo 'pasv_enable=YES' >> /etc/vsftpd/vsftpd.conf

EXPOSE 21

CMD [ "/usr/sbin/vsftpd", "/etc/vsftpd/vsftpd.conf" ]