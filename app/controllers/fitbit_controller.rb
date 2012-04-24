class FitbitController < ApplicationController

  def api_response(user, s, startDate, endDate)
    if not user.fitbit.nil?
      user.fitbit.client.get(['/1/user/-', s, 'date', startDate, endDate].join('/') + '.json').body
    end
  end

  def reload(series, date)
    reload_range(series, date, 'today')
  end

  def reload_range(series, startDate, endDate)
    reload_range_for_user(current_user, series, startDate, endDate)
  end

  def reload_range_for_user(user, series, startDate, endDate)
    api = {}
    series.each do |s|
      begin
        data = JSON.parse(api_response(user, s, startDate, endDate))
        api = api.merge(data)
      rescue SocketError
        logger.error "Can not talk to fitbit"
        nil
      end
    end
    tapi = {}
    api.each do |a|
      tapi = tapi.merge(a[0].gsub('-', '/') => a[1])
    end
    puts tapi
    return tapi
  end

  def get_series(series)
    if series == 'sleep'
      ['startTime', 'timeInBed', 'minutesAsleep', 'awakeningsCount', 'minutesAwake', 'minutesToFallAsleep', 'minutesAfterWakeup', 'efficiency'].collect {|s| 'sleep/' + s}
    elsif series == 'activities'
      #'elevation', 'floors', 
      ['calories', 'steps', 'distance', 'minutesSedentary', 'minutesLightlyActive', 'minutesFairlyActive', 'minutesVeryActive', 'activeScore', 'activityCalories'].collect {|s| 'activities/' + s}
    elsif series == 'body'
      ['weight', 'bmi', 'fat'].collect {|s| 'body/' + s}
    elsif series == 'foods'
      ['caloriesIn', 'water'].collect{|s| 'foods/log/' + s}
    else
      []
    end
  end
end
