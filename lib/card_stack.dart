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
  String previouslySelectedCard = '';
  bool isSecondTap = false;
  bool shouldShowCard = false;

  Translation translation = Translation(entries: {});

  void _readFile() async {
    FileStorage storage = FileStorage(locale: "trTR");
    translation = await storage.parseFile();
  }

  @override
  void initState() {
    super.initState();
    _readFile();
  }

  @override
  Widget build(BuildContext context) {
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
            if (selectedCard.isNotEmpty && isSecondTap)
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (selectedCard == previouslySelectedCard && !isSecondTap) {
                        isSecondTap = true;
                      } else if (selectedCard == previouslySelectedCard && isSecondTap) {
                        isSecondTap = false;
                        shouldShowCard = true;
                        _showCard(context);
                      } else {
                        previouslySelectedCard = selectedCard;
                        selectedCard = '';
                        isSecondTap = false;
                      }
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

    final double sizeFactor = screenWidth > 600 ? 1.4 : 1.0;
    final double cardWidth = screenWidth * 0.45 * sizeFactor;
    final double cardHeight = screenHeight * 0.2 * sizeFactor;

    final double centerX = screenWidth * (screenWidth > 600 ? 0.8 : 0.85);
    final double centerY = screenHeight * (screenWidth > 600 ? 0.7 : 0.6);

    final double radius = screenWidth > 600 ? 280.0 * sizeFactor : 140.0;
    final double angleStep = pi / (karten.length - 1);
    final double currentAngle = angleStep * index;

    return Positioned(
      left: centerX - cardWidth / 2 - radius * (1 - cos(currentAngle)),
      top: centerY - cardHeight / 2 - radius * sin(currentAngle) + (selectedCard == kartenname ? -20 : 0), // Verschieben der ausgewählten Karte nach oben
      child: Transform.rotate(
        angle: -currentAngle,
        child: GestureDetector(
          onTap: () {
            setState(() {
              if (selectedCard == kartenname) {
                if (!isSecondTap) {
                  setState(() {
                    isSecondTap = true;
                  });
                } else {
                  setState(() {
                    isSecondTap = false;
                    shouldShowCard = true;
                  });
                  _showCard(context);
                }
              } else {
                setState(() {
                  selectedCard = kartenname;
                  isSecondTap = false;
                });
              }
            });
          },
          child: Image.asset(
            'images/back.png',
            width: cardWidth,
            height: cardHeight,
          ),
        ),
      ),
    );
  }

  // Anzeigen einer ausgewählten Karte in einer Dialogbox
  void _showCard(BuildContext context) {
    final String description = translation.translate(selectedCard);

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
                    kartenname: selectedCard,
                    description: description,
                  ),
                ),
              );
            }
          },

          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'images/$selectedCard',
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.7,
                fit: BoxFit.contain,
              ),
              Positioned(
                top: 20,
                child: Text(
                  selectedCard,
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
                            kartenname: selectedCard,
                            description: description,
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
    shouldShowCard = false;
  }
}