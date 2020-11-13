class Article < ApplicationRecord
  belongs_to :author
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }, uniqueness: true
  validates_presence_of :text
end
