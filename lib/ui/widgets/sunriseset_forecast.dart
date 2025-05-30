import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';

class SunriseAndSetForecast extends StatefulWidget {
  const SunriseAndSetForecast(
      {super.key, required this.sunriseHour, required this.sunsetHour});
  final String sunriseHour;
  final String sunsetHour;

  @override
  State<SunriseAndSetForecast> createState() => _SunriseAndSetForecastState();
}

class _SunriseAndSetForecastState extends State<SunriseAndSetForecast> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Color.fromARGB(14, 0, 47, 255),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.sunrise_fill,
                color: Color.fromARGB(200, 255, 238, 0),
                size: 24,
                shadows: <Shadow>[
                  Shadow(
                      color: Colors.black54,
                      blurRadius: 1.0,
                      offset: Offset(1.0, 2.0))
                ],
              ),
              SizedBox(width: 12),
              Text("Nascer do Sol"),
            ],
          ),
          const SizedBox(height: 12),
          Text(widget.sunriseHour),
          const SizedBox(height: 24),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.sunset_fill,
                color: Color.fromARGB(169, 218, 167, 0),
                size: 24,
                shadows: <Shadow>[
                  Shadow(
                      color: Colors.black54,
                      blurRadius: 1.0,
                      offset: Offset(1.0, 2.0))
                ],
              ),
              SizedBox(width: 12),
              Text("Pôr do Sol"),
            ],
          ),
          const SizedBox(height: 12),
          Text(widget.sunsetHour),
        ],
      ),
    );
  }
}
