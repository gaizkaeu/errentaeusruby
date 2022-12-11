FROM ghcr.io/gaizkaurd/rails-base-builder-3.1.2:3.1.3-alpine AS Builder


# Remove some files not needed in resulting image.
# Because they are required for building the image, they can't be added to .dockerignore
RUN rm -r package.json tailwind.config.js postcss.config.js vite.config.ts

FROM ghcr.io/gaizkaurd/rails-base-final-3.1.2:3.1.3-alpine

# Workaround to trigger Builder's ONBUILDs to finish:
COPY --from=Builder /etc/alpine-release /tmp/dummy

# CLOUDTASKER LIBRARY
RUN ln -s /lib/libc.musl-x86_64.so.1 /lib/ld-linux-x86-64.so.2

USER app

ENTRYPOINT ["docker/startup.sh"]