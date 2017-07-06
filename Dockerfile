# use this empty Dockerfile to build your assignment

# This dir contains a Node.js app, you need to get it running in a container
# No modifications to the app should be necessary, only edit this Dockerfile

# Overview of this assignment
# use the instructions from developer below to create a working Dockerfile
# feel free to add command inline below or use a new file, up to you (but must be named Dockerfile)
# once Dockerfile builds correctly, start container locally to make sure it works on http://localhost
# then ensure image is named properly for your Docker Hub account with a new repo name
# push to Docker Hub, then go to https://hub.docker.com and verify
# then remove local image from cache
# then start a new container from your Hub image, and watch how it auto downloads and runs
# test again that it works at http://localhost


# Instructions from the app developer
# - you should use the 'node' official image, with the alpine 6.x branch
FROM node:6-alpine
# - this app listens on port 3000, but the container should launch on port 80
  #  so it will respond to http://localhost:80 on your computer
EXPOSE 3000
# - then it should use alpine package manager to install tini: 'apk add --update tini'
RUN apk add --update tini
# - then it should create directory /usr/src/app for app files with 'mkdir -p /usr/src/app'
RUN mkdir -p /usr/src/app
# - Node uses a "package manager", so it needs to copy in package.json file
WORKDIR /usr/src/app

# install the firebase tools globally
RUN npm install -g firebase-tools

COPY package.json package.json
# - then it needs to run 'npm install' to install dependencies from that file
RUN npm install && npm cache clean
# - to keep it clean and small, run 'npm cache clean --force' after above

# make a bin directory for HUGO
RUN mkdir -p /usr/src/bin

# Download and Install hugo
ENV HUGO_VERSION 0.24.1
ENV HUGO_BINARY hugo_${HUGO_VERSION}_Linux-64bit
# hugo_0.24.1_Linux-64bit.tar.gz
# https://github.com/gohugoio/hugo/releases/download/v0.24.1/hugo_0.24.1_Linux-64bit.tar.gz
ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY}.tar.gz /usr/local/
RUN tar xzf /usr/local/${HUGO_BINARY}.tar.gz -C /usr/local/bin/ \
	&& rm /usr/local/${HUGO_BINARY}.tar.gz

# add bash to alpine
RUN apk add --no-cache bash git

# - then it needs to copy in all files from current directory
COPY . .
# - then it needs to start container with command 'tini -- node ./bin/www'
CMD ["tini", "node", "app.js"]
# - in the end you should be using FROM, RUN, WORKDIR, COPY, EXPOSE, and CMD commands
