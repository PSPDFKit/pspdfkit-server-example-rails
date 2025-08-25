# frozen_string_literal: true

source "https://rubygems.org"

ruby "3.4.5"

gem "jwt"
gem "rails", "~> 8"

gem "faraday"
gem "sass-rails"

gem "sqlite3"

# Gems that won't be part of stdlib from 3.5.0
gem "bigdecimal"
gem "mutex_m"
gem "benchmark"

# Server
gem "puma"

group :development, :test do
  gem "byebug", platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem "listen", "~> 3.7.1"
  gem "web-console"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen"
  # Audits
  gem "brakeman"
  gem "bundler-audit", require: false
  # Lint, formatting
  gem "rubocop"
  gem "rubocop-packaging"
  gem "rubocop-performance"
  gem "rubocop-rails"
  gem "rubocop-rake"
  gem "rubocop-thread_safety"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[windows jruby]
