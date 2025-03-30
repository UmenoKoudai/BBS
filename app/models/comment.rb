class Comment < ApplicationRecord
  belongs_to :thread_model

  validates :name, presence: true
  validates :text, presence: true, length: { maximum: 200 }
end
