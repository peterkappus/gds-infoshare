class Product < ActiveRecord::Base
  default_scope {order(:name)}
end
