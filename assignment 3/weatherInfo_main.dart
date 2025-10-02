import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const WeatherInfoApp());
}

class WeatherInfoApp extends StatelessWidget {
  const WeatherInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Weather Info',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const WeatherHomePage(),
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final TextEditingController _cityController = TextEditingController();
  final Random _random = Random();
  String? _fetchedCity;
  int? _fetchedTemperature;
  String? _fetchedCondition;
  List<Map<String, dynamic>>? _forecastData;

  IconData _conditionIcon(String? condition) {
    switch (condition) {
      case 'Sunny':
        return Icons.wb_sunny;
      case 'Rainy':
        return Icons.beach_access;
      case 'Cloudy':
        return Icons.cloud_outlined;
      default:
        return Icons.wb_cloudy_outlined;
    }
  }

  Color _conditionColor(String? condition) {
    switch (condition) {
      case 'Sunny':
        return Colors.amber.shade600;
      case 'Rainy':
        return Colors.indigo.shade400;
      case 'Cloudy':
        return Colors.blueGrey;
      default:
        return Colors.lightBlue;
    }
  }

  void _simulateWeatherFetch() {
    final city = _cityController.text.trim();

    if (city.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a city name first.')),
      );
      return;
    }

    FocusScope.of(context).unfocus();

    final formattedCity = city
        .split(' ')
        .where((word) => word.isNotEmpty)
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
    final temperature = 15 + _random.nextInt(16);
    const conditions = ['Sunny', 'Cloudy', 'Rainy'];
    final condition = conditions[_random.nextInt(conditions.length)];

    setState(() {
      _fetchedCity = formattedCity.isEmpty ? city : formattedCity;
      _fetchedTemperature = temperature;
      _fetchedCondition = condition;
    });
  }

  void _simulateForecastFetch() {
    final city = _cityController.text.trim();

    if (city.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a city name first.')),
      );
      return;
    }

    FocusScope.of(context).unfocus();

    final formattedCity = city
        .split(' ')
        .where((word) => word.isNotEmpty)
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');

    const conditions = ['Sunny', 'Cloudy', 'Rainy'];
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    
    List<Map<String, dynamic>> forecast = [];
    for (int i = 0; i < 7; i++) {
      final temperature = 12 + _random.nextInt(20); // 12-31°C range
      final condition = conditions[_random.nextInt(conditions.length)];
      final dayName = days[i];
      
      forecast.add({
        'day': dayName,
        'temperature': temperature,
        'condition': condition,
      });
    }

    setState(() {
      _fetchedCity = formattedCity.isEmpty ? city : formattedCity;
      _forecastData = forecast;
    });
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Info'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.lightBlue, Colors.white],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Simple Weather Info',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Type a city to explore its weather conditions.',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      TextField(
                        controller: _cityController,
                        decoration: InputDecoration(
                          hintText: 'Enter city name',
                          filled: true,
                          fillColor: Colors.lightBlue.shade50,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          prefixIcon: const Icon(Icons.location_city),
                        ),
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _simulateWeatherFetch,
                              icon: const Icon(Icons.cloud_outlined),
                              label: const Text('Today'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                textStyle: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _simulateForecastFetch,
                              icon: const Icon(Icons.calendar_today),
                              label: const Text('7-Day'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                textStyle: const TextStyle(fontSize: 16),
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: _fetchedCity == null ? 0.6 : 1.0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.lightBlue.shade50,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.lightBlue.shade200,
                            ),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'City: ${_fetchedCity ?? '—'}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Temperature: '
                                '${_fetchedTemperature != null ? '$_fetchedTemperature°C' : '— °C'}',
                                style: const TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Icon(
                                    _conditionIcon(_fetchedCondition),
                                    color: _conditionColor(_fetchedCondition),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Condition: ${_fetchedCondition ?? '—'}',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (_forecastData != null) ...[
                        const SizedBox(height: 24),
                        const Text(
                          '7-Day Forecast',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.orange.shade200,
                            ),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: _forecastData!.map((day) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withValues(alpha: 0.1),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      day['day'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          _conditionIcon(day['condition']),
                                          color: _conditionColor(day['condition']),
                                          size: 20,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '${day['temperature']}°C',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          day['condition'],
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
