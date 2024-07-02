# Test web-app to use with Pluralsight courses and Docker Deep Dive book
FROM alpine

LABEL maintainer="moh.imam@protonmail.com"

# Install Node and NPM
RUN apk add --update nodejs npm curl

# Copy app to /src
COPY . /src

WORKDIR /src

# Install dependencies
RUN  npm install

EXPOSE 9090

ENTRYPOINT ["node", "./app.js"]
