class Product < ActiveRecord::Base
  default_scope {order(:name)}
  validates :name, uniqueness: true
  has_many :benefits

  
  def total_value_cents
    benefits.map do |b|
      b.total_value_cents
    end.reduce(:+)
  end
end
