# This file is not ready!
FROM alpine:3.7 # Linux alpine image - pulls this image from dockerhub if it is not found locally

# Set an environment variable APP_FOLDER and PG_PASSWORD
ENV APP_FOLDER /app
ENV PG_PASSWORD tester1234

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

# Copy private key to new location
# COPY ssl/privatekey.pem /$CA_CERTS_PATH/
# RUN chmod 0644 /$CA_CERTS_PATH/privatekey.pem

# Original dockerfile commands
# COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
# COPY --from=builder /app/ /app/

# EXPOSE 3000

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
# ENTRYPOINT ["mysql"]

# Starting command (you need to give the command)
CMD ["", "", "-b", "0.0.0.0"]

RUN DATABASE_URL=postgresql:does_not_exist \
  SECRET_KEY_BASE=nein \
  RAILS_ENV=${rails_env} \
  RAILS_MASTER_KEY=${rails_master_key} \
  bundle exec rails yarn:install assets:precompile \
  && rm -rf node_modules tmp/* log/*
