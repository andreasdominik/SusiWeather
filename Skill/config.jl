# DO NOT CHANGE THE FOLLOWING 3 LINES UNLESS YOU KNOW
# WHAT YOU ARE DOING!
# set CONTINUE_WO_HOTWORD to true to be able to chain
# commands without need of a hotword in between:
#
const CONTINUE_WO_HOTWORD = false

# set a local const LANG:
#
const LANG = get_language()



# Slots:
# Name of slots to be extracted from intents:
#


# name of entries in config.ini:
#

#
# link between actions and intents:
# intent is linked to action::Funktion
#
# register_intent_action("TEMPLATE_SKILL", TEMPLATE_INTENT_action)
# register_on_off_action(TEMPLATE_INTENT_action)
register_intent_action("Susi:TellWeather", Susi_TellWeather_action)
register_intent_action("Susi:TellRain", Susi_TellRain_action)
register_intent_action("Susi:TellWind", Susi_TellWind_action)
