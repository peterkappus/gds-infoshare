class Organisation < ActiveRecord::Base
  belongs_to :department
  has_many :contracts

  def to_s
    name
  end
end
