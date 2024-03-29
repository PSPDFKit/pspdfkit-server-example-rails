FROM ruby:2.7.2

WORKDIR /usr/src/app

COPY Gemfile* ./

RUN bundle install

COPY . .

EXPOSE 3000
CMD ["./entrypoint.sh"]
