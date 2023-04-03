#
# actions called by the main callback()
# provide one function for each intent, defined in the Snips/Rhasspy
# console.
#
# ... and link the function with the intent name as shown in config.jl
#
# The functions will be called by the main callback function with
# 2 arguments:
# + MQTT-Topic as String
# + MQTT-Payload (The JSON part) as a nested dictionary, with all keys
#   as Symbols (Julia-style).
#




"""
    Susi_TellWeather_action(topic, payload)

Echo the current weather.
"""
function Susi_TellWeather_action(topic, payload)

    print_log("action Susi_TellWeather_action() started.")
    
    w = get_weather()
    if isnothing(w)
        publish_say(:no_weather_service)
    else
        tell_current_weater(w)
    end

    publish_end_session()
    return true
end




"""
    Susi_TellRain_action(topic, payload)

Echo the rain of the last days.
"""
function Susi_TellRain_action(topic, payload)

    print_log("action Susi_TellRain_action() started.")

    weather_history = db_read_value(:SusiWeather, :times)
    if isnothing(weather_history) || length(weather_history) < 1
        publish_say(:no_weather_service)
    else
        tell_rain_status(weather_history)
    end
    publish_end_session()
    return true
end




"""
    Susi_TellWind_action(topic, payload)

Tell the wind
"""
function Susi_TellWind_action(topic, payload)

    print_log("action Susi_TellWind_action() started.")

    w = get_weather()
    if isnothing(w)
        publish_say(:no_weather_service)
    else
        tell_current_wind(w)
    end

    publish_end_session()
    return true
end
