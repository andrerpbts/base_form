class Plan < ApplicationRecord
  validates :name, presence: true

  def self.default
    Plan.first
  end
end
