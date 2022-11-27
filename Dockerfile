FROM ghcr.io/ledermann/rails-base-builder:3.1.2-alpine AS Builder

RUN apk add libc6-compat

# Remove some files not needed in resulting image.
# Because they are required for building the image, they can't be added to .dockerignore
RUN rm -r package.json tailwind.config.js postcss.config.js vite.config.ts

FROM ghcr.io/ledermann/rails-base-final:3.1.2-alpine

# Workaround to trigger Builder's ONBUILDs to finish:
COPY --from=Builder /etc/alpine-release /tmp/dummy

USER app

LABEL fly_launch_runtime="rails"
ENTRYPOINT ["docker/startup.sh"]