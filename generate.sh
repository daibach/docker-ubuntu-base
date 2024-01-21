#!/bin/sh
set -xe

gen() {
  VERSION=$1
  NAME=$2
  HUGO_VERSION=$3

  mkdir -p ${NAME}
  echo "FROM ubuntu:${VERSION}" > ${NAME}/Dockerfile
  echo '' >> ${NAME}/Dockerfile

  echo '# Install dependencies' >> ${NAME}/Dockerfile
  echo 'RUN apt-get -qq update && apt-get -qq install -y --no-install-recommends git zlib1g-dev ca-certificates libpng-dev libzip-dev libicu-dev zip unzip default-mysql-client cron curl' >> ${NAME}/Dockerfile

  echo '' >> ${NAME}/Dockerfile

  echo '# Set up cron' >> ${NAME}/Dockerfile
  echo 'RUN touch /var/log/cron.log' >> ${NAME}/Dockerfile
  echo '' >> ${NAME}/Dockerfile

  echo '# Install AWS CLI' >> ${NAME}/Dockerfile
  echo 'RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"' >> ${NAME}/Dockerfile
  echo 'RUN unzip awscliv2.zip' >> ${NAME}/Dockerfile
  echo 'RUN ./aws/install' >> ${NAME}/Dockerfile
  echo '' >> ${NAME}/Dockerfile

  echo '# Install Hugo' >> ${NAME}/Dockerfile
  echo 'RUN curl -L "https://github.com/gohugoio/hugo/releases/download/v0.121.2/hugo_extended_0.121.2_Linux-64bit.tar.gz" -o "hugo.tar.gz"' >> ${NAME}/Dockerfile
  echo "ARG HUGO_VERSION='${HUGO_VERSION}'" >> ${NAME}/Dockerfile
  echo 'RUN curl -L "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz" -o "hugo.tar.gz" && \' >> ${NAME}/Dockerfile
  echo '  tar xzf hugo.tar.gz && \' >> ${NAME}/Dockerfile
  echo '  rm -r hugo.tar.gz && \' >> ${NAME}/Dockerfile
  echo '  mv hugo /usr/bin && \' >> ${NAME}/Dockerfile
  echo '  chmod 755 /usr/bin/hugo' >> ${NAME}/Dockerfile
  echo '' >> ${NAME}/Dockerfile

  echo '' >> ${NAME}/Dockerfile
}

gen 22.04 22.04 0.121.2
gen 23.10 23.10 0.121.2
