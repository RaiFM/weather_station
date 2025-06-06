import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_station/domain/model/clima_model.dart';

class WeeklyForecast extends StatelessWidget {
  final ClimaModel? climaInfo;

  const WeeklyForecast({super.key, required this.climaInfo});

  IconData? decideIconFromConditionSlug(String conditionSlug) {
    switch (conditionSlug) {
      case "storm":
        return Icons.thunderstorm_rounded;
      case "snow":
        return Icons.cloudy_snowing;
      case "hail":
        return Icons.ac_unit_rounded;
      case "rain":
        return CupertinoIcons.cloud_rain_fill;
      case "fog":
        return Icons.foggy;
      case "clear_day":
        return Icons.wb_sunny_rounded;
      case "clear_night":
        return Icons.nightlight_round_rounded;
      case "cloud":
        return Icons.cloud;
      case "cloudly_day":
        return CupertinoIcons.cloud_sun_fill;
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 20),
          Text(climaInfo!.diaSemana, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 8),
          Icon(
            decideIconFromConditionSlug(climaInfo!.icone),
            size: 24,
            color: const Color.fromARGB(255, 255, 255, 255),
            shadows: const <Shadow>[
              Shadow(
                  color: Colors.black87,
                  blurRadius: 2.0,
                  offset: Offset(0, 2.0))
            ],
          ),
          const SizedBox(height: 8),
          Center(
            child: Text("${climaInfo!.tempMin}°C \n ${climaInfo!.tempMax}°C",
                style: const TextStyle(fontSize: 12)),
          ),
          const SizedBox(height: 4),
          Text("${climaInfo!.precipitacao} mm",
              style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          Text("💧 ${climaInfo!.chanceChuva}%",
              style: const TextStyle(
                  fontSize: 12, color: Color.fromARGB(224, 255, 255, 255))),
        ],
      ),
    );
  }
}

class WeeklyForecastList extends StatefulWidget {
  final List<ClimaModel?> previsaoReq;
  const WeeklyForecastList({super.key, required this.previsaoReq});

  @override
  State<WeeklyForecastList> createState() => _WeeklyForecastList();
}

class _WeeklyForecastList extends State<WeeklyForecastList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Color.fromARGB(3, 0, 47, 255),
      ),
      child: Center(
        child: ListView.builder(
          padding: const EdgeInsets.only(left: 10, right: 10),
          itemCount: widget.previsaoReq.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const ScrollPhysics(),
          itemBuilder: (context, index) {
            return WeeklyForecast(
              climaInfo: widget.previsaoReq[index],
            );
          },
        ),
      ),
    );
  }
}
