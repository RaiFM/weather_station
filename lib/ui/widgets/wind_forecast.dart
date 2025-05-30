import 'package:flutter/material.dart';

class WindForecast extends StatefulWidget {
  final String windCardinal;
  final int windDirection;
  final String windSpeed;

  const WindForecast({
    super.key,
    required this.windCardinal,
    required this.windDirection,
    required this.windSpeed,
  });

  @override
  State<WindForecast> createState() => _WindForecastState();
}

class _WindForecastState extends State<WindForecast> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Color.fromARGB(14, 0, 47, 255),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Vento"),
          const SizedBox(height: 24),
          const Icon(
            Icons.wind_power_rounded,
            color: Colors.white70,
            size: 54,
            shadows: <Shadow>[
              Shadow(
                  color: Colors.black54,
                  blurRadius: 1.0,
                  offset: Offset(1.0, 2.0))
            ],
          ),
          const SizedBox(height: 12),
          Text("À ${widget.windSpeed}"),
          Text("em direção do ${widget.windCardinal}")
        ],
      ),
    );
  }
}
