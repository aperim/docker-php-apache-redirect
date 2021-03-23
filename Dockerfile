ARG PHP_VERSION=8
FROM php:${PHP_VERSION}-apache-buster

LABEL org.opencontainers.image.source https://github.com/aperim/docker-php-apache-redirect
LABEL org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.name="PHP ${PHP_VERSION} Apache with ModRewrite" \
  org.label-schema.description="PHP ${PHP_VERSION} Apache with ModRewrite" \
  org.label-schema.url="https://github.com/aperim/docker-php-apache-redirect" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/aperim/docker-php-apache-redirect" \
  org.label-schema.vendor="Aperim" \
  org.label-schema.version=$VERSION \
  org.label-schema.schema-version="1.0"

RUN a2enmod rewrite && \
  a2enmod remoteip && \
  printf "\n\n# Allow loadbalancer X-Forwarded-For header\nRemoteIPHeader X-Forwarded-For\n" >> /etc/apache2/apache2.conf && \
  sed -i --regexp-extended 's/^(LogFormat\s+.*)\%h(.*)$/\1\%a\2/' /etc/apache2/apache2.conf