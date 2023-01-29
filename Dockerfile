
# Include the Ruby base image (https://hub.docker.com/_/ruby)
ARG RUBY_VERSION=2.7.6
ARG VARIANT=jemalloc-slim
FROM quay.io/evl.ms/fullstaq-ruby:${RUBY_VERSION}-${VARIANT}

# VM dependencies setup
RUN apt-get update -qq && apt-get install -y build-essential libjemalloc2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /user/share/doc /user/share/man

# Jemmaloc setup
ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2
ENV MALLOC_CONF=dirty_decay_ms:1000,narenas:2,background_thread:true

# Production environment, because otherwise Sinatra will start in development mode.
ENV RACK_ENV=production

# Put all this application's files in a directory called /app.
# This directory name is arbitrary and could be anything.
RUN mkdir /app
WORKDIR /app
RUN mkdir -p tmp/pids
COPY . /app

# Run this command. RUN can be used to run anything. In our
# case we're using it to install our dependencies.
RUN bundle install
