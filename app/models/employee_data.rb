class EmployeeData

  attr_accessor :times, :name

  def initialize(name)
    @name = name
    @times = Array.new
  end

  def add_times(value)
    @times << value
  end

  def days_absent(work_days)
    @absent_days = Array.new
    visited_days = Array.new
    visited_worked_days = Array.new
    @visited_worked_daytimes = Array.new
    @visited_worked_daytimes_late = Array.new

    # получение дат посещений
    @times.each do |t|
      visited_days << Date.parse(t).to_s
    end

    # получение дат пропусков, а так же дат посещений в рабочие дни
    work_days.each do |d|
      if visited_days.include?(d)
        visited_worked_days << d
      else
        @absent_days << d
      end
    end

    # получение даты-времени посещений в рабочие дни

    @times.each do |w|
      if visited_worked_days.include?(Date.parse(w).to_s)
        @visited_worked_daytimes << w
      end
    end

    @absent_days
  end

  def total_late_time(work_days)
    @absent_days ||= days_absent(work_days)
    arrive = Time.parse('10:00')

    #define workdays

    @time = 0


    @visited_worked_daytimes.each do |t|
      tf = Time.parse(DateTime.parse(t).strftime('%H:%M'))
      if tf > arrive
        @visited_worked_daytimes_late << t
        @time += TimeDifference.between(arrive, tf).in_minutes
      end
    end
    @time
    @result = {hours: @time.to_i / 60, minutes: @time.to_i % 60}
  end

  # TODO: refactor this aghtung
  def days_late
    @visited_worked_daytimes_late
  end
end 
