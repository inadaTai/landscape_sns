FROM ruby:2.6.3
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn chromium-driver
RUN mkdir /landscape_sns
WORKDIR /landscape_sns
COPY Gemfile /landscape_sns/Gemfile
COPY Gemfile.lock /landscape_sns/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . /landscape_sns

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
