class ArrivalData < ActiveRecord::Base
	establish_connection "arrival_#{Rails.env}"
	#establish_connection "arrival_production"
	self.table_name = 'TIMES'

end