FROM ruby:2.4.0

ENV RAILS_ROOT /app

RUN mkdir $RAILS_ROOT

WORKDIR $RAILS_ROOT

RUN apt-get update

RUN apt-get install -y nodejs

RUN apt-get install -y postgresql-client

RUN apt-get install -y unoconv

COPY Gemfile $RAILS_ROOT

COPY Gemfile.lock $RAILS_ROOT

RUN bundle install

COPY . /app

EXPOSE 4000

CMD puma -C config/puma.rb
