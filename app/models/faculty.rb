class Faculty < ApplicationRecord
  has_many :subjects

  with_options presence: true do |o|
    o.validates :name
  end
end
