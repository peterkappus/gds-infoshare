module ApplicationHelper
  def human_value_of_contract_set(contract_set)
    number_to_human(contract_set.pluck(:value_cents).reduce(:+).to_i/100)
  end
end
