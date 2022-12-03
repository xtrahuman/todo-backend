class Category < ApplicationRecord
    has_many :tasks, dependent: :destroy

    validates :name, presence: true, length: {minimum:1, maximum: 50 }
end
