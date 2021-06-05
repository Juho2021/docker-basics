# docker-basics

1. install vscode and Docker desktop for Windows
2. enable WSL (Windows sub-system for Linux)
3. configure docker client to work from Linux (this requires one configuration change, we can go through this together)
4. register in dockerhub (docker.io)
5. Go through the following examples (in this repo):

A) create a docker image from the dockerfile

``` docker build --tag <name:tag> . ```

Note! Run this command in the same folder as the Dockerfile

B) docker compose

First, pull the postgres image

``` docker pull postgres:12.4 ```

By running "Docker-compose up" you start the containers and automatically create the shared networking configuration.

``` docker-compose up ```

Test connection

``` docker container exec -it psqlcli bash -c 'for i in $(seq 5); do pg_isready -h db -p 5432; if [ $? == 0 ]; then echo "successful connection"; break; else sleep 5; fi; done' ```

Shut down the containers

``` docker-compose down ```

