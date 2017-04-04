FROM ruby:2.4.0

RUN mkdir /app

WORKDIR /app

RUN apt-get update

RUN apt-get install -y nodejs

RUN apt-get install -y postgresql-client

RUN apt-get install -y unoconv

COPY Gemfile /app

COPY Gemfile.lock /app

RUN bundle install

COPY . /app

EXPOSE 3000

CMD puma
