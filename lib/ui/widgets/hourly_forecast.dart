import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_station/domain/model/clima_model.dart';

class HourlyForecast extends StatelessWidget {
  final ClimaModel? climaInfo;

  const HourlyForecast({
    super.key,
    required this.climaInfo
  });

  IconData? decideIconFromConditionSlug(String conditionSlug){
    switch(conditionSlug){
      case "storm":
      return Icons.thunderstorm;
    case "snow":
      return Icons.cloudy_snowing;
    case "hail":
      return Icons.ac_unit;
    case "rain":
      return CupertinoIcons.cloud_rain_fill;
    case "fog":
      return Icons.foggy;
    case "clear_day":
      return Icons.sunny;
    case "clear_night":
      return Icons.nightlight_round_rounded;
    case "cloud":
      return Icons.cloud;
    case "cloudly_day":
      return CupertinoIcons.cloud_sun;
    case "cloudly_night":
      return CupertinoIcons.cloud_moon_fill;
      case "none_day":
      return CupertinoIcons.sun_max_fill;
    case "none_night":
      return CupertinoIcons.moon_fill;
    default:
      return Icons.error_outline;
  }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(climaInfo!.diaSemana, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 8),
          Icon(decideIconFromConditionSlug(climaInfo!.icone), size: 24, color: Colors.orangeAccent),
          const SizedBox(height: 8),
          Text("${climaInfo!.tempMin}°C - ${climaInfo!.tempMax}°C", style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 4),
          Text("${climaInfo!.precipitacao} mm", style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 4),
          Text("💧 ${climaInfo!.chanceChuva}%", style: const TextStyle(fontSize: 12, color: Color.fromARGB(224, 255, 255, 255))),
        ],
      ),
    );
  }
}

class HourlyForecastList extends StatefulWidget {
  final List<ClimaModel?> previsaoReq;  
  const HourlyForecastList({super.key, required this.previsaoReq});


  @override
  State<HourlyForecastList> createState() => _HourlyForecastListState();
}

class _HourlyForecastListState extends State<HourlyForecastList> {


  @override
  Widget build(BuildContext context) {
    return ListView(
                      semanticChildCount: 24,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const ScrollPhysics(),
                      children: [
                        HourlyForecast(climaInfo: widget.previsaoReq[0],),
                      ],
                    );
  }
}
