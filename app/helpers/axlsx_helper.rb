 module AxlsxHelper

	require 'axlsx'

	def create_xlsx_report(data, work_days)	  
	  Axlsx::trust_input = false
      Axlsx::Package.new do |p|
	    p.workbook.add_worksheet(name: 'report') do |sheet|
	      title = sheet.styles.add_style(bg_color: "DFE250", b: true)	
	      sheet.add_row ['Имя', 'Пропущено дней', 'Общее время опозданий', 'Оформлено дней'], style: title,  widths: [20, :auto, :auto, :auto]
	      cell_row = 2 # if there is a way to get cell reference from rows...
	      data.each do |d| 
	      	abs_days  = d.days_absent(work_days)
	      	time_late = d.total_late_time(work_days)
	      	days_late = d.days_late
 	      	sheet.add_row [d.name, abs_days.size, time_late[:hours].to_s + ":" + time_late[:minutes].to_s]

	      	sheet.add_comment(ref: 'B' + cell_row.to_s, author: "Пропущенные дни\n", 
	      				visible: false, text: abs_days.each { |ad| ad.inspect }.to_s.gsub('"', '').gsub('[', '').gsub(']', '').gsub(',', "\n"))
	      					.tap do |comment| 
	      						comment.vml_shape.bottom_row = cell_row + 35
	      						comment.vml_shape.right_column = comment.vml_shape.column + 1
	      					end	

	      	sheet.add_comment(ref: 'C'+ cell_row.to_s, author: "Дни и время опозданий\n", 
	      				visible: false, text: d.days_late.each { |t| t.to_s }.to_s.to_s.gsub('"', '').gsub('[', '').gsub(']', '').gsub(',', "\n"))
	      					.tap do |comment| 
	      						comment.vml_shape.bottom_row = cell_row + 35
	      						comment.vml_shape.right_column = comment.vml_shape.column + 1
	      					end	
	      	cell_row+=1
	      end		
	    end
	    use_shared_strings = true
	  end		  	 
	end
	
end		