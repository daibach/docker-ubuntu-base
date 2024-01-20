#!/bin/sh
set -xe

gen() {
  VERSION=$1
  NAME=$2

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
  echo 'RUN apt-get -qq install -y --no-install-recommends hugo' >> ${NAME}/Dockerfile
  echo '' >> ${NAME}/Dockerfile

  echo '' >> ${NAME}/Dockerfile
}

gen 22.04 22.04
