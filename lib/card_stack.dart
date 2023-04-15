import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'card_description.dart';
import 'card_translation.dart';
import 'card_list.dart';
import 'card_item.dart';

class CardStackWidget extends StatefulWidget {
  const CardStackWidget({Key? key}) : super(key: key);

  @override
  _CardStackState createState() => _CardStackState();
}

class _CardStackState extends State<CardStackWidget> {
  List<CardItem> karten = cardList;
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
    CardController controller;

    return Expanded(
      child: Stack(
        children: [
        Image.asset(
        'images/background.jpg',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: TinderSwapCard(
            swipeUp: true,
            swipeDown: true,
            orientation: AmassOrientation.BOTTOM,
            totalNum: karten.length,
            stackNum: 3,
            swipeEdge: 4.0,
            maxWidth: MediaQuery.of(context).size.width * 0.6,
            maxHeight: MediaQuery.of(context).size.height * 0.6,
            minWidth: MediaQuery.of(context).size.width * 0.5,
            minHeight: MediaQuery.of(context).size.height * 0.5,
              cardBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    final String description = translation.translate(karten[index]);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Kartenbeschreibung(
                          kartenname: karten[index],
                          description: description,
                        ),
                      ),
                    );
                  },

                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Stack(
                      children: [
                        Card(
                          elevation: 0,
                          margin: const EdgeInsets.all(0),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(28.0)),
                          ),
                          child: Image.asset(
                            'images/back.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              cardController: controller = CardController(),
            swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {},
            swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {},
          ),
        ),
      ]
      ),
    );
  }
}
