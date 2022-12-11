FROM ghcr.io/gaizkaurd/rails-base-builder-3.1.2:3.1.2-alpine AS Builder


FROM ghcr.io/gaizkaurd/rails-base-final-3.1.2:3.1.2-alpine

# Workaround to trigger Builder's ONBUILDs to finish:
COPY --from=Builder /etc/alpine-release /tmp/dummy

# CLOUDTASKER LIBRARY
RUN ln -s /lib/libc.musl-x86_64.so.1 /lib/ld-linux-x86-64.so.2

USER app

ENTRYPOINT ["docker/startup.sh"]