class Benefit < ActiveRecord::Base
  belongs_to :department
  belongs_to :organisation
  belongs_to :product
  
end
