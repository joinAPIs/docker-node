FROM node:current-alpine3.11

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="joinAPIs version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# environment settings
ENV NPM_CONFIG_LOGLEVEL info

# install packages
RUN \
 apk add --no-cache --upgrade \
        curl \
        tzdata \
        git \
        nano && \
 echo "**** configure node ****" && \
 mkdir /data && \
 ln -s /usr/src/app /data