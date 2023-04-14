module Api::V1::Concerns::Openable
  extend ActiveSupport::Concern

  # Times
  # rubocop:disable Metrics/AbcSize
  def open?
    return false if open_close_hours.blank?

    day = Time.zone.now.strftime('%A').downcase
    time = Time.zone.now

    today_schedule = open_close_hours[day]

    return false if today_schedule.nil? || today_schedule['open'] == 'closed' || today_schedule['close'] == 'closed'

    time >= open_close_hours[day]['open'] && time <= open_close_hours[day]['close']
  end

  def near_close?
    return false if open_close_hours.blank? || !open?

    day = Time.zone.now.strftime('%A').downcase
    time = 30.minutes.from_now

    return false if open_close_hours[day]['open'] == 'closed' || open_close_hours[day]['close'] == 'closed'

    time >= open_close_hours[day]['close']
  end

  def nearest_open_time
    today = Time.zone.now

    # get the next day that is open
    open_days = open_close_hours.select { |_day, v| v['open'] != 'closed' && v['close'] != 'closed' }

    8.times do |i|
      day = today + i.days
      wday = day.strftime('%A').downcase
      next if open_days.fetch(wday, nil).blank?
      next if today == day && today > open_close_hours[wday]['open']

      return day.change(hour: open_days[wday]['open'].split(':').first.to_i, min: open_days[wday]['open'].split(':').last.to_i, offset: '+0000')
    end
  end

  def near_open?
    30.minutes.from_now >= nearest_open_time
  end

  # rubocop:enable Metrics/AbcSize
end
