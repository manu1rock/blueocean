FROM ubuntu:latest

MAINTAINER manoj1yadav <manuvns.manoj@gmail.com>

WORKDIR /usr/apps/hello-docker/

RUN apt-get -y update

RUN apt-get install -y nodejs

RUN apt-get install -y npm

RUN npm install -g http-server

ADD . /usr/apps/hello-docker/

CMD ["http-server", "-s"]
