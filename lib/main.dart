import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
  Future.delayed(Duration(seconds: 3), () {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ));
  });

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
      '21.png'
    ];
    final zufallszahl = Random().nextInt(karten.length);
    final kartenname = karten[zufallszahl];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Deine Tarotkarte'),
              content: GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity == 0) return;
                  if (details.primaryVelocity?.compareTo(0) == -1) {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Kartenbeschreibung(kartenname: kartenname),
                      ),
                    );
                  }
                },
                child: Image.asset('images/$kartenname'),
              ),
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
      },
    );
  }
}

class Kartenbeschreibung extends StatelessWidget {
  final String kartenname;

  Kartenbeschreibung({required this.kartenname});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beschreibung'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/$kartenname',
            height: 300.0,
          ),
          SizedBox(height: 20.0),
          Text(
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
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Kartenlege-App'),
      ),
    );
  }
}
