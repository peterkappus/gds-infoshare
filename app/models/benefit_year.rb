class BenefitYear < ActiveRecord::Base
  belongs_to :benefit
  monetize :target_value_cents, :allow_nil => true
end
