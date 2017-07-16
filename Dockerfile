FROM ruby:2.3.4

RUN apt-get update -qq && apt-get install -y build-essential

# for postgres
RUN apt-get install -y libpq-dev

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# for a JS runtime
RUN apt-get install -y nodejs

ENV APP_HOME /myapp
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile* ./
COPY bin/entrypoint ./
RUN bundle install

COPY . .

EXPOSE 3000
# ENTRYPOINT bash -c "rm -f $APP_HOME/tmp/pids/server.pid && bundle exec rails s -p 3000 -b '0.0.0.0'"
ENTRYPOINT ["./entrypoint"]
