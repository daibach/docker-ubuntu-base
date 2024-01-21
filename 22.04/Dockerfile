FROM ubuntu:22.04

# Install dependencies
RUN apt-get -qq update && apt-get -qq install -y --no-install-recommends git zlib1g-dev ca-certificates libpng-dev libzip-dev libicu-dev zip unzip default-mysql-client cron curl

# Set up cron
RUN touch /var/log/cron.log

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

# Install Hugo
RUN curl -L "https://github.com/gohugoio/hugo/releases/download/v0.121.2/hugo_extended_0.121.2_Linux-64bit.tar.gz" -o "hugo.tar.gz"
ARG HUGO_VERSION='0.121.2'
RUN curl -L "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz" -o "hugo.tar.gz" && \
  tar xzf hugo.tar.gz && \
  rm -r hugo.tar.gz && \
  mv hugo /usr/bin && \
  chmod 755 /usr/bin/hugo


