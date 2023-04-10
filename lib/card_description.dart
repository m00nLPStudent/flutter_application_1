import 'package:flutter/material.dart';

class Kartenbeschreibung extends StatelessWidget {
  Kartenbeschreibung({required this.kartenname, required this.description});

  final String kartenname;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beschreibung'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/$kartenname',
            height: 300.0,
          ),
          const SizedBox(height: 20.0),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
