FROM debian:stretch-slim
MAINTAINER Bytemark Hosting "support@bytemark.co.uk"

# Install exim4
ENV DEBIAN_FRONTEND noninteractive
RUN set -ex; \
    apt-get update; \
    apt-get install -y exim4-daemon-light; \
    apt-get clean

# Copy the main script.
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# We expose exim on port 25.
EXPOSE 25/tcp

ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD [ "exim", "-bdf", "-v", "-q30m" ]
