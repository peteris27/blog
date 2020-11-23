class Article < ApplicationRecord
  belongs_to :author
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }, uniqueness: true
  validates_presence_of :text

  def self.search(search)
    where("author_id LIKE ?", "%#{search}")
  end

  paginates_per 3
end
