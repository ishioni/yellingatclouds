FROM --platform=$BUILDPLATFORM docker.io/hugomods/hugo:0.160.1@sha256:cb4106ffd926692b2d0c62f768601f9323faddd4e4ee05d9d58ee0e08de77055 AS build

# Set shell options for safety
SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

# Add build-time ARGs
ARG BUILD_DATE
ARG VCS_REF

# Add build-time labels
LABEL org.opencontainers.image.source="https://github.com/ishioni/yellingatclouds"
LABEL org.opencontainers.image.description="Generate Yelling at Clouds static site with Hugo"
LABEL org.opencontainers.image.version="1.0.0"
LABEL org.opencontainers.image.created="${BUILD_DATE}"
LABEL org.opencontainers.image.revision="${VCS_REF}"

RUN  apk add --no-cache \
      curl

# Set Dart Sass version
ENV DART_SASS_VERSION=1.86.3

RUN curl -sSL https://github.com/sass/dart-sass/releases/download/${DART_SASS_VERSION}/dart-sass-${DART_SASS_VERSION}-linux-x64-musl.tar.gz \
    | tar -xz -C /usr/local/bin --strip-components=1

WORKDIR /src
COPY . .

RUN --mount=type=cache,target=/tmp/hugo_cache \
    hugo --minify -s ./hugo

FROM docker.io/nginxinc/nginx-unprivileged:1.30@sha256:9b269aa3263e1dcba790fda66aa91b6b02f904adcd8329e5cf256e14a65e2974

# Add build-time ARGs
ARG BUILD_DATE
ARG VCS_REF

# Add runtime labels
LABEL org.opencontainers.image.source="https://github.com/ishioni/yellingatclouds"
LABEL org.opencontainers.image.description="Generate Yelling at Clouds static site with Hugo"
LABEL org.opencontainers.image.version="1.0.0"
LABEL org.opencontainers.image.created="${BUILD_DATE}"
LABEL org.opencontainers.image.revision="${VCS_REF}"

COPY --chown=nginx:nginx --from=build /src/hugo/public /site
COPY --chown=nginx:nginx ./docker/default.conf /etc/nginx/conf.d/

USER nginx
