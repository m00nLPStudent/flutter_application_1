import 'package:flutter/material.dart';

class Kartenbeschreibung extends StatelessWidget {
  final String kartenname;

  Kartenbeschreibung({required this.kartenname});

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
          const Text(
            'Hier könnte die Beschreibung der Karte stehen.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
