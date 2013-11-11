module AxlsxHelper

	require 'axlsx'

	def create_xlsx_report(employees, data)
      Axlsx::Package.new do |p|
	    p.workbook.add_worksheet(name: 'report') do |sheet|
	      sheet.add_row ["Имя"]
	      	
	    end
	  end		  
	end
	
end		