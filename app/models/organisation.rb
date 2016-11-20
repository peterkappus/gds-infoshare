class Organisation < ActiveRecord::Base
  belongs_to :department

  def to_s
    name
  end
end
