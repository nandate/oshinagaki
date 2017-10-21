class Menu < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :content, presence: true
  validates :image_url, presence: true
  validates :author, presence: true
  validates :user_id, presence: true
end
