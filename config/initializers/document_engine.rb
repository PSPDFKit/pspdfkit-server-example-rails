# frozen_string_literal: true

require "document_engine"

# We need two config options for the Nutrient Document Engines URL,
# because one is called from the Rails app itself (internal) and one is
# called from the browser (external). Most of the time
# DOCUMENT_ENGINE_INTERNAL_URL and DOCUMENT_ENGINE_EXTERNAL_URL should
# have the same value, but having this 2 options makes it possible to
# work with Docker links and allow running the example with docker
# compose.
#
# When running this example with docker compose,
# DOCUMENT_ENGINE_INTERNAL_URL should be the Docker link name
# (https://docs.docker.com/compose/networking/#links) and
# DOCUMENT_ENGINE_EXTERNAL_URL should be the public IP address of the
# machine running docker compose or https://localhost:5000 for
# development purpose.
#
DocumentEngine.configure(
  internal_url: ENV.fetch("DOCUMENT_ENGINE_INTERNAL_URL", "http://localhost:5000"),
  external_url: ENV.fetch("DOCUMENT_ENGINE_EXTERNAL_URL", "http://localhost:5000"),
  auth_token: "secret",
  jwt_key: OpenSSL::PKey::RSA.new(Rails.root.join("config/jwt.pem").read)
)
