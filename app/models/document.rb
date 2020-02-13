class Document < ApplicationRecord
  default_scope { order(created_at: :desc) }
  has_and_belongs_to_many :users
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"

  def get_jwt(layer)
    claims = {
      document_id: self.server_id,
      permissions: ["read-document", "write", "download"]
     }
    if layer != ""
      claims[:layer] = layer
    end
    PSPDFKit.jwt_sign(claims).to_json.html_safe
  end
end
