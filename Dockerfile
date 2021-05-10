FROM ruby:3.0.1-alpine

RUN apk add --update --no-cache build-base tzdata postgresql-dev postgresql-client

RUN mkdir /app
WORKDIR /app

RUN gem install bundler -v 2.2.15

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN \
  bundle config set no-cache 'true' && \
  bundle config set path '/bundle' && \
  bundle config set without 'development test' && \
  bundle config set jobs 4 && \
  bundle install

COPY . /app
