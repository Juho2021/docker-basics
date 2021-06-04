# Linux alpine image - pulls this image from dockerhub if it is not found locally
FROM alpine:3.7

# A) Set an environment variable APP_FOLDER and PG_PASSWORD (either one of these works)
ENV APP_FOLDER /app
ENV PG_PASSWORD tester1234

# B) Set an environment variable APP_FOLDER and PG_PASSWORD (either one of these works)
#RUN APP_FOLDER=/app \
#  PG_PASSWORD=tester1234

# Update,upgrade and add packages to the package manager
RUN apk update && apk upgrade
RUN apk add --no-cache \
  postgresql-dev \
  postgresql-client \
  curl \
  tzdata \
  busybox
#  ca-certificates \
#  graphicsmagick \
#  nodejs \
#  rsync

# Create the working directory
RUN mkdir -p /app
# Set the new working directory
WORKDIR /app

# copy all files from your local machine ./app-folder to the container /app-folder
COPY ./app /app
# you may want to change execution rights for some of the files copied
RUN chmod +x /app/docker-test.sh
# currently all this does is wait 60 seconds and then terminate the container
CMD ["/bin/sh", "-c", "sleep 60"]
