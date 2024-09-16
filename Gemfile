# frozen_string_literal: true

source "https://rubygems.org"

gem "jwt"
gem "rails", "~> 6.1.6.1"
gem "rest-client", "~> 2.0.1"
gem "sass-rails", "~> 5.0"
gem "sqlite3"

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
  gem "spring-watcher-listen", "~> 2.0.1"
  # Audits
  gem "brakeman"
  gem "bundler-audit", require: false
  # Lint, formatting
  gem "rubocop", "~> 1.28"
  gem "rubocop-rails"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
