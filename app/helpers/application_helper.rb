module ApplicationHelper
  def human_value_of_contract_set(contract_set)
    value = contract_set.pluck(:value_cents).reduce(:+).to_i/100
    show_big_money value
  end

  def show_big_money(value)
    "£" + number_to_human(value, significant: false, precision: 0, units: {million: 'm', billion:'bn', trillion: 'tr', thousand: 'k'}, format: '%n%u')
  end

  def big_number(number, caption)
    render partial: 'shared/big_number', locals: {number: number, caption: caption}
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    new_direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, {:sort_column => column, :direction => new_direction}, {:class => css_class}
  end

end
