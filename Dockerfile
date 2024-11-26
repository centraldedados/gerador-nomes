# Use a specific version of the base image for better reproducibility
ARG RUBY_VERSION=3.3.5
ARG VARIANT=jemalloc-slim
FROM quay.io/evl.ms/fullstaq-ruby:${RUBY_VERSION}-${VARIANT}

# Combine RUN commands and clean up in the same layer to reduce image size
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libjemalloc2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man && \
    mkdir -p /app/tmp/pids

# Set environment variables
ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2 \
    RACK_ENV=production

WORKDIR /app

# Copy only necessary files first to leverage Docker cache
COPY Gemfile Gemfile.lock ./
RUN bundle install --without development test --jobs 4 --retry 3

# Copy the rest of the application
COPY . .
