class FitbitController < ApplicationController

  def api_response(s, startDate, endDate)
    if not current_user.fitbit.nil?
      current_user.fitbit.client.get(['/1/user/-', s, 'date', startDate, endDate].join('/') + '.json').body
    end
  end

  def reload(series, date)
    reload(series, date, 'today')
  end

  def reload(series, startDate, endDate)
    api = {}
    series.each do |s|
      begin
        data = JSON.parse(api_response(s, startDate, endDate))
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
    logger.info tapi
    return tapi
  end

end
