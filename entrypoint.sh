#!/bin/bash
# Docker entrypoint script.

rails db:setup
exec rails server -b 0.0.0.0
