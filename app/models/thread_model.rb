class ThreadModel < ApplicationRecord
  has_many :comments, dependent: :destroy
end
