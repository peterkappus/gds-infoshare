module ApplicationHelper
  def human_value_of_contract_set(contract_set)
    value = contract_set.pluck(:value_cents).reduce(:+).to_i/100
    show_big_money value
  end

  def show_big_money(value)
    "£" + number_to_human(value, significant: false, precision: 2, units: {million: 'm', billion:'bn', thousand: 'k'}, format: '%n%u')
  end
end
