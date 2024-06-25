import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/services/weather_service.dart';

import '../model/weather_model.dart';

class WeatherPage extends StatefulWidget{
  const  WeatherPage ({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage>{

  //api key
  final _weatherService = WeatherService('2dac16b5dab5d9c9a0c911eece7142c8');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async{
    // get current city
    String cityName = await _weatherService.getCurrentCity();

    // get weather for the city
    try{
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    // any errors
    catch(e){
      print(e);
    }
  }

  // weather animationss
  String getWeatherAnimation(String? mainCondition){
    if(mainCondition == null)
      return 'assets/loading.json';

    switch (mainCondition.toLowerCase()){
      case 'clouds':
        return 'assets/clouds.json';
      case 'mist':
        return 'assets/mist.json';
      case 'smoke':
        return 'assets/smoke.json';
      case 'haze':
        return 'assets/haze.json';
      case 'dust':
        return 'assets/dust.json';
      case 'fog':
        return 'assets/fog.json';
      case 'rain':
        return 'assets/rain.json';
      case 'drizzle':
        return 'assets/drizzle.json';
      case 'shower rain':
        return 'assets/shower_rain.json';
      case 'thunderstorm':
        return 'assets/thunderstorm.json';
      case 'clear':
        return 'assets/clear.json';
      default:
        return 'assets/default.json';
    }
  }


  // init state
  @override
  void initState() {
    super.initState();

    // fetch weather app on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://imgs.search.brave.com/Djr7tMHztamB0u_DGjM_Ii-z5_g_ZTmukrWwUe5RrJY/rs:fit:860:0:0/g:ce/aHR0cHM6Ly93YWxs/cGFwZXJzLmNvbS9p/bWFnZXMvaGQvYmx1/ZS1ncmFkaWVudC1i/YWNrZ3JvdW5kLTg4/ZWV4MWgyMGg5Zjgx/ZnMuanBn'),
            fit: BoxFit.cover,
          ),
        ),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // city name
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 45),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(_weather?.cityName ?? "loading city...",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                ],
              ),

              //animations
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
                  child: Lottie.asset(getWeatherAnimation(_weather?.mainCondition),
                    height: MediaQuery.of(context).size.height * 0.40,
                    width: MediaQuery.of(context).size.width * 0.80,
                    fit: BoxFit.fill,
                  ),
              ),

              //temperature
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
                child: Text('${_weather?.temperature.round()}°C',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),

              //weather condtions
              Text((_weather?.mainCondition ?? ""),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }

}