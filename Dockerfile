
# Include the Ruby base image (https://hub.docker.com/_/ruby)
ARG RUBY_VERSION=2.7.6
ARG VARIANT=jemalloc-slim
FROM quay.io/evl.ms/fullstaq-ruby:${RUBY_VERSION}-${VARIANT}

RUN apt-get update -qq && apt-get install -y build-essential

# Production environment, because otherwise sinatra will start in development mode.
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
