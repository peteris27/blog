class Author < ApplicationRecord
  has_many :article

  validates :name, presence: true, length: { minimum: 5 }, uniqueness: true

end
