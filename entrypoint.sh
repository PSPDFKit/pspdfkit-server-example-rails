#!/bin/bash
# Docker entrypoint script.

rm -f tmp/pids/server.pid && rails server -b '0.0.0.0'
