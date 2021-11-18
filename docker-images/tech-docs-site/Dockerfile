FROM ruby:3.0.2-bullseye

WORKDIR /usr/src/app

RUN apt update
RUN apt install -y nodejs npm
RUN gem install bundler:2.2.31

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

RUN bundle exec middleman build