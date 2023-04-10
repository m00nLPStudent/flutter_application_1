import 'package:flutter/material.dart';
import 'dart:math';
import 'card_description.dart';
import 'card_translation.dart';

class CardPile extends StatefulWidget {
  @override
  _CardPileState createState() => _CardPileState();
}

class _CardPileState extends State<CardPile> {
  final karten = [
    'der_agile_professor.png',
    'der_aktive.png',
    'der_alles_an_sich_ziehende.png',
    'der_auf_und_abbau.png',
    'die_bewusste_wandlung.png',
    'das_chaotische_glueck.png',
    'der_denker.png',
    'der_dirigent_des_lebens.png',
    'die_dummheit.png',
    'der_durchstarter.png',
    'der_energetische_fluss.png',
    'der_entmachtete.png',
    'der_emotionale_sicherheitgeber.png',
    'der_eroberer.png',
    'der_flexible.png',
    'der_gefuehlsdisziplinierte.png',
    'der_gefuehlsdirektor.png',
    'der_gefuehlsmensch.png',
    'der_gefuehlvolle_sprinter.png',
    'der_gefuehlvolle_stuermer.png',
    'der_gesicherte_erfolg.png',
    'der_geteuerte_weitblick.png',
    'die_glueckseligkeit.png',
    'das_glueckskind.png',
    'der_glueckspilz.png',
    'der_großunternehmer.png',
    'der_haeuslebauer.png',
    'die_herzensbrecherin.png',
    'die_inspiration.png',
    'der_instabile.png',
    'die_irrefuehrung.png',
    'der_kampf_zwischen_gefuehl_und_trophaee.png',
    'das_kopf-gefuehlschaos.png',
    'das_kreative_genie.png',
    'der_kreative_kuenstler.png',
    'der_kuenstler_im_absoluten.png',
    'die_logische_beziehung.png',
    'der_logische_energieeinsatz.png',
    'der_logische_kalkulator.png',
    'das_materialliserte_glueck.png',
    'der_partnerwechsel.png',
    'der_powerstart.png',
    'der_powerstart.png',
    'die_sichtbare_stabilitaet.png',
    'der_spirituelle_alchemist.png',
    'der_stabile_greis.png',
    'der_stabile.png',
    'der_stolze_king_of_life.png',
    'der_stolze_repraesentant.png',
    'der_traeumer.png',
    'die_traeumerische_sichtweise.png',
    'der_unbewegliche.png',
    'der_unflexible.png',
    'der_ungeliebte.png',
    'der_unglueckliche.png',
    'der_unsichere.png',
    'der_verblendete.png',
    'die_versuchung.png',
    'der_verwandlungskuenstler.png',
    'der_visuelle_chaot.png',
    'der_wandler.png',
    'der_wissenschftliche_gluecksbringer.png',
    'der_zielbewusste_neureiche.png'
  ];
  String selectedCard = '';

  List<String> menuItems = [
    'Element 1',
    'Element 2',
    'Element 3',
  ];

  String selectedItem = 'Element 1';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Opalia - Numerologiekarten'),
        leading: PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return menuItems.map((String item) {
              return PopupMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList();
          },
          onSelected: (String newValue) {
            setState(() {
              selectedItem = newValue;
            });
          },
          offset: const Offset(-100, 0),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
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
