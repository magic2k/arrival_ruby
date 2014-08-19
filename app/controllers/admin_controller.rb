class AdminController < ApplicationController

  def remote_db

  end

  def populate_db
    user_names = ArrivalData.connection.select_all("SELECT DISTINCT TIMES.user FROM TIMES")
    user_names.each do |u|
      if Employee.where(name: u['user']).blank?
        e = Employee.new(name: u['user'])
        if !(e.save)
          flash[:alert] = "не удалось сохранить #{u['user']}"
          redirect_to admin_remote_db_path
        end
      end
    end

    flash[:success] = "БД заполнена"
    redirect_to admin_remote_db_path
  end

end
