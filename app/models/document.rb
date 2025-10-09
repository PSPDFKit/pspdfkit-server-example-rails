# frozen_string_literal: true

class Document < ApplicationRecord
  default_scope { order(created_at: :desc) }
  has_and_belongs_to_many :users
  belongs_to :owner, class_name: "User"

  def get_jwt(layer)
    claims = {
      document_id: server_id,
      permissions: %w[read-document write download]
    }
    if layer != ""
      claims[:layer] = layer
    end
    DocumentEngine.jwt_sign(claims).to_json
  end
end
