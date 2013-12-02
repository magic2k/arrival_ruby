class ArrivalData < ActiveRecord::Base
  #establish_connection "arrival_#{Rails.env}"
  establish_connection "arrival_production"
  #establish_connection "arrival_development"
  self.table_name = 'TIMES'

end