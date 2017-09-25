FROM rails:5

WORKDIR /app

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install

VOLUME /app
EXPOSE 3000
CMD ["./entrypoint.sh"]
