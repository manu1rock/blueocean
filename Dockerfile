FROM alpine
MAINTAINER manoj1yadav<manuvns.manoj@gmail.com>
RUN apk --update nodejs nodes-npm
COPY ./src
WORKDIR /src
RUN npm install
EXPOSE 8085
ENTRYPOINT ["node", "./app.js"]
