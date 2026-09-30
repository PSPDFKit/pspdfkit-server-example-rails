FROM ruby:3.4.5

WORKDIR /usr/src/app

COPY Gemfile* ./

RUN bundle install

COPY . .

EXPOSE 3000
CMD ["./entrypoint.sh"]
