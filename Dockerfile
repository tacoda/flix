FROM ruby:2.6.6
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y nodejs yarn postgresql-client
# RUN export PATH="$PATH:`yarn global bin`"
RUN mkdir /flix
WORKDIR /flix
COPY Gemfile /flix/Gemfile
COPY Gemfile.lock /flix/Gemfile.lock
RUN bundle install
COPY . /flix
RUN mkdir /flix/tmp/pids
RUN rails assets:precompile

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
ENTRYPOINT ["./entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]