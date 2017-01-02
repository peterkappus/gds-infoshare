class Organisation < ActiveRecord::Base
  belongs_to :department
  has_many :contracts
  has_many :benefits

  def to_s
    name
  end
end
