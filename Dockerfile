FROM ruby:2.7.2
ENV APP_HOME=/usr/src/app
ENV BUNDLE_PATH /gems
COPY . $APP_HOME
WORKDIR $APP_HOME
RUN gem update --system
RUN gem install bundler
RUN bundle install
CMD [ "bundle", "exec", "rake"]