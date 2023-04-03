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
    oktas = w[:clouds] / 12.5 |> round |> Int
    words = [:clouds_0_oktas, 
             :clouds_1_okta, :clouds_2_oktas, :clouds_3_oktas,
             :clouds_4_oktas, :clouds_5_oktas, :clouds_6_oktas,
             :clouds_7_oktas, :clouds_8_oktas]

    temp_celsius = w[:temperature] - 273.15 |> round |> Int

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

    # rain:
    #
    rain_1h = w[:rain]

    publish_say(:weather_is)
    publish_say(words[oktas])

    publish_say(:sky_is, oktas, :sky_is_2)
    publish_say(:temperature_is, temp_celsius, :temperature_is_2)
    publish_say(:wind_is, wind_speed, wind_name)

    if rain_1h < 0.1
        publish_say(:no_rain)
    else
        publish_say(:rain_now, rain_1h, :rain_now_2)
    end
end



    rain_today = get_rain()[:today]
    rain_2_days = get_rain()[:two_days]