import 'package:flutter/material.dart'; // Import the Material package for Flutter
import 'package:http/http.dart' as http; // Import the http package for making HTTP requests
import 'dart:convert'; // Import the dart:convert package for handling JSON data
import 'calculator.dart';

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  String _cityName = ''; // Variable to store the city name
  String _temperature = ''; // Variable to store the temperature
  String _description = ''; // Variable to store the weather description
  String _iconUrl = ''; // Variable to store the URL of the weather icon

  void _fetchWeatherData(String city) async {
    // Function to fetch weather data from OpenWeatherMap API
    final apiKey = 'c09de3c12c53dd062385eea229201855';
    final apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';// API endpoint for weather data
    final response = await http.get(Uri.parse(apiUrl)); // Make GET request to the API

    if (response.statusCode == 200) {
      // If the response is successful
      final data = json.decode(response.body);// Decode the JSON response
      setState(() {
        // Update the state with the fetched data
        _cityName = data['name'];
        _temperature = data['main']['temp'].toString();
        _description = data['weather'][0]['description'];
        _iconUrl = 'http://openweathermap.org/img/w/${data['weather'][0]['icon']}.png';
      });
    } else {
      // If the response is not successful
      setState(() {
      // Update the state with error message
        _cityName = 'Error';
        _temperature = 'N/A';
        _description = 'Failed to fetch weather data';
        _iconUrl = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather App'),
        ),
        body: Column(
          children: [
            SizedBox(height: 16),
            Text(
              'City: $_cityName', // Display city name
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Temperature: $_temperature°C', // Display temperature
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Description: $_description', // Display weather description
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            _iconUrl.isNotEmpty
                ? Image.network(
                    _iconUrl, // Display weather icon
                    width: 50,
                    height: 50,
                  )
                : Container(),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Enter City'),
                      content: TextField(
                        onChanged: (value) {
                          _cityName = value; // Update city name as user types
                        },
                      ),
                      actions: [
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        ElevatedButton(
                          child: Text('Fetch Weather'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            _fetchWeatherData(_cityName); // Fetch weather data
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Fetch Weather'),
            ),
            ElevatedButton(
                        child: Text(
                          "Go to Calculator screen",
                          style: TextStyle(fontSize: 25),
                        ),
                        onPressed: ()  {
                              Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CalculatorApp()),
                            );
                        },
                        ),
                        ElevatedButton(
                          child: Text(
                            "Go back!",
                            style: TextStyle(fontSize: 25),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
          ],
        ),
      ),
    );
  }
}