class Department < ActiveRecord::Base
  has_many :contracts
  has_many :organisations
  default_scope { order(:name) }

  #TODO: refactor this into a concern
  def to_s
    name
  end

  def total_value
    contracts.pluck(:value_cents).reduce(:+)/100
  end

end
