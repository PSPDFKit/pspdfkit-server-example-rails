#!/bin/bash
# Docker entrypoint script.

rm -f tmp/pids/server.pid

bin/rails db:setup
bin/rails db:migrate
exec bin/rails server -b '0.0.0.0'
