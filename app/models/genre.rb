class Genre < ApplicationRecord
  include Kaminari::PageScopeMethods
  has_many :articles

  scope :only_active, -> { where(is_active: true) }

  validates :name, presence: true, uniqueness: true

end
