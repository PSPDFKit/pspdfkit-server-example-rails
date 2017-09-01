require 'pspdf_kit'

PSPDFKit.configure(
  base_url: ENV['BASE_URL'] || "http://localhost:5000",
  auth_token: "secret",
  jwt_key:  OpenSSL::PKey::RSA.new(Rails.root.join("config", "jwt.pem").read)
)
