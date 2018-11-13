FROM rails:5

WORKDIR /app

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install
RUN rails db:setup

VOLUME /app
EXPOSE 3000
CMD ["./entrypoint.sh"]
