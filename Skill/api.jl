#
# API function go here, to be called by the
# skill-actions (and trigger-actions):
#

# tell current weather:
#
# Dict{Any, Any} with 11 entries:
#   :rain3h      => 0.0
#   :time        => "2023-04-03T10:26:44.235"
#   :temperature => 275.66
#   :clouds      => 8
#   :windspeed   => 5.85
#   :rain        => 0.0
#   :sunrise     => DateTime("2023-04-03T06:57:24")
#   :service     => "OpenWeatherMap"
#   :rain1h      => 0.0
#   :winddir     => 61
#   :sunset      => DateTime("2023-04-03T19:58:54")
#
function tell_current_weather(w)

    # clouds in /8:
    #
    okta = w[:clouds] / 12.5 |> round |> Int
    words = [:clouds_0_oktas, 
             :clouds_1_okta, :clouds_2_oktas, :clouds_3_oktas,
             :clouds_4_oktas, :clouds_5_oktas, :clouds_6_oktas,
             :clouds_7_oktas, :clouds_8_oktas]

    temp_celsius = w[:temperature] - 273.15 |> round |> Int

    # rain:
    #
    rain = w[:rain1h]
println("clouds: $(words[okta+1]), rain: $rain, T: $temp_celsius")

    publish_say(:weather_is)
    publish_say(words[okta+1])

    publish_say(:sky_is, oktas, :sky_is_2)
    publish_say(:temperature_is, temp_celsius, :temperature_is_2)

    if rain < 0.1
        publish_say(:no_rain)
    else
        rain = Int(ceil(rain))
        publish_say(:rain_now, rain_1h, :rain_now_2)
    end
end

function tell_current_wind(w)

    # wind dir:
    #
    dirs = [:north, :north_north_east, :north_east, :east_north_east,
            :east, :east_south_east, :south_east, :south_south_east,
            :south, :south_south_west, :south_west, :west_south_west,
            :west, :west_north_west, :north_west, :north_north_west,
            :north]

    wind_num = w[:winddir] / 22.5 |> round |> Int
    wind_name = dirs[wind_num+1]
    wind_speed = w[:windspeed] |> round |> Int

    publish_say(:wind_is, wind_speed, :wind_is_2, wind_name)
end


function tell_rain_status(weather_history)

    start_today = Dates.now() |> Dates.Date |> Dates.DateTime
    start_yesterday = start_today - Dates.Day(1)
    start_2_days = start_today - Dates.Day(2) 
    start_week = start_today - Dates.Day(7)

    publish_say(:looking_up_weather_db)

    rain_today = mm_since(weather_history, start_today)
    rain_yesterday = mm_since(weather_history, start_yesterday)
    rain_2_days = mm_since(weather_history, start_2_days)
    rain_week = mm_since(weather_history, start_week)

    # today:
    #
    w = get_weather()
    if w[:rain1h] < 0.1
        publish_say(:no_rain)
    else
        publish_say(:rain_now, w[:rain1h], :rain_now_2)
    end

    # since yesterday:
    #
    if rain_yesterday < 0.1
        publish_say(:no_rain_since_yesterday)
    else
        publish_say(:rain_since_yesterday, rain_yesterday, :rain_since_2)
    end

    # last 2 days:
    #
    if rain_2_days < 0.1
        publish_say(:no_rain_last_2_days)
    else
        publish_say(:rain_last_2_days, rain_2_days, :rain_since_2)
    end

    # last week:
    #
    if rain_week < 0.1
        publish_say(:no_rain_last_week)
    else
        publish_say(:rain_last_week, rain_week, :rain_since_2)
    end
end


function mm_since(wh, old)

    old = string(old)
    cumulative_mm = 0.0
    for w in wh
        if w[:time] > old && haskey(w, :rain1h)
            cumulative_mm += w[:rain1h]
        end
    end

    return round(cumulative_mm) |> Int
end

    