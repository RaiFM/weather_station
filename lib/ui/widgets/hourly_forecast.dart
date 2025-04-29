import 'package:flutter/material.dart';

class HourlyForecast extends StatelessWidget {
  final String hour;
  final String temp;
  final IconData icon;
  final String chance;

  const HourlyForecast({
    super.key,
    required this.hour,
    required this.temp,
    required this.icon,
    required this.chance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(hour, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 8),
          Icon(icon, size: 24, color: Colors.orangeAccent),
          const SizedBox(height: 8),
          Text(temp, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 4),
          Text("💧$chance", style: const TextStyle(fontSize: 12, color: Colors.white54)),
        ],
      ),
    );
  }
}
