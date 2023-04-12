import 'package:flutter/material.dart';
import 'dart:math';
import 'card_description.dart';
import 'card_translation.dart';
import 'card_list.dart';

class CardStackWidget extends StatefulWidget {
  const CardStackWidget({Key? key}) : super(key: key);

  @override
  CardStack createState() => CardStack();
}

class CardStack extends State<CardStackWidget> {
  final karten = cardList;
  String selectedCard = '';

  Translation translation = Translation(entries: {});

  void _readFile() async {
    FileStorage storage = FileStorage(locale: "trTR");
    translation = await storage.parseFile();
  }

  @override
  Widget build(BuildContext context) {
    _readFile();

    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Anzeigen der Kartenrückseite
            ...karten.asMap().entries.map((entry) => _selectCard(entry.key, entry.value, context)).toList(),
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

  Positioned _selectCard(int index, String kartenname, BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Größe der Karten dynamisch an die Bildschirmgröße anpassen
    final double cardWidth = screenWidth * (screenWidth > 600 ? 0.35 : 0.45);
    final double cardHeight = screenHeight * (screenWidth > 600 ? 0.15 : 0.2);

    final double centerX = screenWidth * 0.85; // erhöht, um den Fächer weiter in die Mitte zu bewegen
    final double centerY = screenHeight * 0.6; // erhöht, um den Fächer nach oben zu bewegen

    // Radius des Bogens dynamisch an die Bildschirmgröße anpassen
    final double radius = screenWidth > 600 ? 280.0 : 140.0;
    final double angleStep = pi / (karten.length - 1);
    final double currentAngle = angleStep * index;

    final double xOffset = radius * (1 - cos(currentAngle));
    final double yOffset = radius * sin(currentAngle);

    return Positioned(
        left: centerX - cardWidth / 2 - xOffset,
        top: centerY - cardHeight / 2 - yOffset,
        child: Transform.rotate(
          angle: -currentAngle,
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedCard = kartenname;
              });
              _showCard(context);
            },
            child: Image.asset(
              'images/back.png',
              width: cardWidth,
              height: cardHeight,
            ),
          ),
        ));
  }

  // Anzeigen einer ausgewählten Karte in einer Dialogbox
  void _showCard(BuildContext context) {
    String newCard;
    String newDesc;
    do {
      newCard = karten[Random().nextInt(karten.length)];
      newDesc = translation.translate(newCard);
    } while (newCard == selectedCard);
    setState(() {
      selectedCard = newCard;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity == 0) return;

            if (details.primaryVelocity?.compareTo(0) == -1) {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Kartenbeschreibung(
                    kartenname: newCard,
                    description: newDesc,
                  ),
                ),
              );
            }
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'images/$newCard',
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.7,
                fit: BoxFit.contain,
              ),
              Positioned(
                top: 20,
                child: Text(
                  newCard,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                bottom: 50,
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 500),
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  builder: (BuildContext context, double value, Widget? child) {
                    return Transform.scale(
                      scale: value,
                      child: child,
                    );
                  },
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Kartenbeschreibung(
                            kartenname: newCard,
                            description: newDesc,
                          ),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
