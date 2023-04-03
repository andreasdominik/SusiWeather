
# SusiWeather - Snips/Rhasspy Skill to tell the current weather condition

Simple skill for a
Snips-like home assistant (i.e. Rhasspy).     
The skill is written in Julia with the HermesMQTT.jl framework.

Some time ago, I read that the most popular apps on the Google Play Store 
are Weather apps. 
Although it is not quite understandable what the point of an app is 
that tells you approximately what you can also experience by looking 
out of the window, there are at least 2 reasons to write a weather skill for 
an home assistant:

Firstly it is possible to use the app remotely and ask for the weather
condition at home while beeing somewhere else (and remotly control 
irrigation or sun protection, if necessary).

Another reason may be that using the *HermesMQTT* skill generator
makes coding the app a work of less than 10 minutes (actually writing this README
takes longer than coding the skill).

### Julia

This skill is (like the entire HermesMQTT.jl framework) written in the
modern programming language Julia (because Julia is faster
then Python and coding is much much easier and much more straight forward).
However "Pythonians" often need some time to get familiar with Julia.

If you are ready for the step forward, start here: https://julialang.org/

Learn more about writing skills in Julia with HermesMQTT.jl here: 
 [![](https://img.shields.io/badge/docs-latest-blue.svg)](https://andreasdominik.github.io/HermesMQTT.jl/dev)



## Installation

The skill can be installed from within the Julia REPL with the following
commands, if the HermesMQTT.jl framework is already installed 
and configured:

```julia
using HermesMQTT

install("SusiWeather")
```

If the Rhasspy server is running (recommended) the installer will
install the skill on the local machine and upload intents and slots
to the Rhasspy server (locally or remote in a server-satellite setup).

Of course a weather service must be configured in the HermesMQTT configuration.


## Intents

The skill responds to the following intents:

### Susi:TellWeather
Give a brief summary of local weather conditions.


### Susi:TellRain
Tell the rain in the last days.


### Susi:TellWind
Tell the current wind speed and direction.



## Languages

Current supported languages include English and German.

