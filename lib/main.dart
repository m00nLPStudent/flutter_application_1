import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kartenlege-App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kartenlege-App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Drücke den Button, um eine Tarotkarte zu ziehen:'),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: Text('Karte ziehen'),
                onPressed: () => zieheKarte(context),
              ),
              SizedBox(height: 20.0),
              Image.asset(
                'images/placeholder.png',
                height: 300.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void zieheKarte(BuildContext context) {
    final karten = [
      '1.png',
      '2.png',
      '3.png',
      '4.png',
      '5.png',
      '6.png',
      '7.png',
      '8.png',
      '9.png',
      '10.png',
      '11.png',
      '12.png',
      '13.png',
      '14.png',
      '15.png',
      '16.png',
      '17.png',
      '18.png',
      '19.png',
      '20.png',
      '21.png',
      '22.png'
    ];
    final zufallszahl = Random().nextInt(karten.length);
    final kartenname = karten[zufallszahl];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Deine Tarotkarte'),
          content: Image.asset('images/$kartenname'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
