class Document < ApplicationRecord
  default_scope { order(created_at: :desc) }
  has_and_belongs_to_many :users
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"
end
