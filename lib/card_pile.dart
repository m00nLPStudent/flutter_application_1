import 'package:flutter/material.dart';
import 'dart:math';
import 'card_description.dart';
import 'card_translation.dart';
import 'card_list.dart';


class CardPile extends StatefulWidget {
  @override
  _CardPileState createState() => _CardPileState();
}

class _CardPileState extends State<CardPile> {
  final karten = card_list;
  String selectedCard = '';

  Translation translation = Translation(entries: {});

  void _readFile() async {
    FileStorage storage = FileStorage(locale: "enEN");
    translation = await storage.parseFile();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _readFile();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    _readFile();

    double cardWidth = screenWidth * 0.6;
    double cardHeight = screenHeight * 0.4;
    double left = (screenWidth - cardWidth) / 2;
    double top = (screenHeight - cardHeight) / 2;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: null,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.home, size: 40,),
          onPressed: () {
            // Behandeln Sie den Klick auf den Navigationsknopf
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.history, size: 40),

            onPressed: () {
              // Behandeln Sie den Klick auf die Suchschaltfläche
            },
          ),
          IconButton(
          icon: Icon(Icons.language, size: 40),
            onPressed: () {
              // Behandeln Sie den Klick auf das Menü-Symbol
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
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
                  ...karten.map((kartenname) {
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
          ),
          SizedBox(
            height: 50,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  if (constraints.maxWidth > 600) {
                    // code for wide screen
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // navigate to Datenschutzerklärung
                          },
                          child: const Text(
                            'Datenschutzerklärung',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // navigate to Nutzungsbedingungen
                          },
                          child: const Text(
                            'Nutzungsbedingungen',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // navigate to Kontakt
                          },
                          child: const Text(
                            'Kontakt',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // navigate to Impressum
                          },
                          child: const Text(
                            'Impressum',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    );
                  } else {
                    // code for small screen
                    return Row(
                      children: [
                        Expanded(
                          child: PopupMenuButton<String>(
                            itemBuilder: (BuildContext context) {
                              return {
                                'Datenschutzerklärung',
                                'Nutzungsbedingungen',
                                'Kontakt',
                                'Impressum'
                              }.map((String choice) {
                                return PopupMenuItem<String>(
                                  value: choice,
                                  child: Text(
                                    choice,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList();
                            },
                            onSelected: (String choice) {
                              // navigate to the selected page
                            },
                            icon: Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
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
        return AlertDialog(
          title: const Text('Deine Tarotkarte'),
          content: GestureDetector(
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity == 0) return;

              if (details.primaryVelocity?.compareTo(0) == -1) {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Kartenbeschreibung(
                        kartenname: newCard, description: newDesc),
                  ),
                );
              }
            },
            child: Image.asset('images/$newCard'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
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