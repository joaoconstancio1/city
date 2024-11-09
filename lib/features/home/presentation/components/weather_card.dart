import 'dart:math';
import 'package:flutter/material.dart';
import 'package:city/features/home/domain/entities/city_entity.dart';

class WeatherCard extends StatelessWidget {
  final CityEntity city;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const WeatherCard({
    super.key,
    required this.city,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final weatherData = _getRandomWeatherData();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: weatherData.gradientColors,
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      city.city ?? 'Unknown City',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.white),
                        onPressed: onEdit,
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.white),
                        onPressed: onDelete,
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    '${city.temperature}°C',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 14),
                  Icon(
                    weatherData.icon,
                    color: Colors.white,
                    size: 32,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                city.description ?? 'No description available.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _WeatherData _getRandomWeatherData() {
    final random = Random();
    final weatherTypes = [
      _WeatherData(
        icon: Icons.wb_sunny,
        gradientColors: [Colors.orange, Colors.yellow],
      ),
      _WeatherData(
        icon: Icons.umbrella,
        gradientColors: [Colors.blueGrey, Colors.blue],
      ),
      _WeatherData(
        icon: Icons.cloud,
        gradientColors: [Colors.grey, Colors.blueGrey],
      ),
      _WeatherData(
        icon: Icons.flash_on,
        gradientColors: [Colors.deepPurple, Colors.black],
      ),
      _WeatherData(
        icon: Icons.ac_unit,
        gradientColors: [Colors.lightBlue, Colors.white],
      ),
    ];

    return weatherTypes[random.nextInt(weatherTypes.length)];
  }
}

class _WeatherData {
  final IconData icon;
  final List<Color> gradientColors;

  _WeatherData({
    required this.icon,
    required this.gradientColors,
  });
}
