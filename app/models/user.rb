class User < ApplicationRecord
  has_and_belongs_to_many :documents
  has_many :owned_documents, class_name: "Document", foreign_key: "owner"
  default_scope { order(:name) }

  def accessible_documents
    self.owned_documents | self.documents
  end

  def has_access?(document)
    document.owner_id == self.id || document.users.include?(self)
  end

  def self.by_name(name)
    User.find_by_name(name) || User.create(name: name)
  end
end
