import 'package:flutter/material.dart';

class DailyForecast extends StatelessWidget {
  final String day;
  final IconData icon;
  final String chance;
  final String high;
  final String low;

  const DailyForecast({
    super.key,
    required this.day,
    required this.icon,
    required this.chance,
    required this.high,
    required this.low,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(day, style: const TextStyle(fontSize: 16)),
          Row(
            children: [
              Icon(icon, size: 22, color: Colors.blueAccent),
              const SizedBox(width: 4),
              Text("💧$chance", style: const TextStyle(fontSize: 12, color: Colors.white54)),
            ],
          ),
          Text("$high / $low", style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
