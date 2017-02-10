class BenefitYear < ActiveRecord::Base
  belongs_to :benefit
  default_scope { order(:fy_end_date)}

  monetize :target_value_cents, :allow_nil => true

  def value
    target_value_cents
  end
end
