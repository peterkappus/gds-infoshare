class Department < ActiveRecord::Base

  #TODO: refactor this into a concern
  def to_s
    name
  end
end
