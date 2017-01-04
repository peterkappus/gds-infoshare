class Organisation < ActiveRecord::Base
  belongs_to :department
  has_many :contracts
  has_many :benefits
  validates :name, uniqueness: true, presence: true

  def to_s
    name
  end
end
