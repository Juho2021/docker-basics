# This file is not ready!
FROM alpine:3.7 # Linux alpine image - pulls this image from dockerhub if it is not found locally

# A) Set an environment variable APP_FOLDER and PG_PASSWORD (either one of these works)
ENV APP_FOLDER /app
ENV PG_PASSWORD tester1234

# B) Set an environment variable APP_FOLDER and PG_PASSWORD (either one of these works)
RUN APP_FOLDER=/app \
  PG_PASSWORD=tester1234

# Update,upgrade and add packages to the package manager
RUN apk update && apk upgrade
RUN apk add --no-cache \
  tzdata \
  busybox \
  ca-certificates \
  curl \
  graphicsmagick \
  nodejs \
  postgresql-dev \
  postgresql-client \
  mysql-client \
  rsync

# Create the working directory
RUN mkdir -p /app
# Set the new working directory
WORKDIR /app

# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]

# Starting command (you need to give the command)
# CMD ["", "", "-b", "0.0.0.0"]
