class College < ActiveRecord::Base
  
  validates_presence_of :name, :type, :city, :state, :region

end
