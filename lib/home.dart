import 'package:flutter/material.dart';
import 'weather.dart';

class Home extends StatelessWidget {

@override
Widget build(BuildContext context) {
	return Scaffold(
	appBar: AppBar(
		title: Text("Assignment4"),
	),
	body: Center(
		child: Column(
		mainAxisAlignment: MainAxisAlignment.center,
		children: [
      Text("Welcome to Assignment 4!",style: TextStyle(fontSize: 25)),
			Padding(
			padding:  EdgeInsets.only(bottom: 35),
			child: Image.network(
				"https://images.pexels.com/photos/406014/pexels-photo-406014.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"),
			),
			ElevatedButton(
			child: Text(
				"Go to Weather screen",
				style: TextStyle(fontSize: 25),
			),
			onPressed: ()  {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WeatherApp()),
            );
      },
			)
		],
		),
	),
	);
}
}