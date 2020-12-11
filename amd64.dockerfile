# :: Header
    FROM bitnami/postgresql-repmgr:11.10.0-debian-10-r26


# :: Run
    USER root

    # :: copy root filesystem changes
        COPY ./rootfs /

    # :: install
        RUN apt-get update -y \
                apt-get install postgresql-client -y

    # :: docker -u 1000:0 (no root initiative)
        RUN find / -not -path "/proc/*" -user 1001 -exec chown -h -R 1000:0 {} \;


# :: Volumes
    VOLUME ["/bitnami/postgresql"]


# :: Monitor
    RUN chmod +x /usr/local/bin/healthcheck.sh
    HEALTHCHECK CMD /usr/local/bin/healthcheck.sh || exit 1


# :: Start
    USER 1000