FROM ruby:3.4.1

WORKDIR /usr/src/app

COPY Gemfile* ./

RUN bundle install

COPY . .

EXPOSE 3000
CMD ["./entrypoint.sh"]
