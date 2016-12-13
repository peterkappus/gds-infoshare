class Department < ActiveRecord::Base
  has_many :contracts
  has_many :organisations
  default_scope { order(:name) }
  monetize :total_value_cents, :allow_nil => true

  #TODO: refactor this into a concern
  def to_s
    name
  end

  def self.search(words)
    where("lower(name) LIKE ?","%#{words.downcase}%")
  end

  def update_total_value
    total_value = contracts.pluck(:value_cents).reduce(:+)/100
    puts total_value
    save!
  end

end
