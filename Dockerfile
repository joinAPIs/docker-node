FROM lsiobase/alpine:3.12

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="joinAPIs version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="joinapis"

# environment settings
ENV HOME="/app"
ENV NODE_ENV="production"

RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
   curl \
   g++ \
   make && \
 echo "**** install runtime packages ****" && \
 apk add --no-cache --upgrade \
   alpine-base \
   git \
   nano \
   nodejs-current \
   npm \
   yarn && \
 echo "**** create app directory if it does not exist ****" && \
 if [ ! -d "/app" ]; then \
	mkdir /app && \
       cd /app && \
       curl -o \
          /app/package.json -L \
	   "https://raw.githubusercontent.com/joinAPIs/helloworld/master/package.json" && \
       npm install \
 fi && \
 echo "**** cleanup ****" && \
 apk del --purge \
   build-dependencies && \
 rm -rf \
   /root/.cache \
   /tmp/*

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 3000