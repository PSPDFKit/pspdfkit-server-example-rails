#!/bin/bash
# Docker entrypoint script.

rm -f tmp/pids/server.pid

bundle install
bin/rails db:setup
bin/rails db:migrate
exec bundle exec puma -b tcp://0.0.0.0:${PORT:-3000}
