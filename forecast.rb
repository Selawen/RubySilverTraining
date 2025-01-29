require 'httparty'
require_relative 'asciiImgs'
require_relative 'string'
require 'win32/sound'

class Forecast
include HTTParty
include Win32

def self.get_coordinates(cityname: )

    return if cityname == 'exit'    
    cityname = 'Delft' if cityname == '' 

    begin
        url = ['https://geocoding-api.open-meteo.com/v1/search?name=', cityname, '&count=1&language=en&format=json'].join('')
    rescue StandardError => e
        puts 'city not found'
        get_coordinates(cityname: get_query)
        return 
    end

    response = HTTParty.get(url)
    coords = {}

    if response.parsed_response['results'] == nil
        puts 'city not found'
        get_coordinates(cityname: get_query)
        return 
    end

    response.parsed_response['results'].each do |result|
            coords['latitude'] = result['latitude']
            coords['longitude'] = result['longitude']
    end

    #puts coords

    get_forecast(latitude: coords['latitude'], longitude: coords['longitude'])
end

def self.weather_to_ascii(current_weather:)
    
    case current_weather['cloud_cover']
        when 10..60
            puts 'it is slighly cloudy'
            if current_weather['rain'] > 0.0
                puts AsciiImages::SLIGHTLYCLOUDYRAINASCII.blue
                Sound.play("C:\Users\i.smit\Downloads\512217__mateusz_chenc__poof-in-cloud.mp3")
                #puts 'and rainy'
            else
                puts AsciiImages::SLIGHTLYCLOUDYASCII.grey
                Sound.play("C:\Users\i.smit\Downloads\594899__messyacousticapocalypse666__rain-stick.wav")
                #puts 'but not rainy'
            end
        when 60..100
            puts 'it is cloudy'
            if current_weather['rain'] > 0.0
                puts AsciiImages::CLOUDYRAINASCII.blue
                Sound.play("C:\Users\i.smit\Downloads\512217__mateusz_chenc__poof-in-cloud.mp3")
                #puts 'and rainy'
            else
                puts AsciiImages::CLOUDYASCII.grey
                Sound.play("C:\Users\i.smit\Downloads\594899__messyacousticapocalypse666__rain-stick.wav")
                #puts 'but not rainy'
            end
        else    
            puts 'it is sunny'
            puts AsciiImages::SUNNYASCII.yellow
            Sound.play("C:\Users\i.smit\Downloads\472590__michellelindemann1__sun-shining-day-sentence-by-female-girl-voice.wav")
        end
end

def self.get_wind_direction(wind_degrees:)
    case wind_degrees
        when 22..67
            return 'NorthEast'
        when 67..111
            return 'East'
        when 111..156
            return 'SouthEast'
        when 156..201
            return 'South'
        when 201..246
            return 'SouthWest'
        when 246..291
            return 'West'
        when 291..336
            return 'NorthWest'
        else                        
            return 'North'
        end
end

def self.get_forecast(latitude:,longitude:)
    #https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&hourly=temperature_2m

    url = ['https://api.open-meteo.com/v1/forecast?latitude=', latitude, '&longitude=', longitude, '&current=temperature_2m,precipitation,rain,cloud_cover,wind_speed_10m,wind_direction_10m'].join('')
    response = HTTParty.get(url)

    #puts response#['current']

    response['current'].each do |resultkey, resultvalue|
        case resultkey
            when 'temperature_2m'
                @temp = resultvalue
            when 'precipitation'
                @precipitation = resultvalue
            when 'rain'
                @rain = resultvalue
            when 'wind_speed_10m'
                @wind_speed = resultvalue
            when 'wind_direction_10m'
                @wind_direction = get_wind_direction(wind_degrees: resultvalue) 
            end
    end

    weather_to_ascii(current_weather: response['current'])

    puts ['temperature is: ', @temp, response['current_units']['temperature_2m']].join.green
    puts ['rain chance is: ', @rain, '%'].join.light_blue
    puts ['rain is: ', @precipitation, ' mm'].join.light_blue
    puts ['wind strength is: ', @wind_speed, ' km/h from the ', @wind_direction].join.yellow

    
get_coordinates(cityname: get_query)
end

def self.get_query
    puts 'for where do you want your forecast?'
    location = gets.chomp
end

#get_coordinates(cityname: 'delft')
get_coordinates(cityname: get_query)

end