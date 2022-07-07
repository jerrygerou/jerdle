class Word < ApplicationRecord
  validates :body, presence: true, length: { is: 5 }
end
