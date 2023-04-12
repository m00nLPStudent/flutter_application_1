import 'package:flutter/material.dart';
import 'dart:math';
import 'card_description.dart';
import 'card_translation.dart';
import 'card_list.dart';

class CardStackWidget extends StatefulWidget {
  const CardStackWidget({super.key});

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

/*
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _readFile();
    });
  }
*/

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
            ...karten.map((name) => _selectCard(name, context)).toList(),
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

  Positioned _selectCard(String kartenname, BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double cardWidth = screenWidth * 0.6;
    final double cardHeight = screenHeight * 0.4;
    final double left = (screenWidth - cardWidth) / 2;
    final double top = (screenHeight - cardHeight) / 2;

    final randomAngle = Random().nextInt(90) - 45;

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
