import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
  Future.delayed(const Duration(seconds: 10), () {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CardPile(),
    ));
  });
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('videos/splash.mp4');
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        print("Connection state: ${snapshot.connectionState}");
        if (snapshot.connectionState == ConnectionState.done) {
          _controller.play();
          return Container(
            color: Colors.white,
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: SizedBox(
                  width: _controller.value.size.width ?? 0,
                  height: _controller.value.size.height ?? 0,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
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
    '21.png',
    '22.png',
    '23.png',
    '24.png',
    '25.png',
    '26.png',
    '27.png',
    '28.png',
    '29.png',
    '30.png',
    '31.png',
    '33.png',
    '34.png',
    '35.png',
    '36.png',
    '37.png',
    '38.png',
    '39.png',
    '40.png',
    '41.png',
    '42.png',
    '43.png',
    '44.png',
    '45.png',
    '46.png',
    '47.png',
    '48.png',
    '49.png',
    '50.png',
    '51.png',
    '52.png',
    '53.png',
    '54.png',
    '55.png',
    '56.png',
    '57.png',
    '58.png',
    '59.png',
    '60.png',
    '61.png',
    '62.png',
    '63.png',
    '64.png',
    '65.png'

  ];
  String selectedCard = '';

  List<String> menuItems = [
    'Element 1',
    'Element 2',
    'Element 3',
  ];

  String selectedItem = 'Element 1';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kartenlege-App'),
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
          title: const Text('Deine Tarotkarte'),
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
