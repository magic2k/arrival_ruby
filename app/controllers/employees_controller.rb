class EmployeesController < ApplicationController
	include AxlsxHelper
	require 'employee_data'

	# before_action :get_data_from_remote_db, only: [:show]

	def index
		@employees = Employee.all
		@employee = Employee.new
	end	

	def show
		@employee = Employee.find(params[:id])
		@data = ArrivalData.where(USER: @employee.name).order("TIMEON DESC")
	end	

	def report
		@employees = Employee.all
	end	

	def personal_report				
		@data = ArrivalData.where("USER = :employee AND TIMEON >= :start_date AND TIMEON < :end_date", 
			employee: params[:employee], start_date: params[:start_date], end_date: (params[:end_date] + 1.to_s) )	
	end

	def overall_report

		@employees_data = Array.new
		employees = Employee.all
		employee_names = employees.map { |e| e.name }
		@work_days = params[:work_days]

		employee_names.each do |n|
			data = ArrivalData.where("USER = :employee AND TIMEON >= :start_date AND TIMEON < :end_date", 
				employee: n, start_date: params[:start_date], end_date: (params[:end_date] + 1.to_s) )
			ed = EmployeeData.new(n)
			@employees_data << ed

			data.each do |d|
				ed.add_times( d.TIMEON ) 
			end	
		end	

		#@db_data = ArrivalData.where("TIMEON >= :start_date AND TIMEON < :end_date", 
		#	employee: params[:employee], start_date: params[:start_date], end_date: (params[:end_date] + 1.to_s))

		# @employees_data.first.name 
	end	

	def workdays_select
		@start_date = Date.parse(params[:start_date])
		@end_date = Date.parse(params[:end_date])
		@range_days = (@start_date..@end_date).map{ |date| date }
	end	

	def today_report

		@today_data = {}
		employees = Employee.all
		employee_names = employees.map { |e| e.name }

		employee_names.each do |n|
			@today_data[n] = ArrivalData.where("USER = :employee AND TIMEON >= :today_date AND TIMEON <= :t2_date", 
				employee: n, today_date: Date.today, t2_date: :today_date.to_s + '23:59:59').take
			# @today_data[n] = @data.TIMEON					
		end
			
		employee_names = employees.map { |e| e.name }
	end	

	def get_xlsx
		spreadsheet = create_xlsx_report
		respond_to do |format|
			format.xlsx {
				send_data( spreadsheet.to_stream.read,
					type: 'application/vnd.ms-excel',
					filename: 'report' + Date.today.to_s + '.xlsx')
			}
		end	
	end	

	def create
		@employee = Employee.new(employee_params)
		if @employee.save
			redirect_to employees_path, notice: "#{@employee.name} добавлен"
		else
			render 'index'
		end	
	end

	def destroy
		e = Employee.find(params[:id])
		e.destroy
		flash[:success] = 'Delorted'
		redirect_to employees_path
	end

	private

	def employee_params
		params.require(:employee).permit(:name, :vacation)
	end	

	# def get_data_from_remote_db	
	# 	@arrival_data = 
	# end	
end
