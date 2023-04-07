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
      home: CardPile(),
    ));
  });

}

class CardPile extends StatefulWidget {
  @override
  _CardPileState createState() => _CardPileState();
}

class _CardPileState extends State<CardPile> {
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
  String selectedCard = '';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Kartenlege-App'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.gif'),
            fit: BoxFit.cover,
          ),
        ),
      child: Stack(
        children: [
          // Anzeigen der Kartenrückseite
          ...karten.map((kartenname) {
            final randomAngle = Random().nextInt(90) - 45;
            final randomWidth = Random().nextInt(80) + 140;
            final randomHeight = Random().nextInt(80) + 200;
            final left = screenWidth / 2 - randomWidth / 2;
            final top = screenHeight / 2.5 - randomHeight / 2;
            return Positioned(
              left: left,
              top: top,
              child: Transform.rotate(
                angle: randomAngle * pi / 180,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCard = kartenname;
                    });
                    _showCard(context);
                  },
                  child: Image.asset(
                    'images/back.png',
                    width: randomWidth.toDouble(),
                    height: randomHeight.toDouble(),
                  ),
                ),
              ),
            );
          }).toList(),
          // Anzeigen der ausgewählten Karte
          if (selectedCard.isNotEmpty)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCard = '';
                  });
                },
                child: Container(
                  color: Colors.black54,
                  child: Center(
                    child: Image.asset(
                      'images/$selectedCard',
                      height: 300.0,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
    );
  }

  // Anzeigen einer ausgewählten Karte in einer Dialogbox
  void _showCard(BuildContext context) {
    String newCard;
    do {
      newCard = karten[Random().nextInt(karten.length)];
    } while (newCard == selectedCard);
    setState(() {
      selectedCard = newCard;
    });

    showDialog(
        context: context,
        builder: (BuildContext context) {
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
              builder: (context) => Kartenbeschreibung(kartenname: newCard),
            ),
          );
        }
          },
            child: Image.asset('images/$newCard'),
          ),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              setState(() {
                selectedCard = '';
              });
              Navigator.of(context).pop();
            },
          ),
        ],
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
