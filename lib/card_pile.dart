import 'package:flutter/material.dart';
import 'card_stack.dart';
import 'card_menu.dart';

class CardPileWidget extends StatelessWidget {
  const CardPileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: null,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: _actionHome(),
        actions: [
          _actionHistory(),
          _actionLanguage(),
        ],
      ),
      body: const Column(
        children: [
          CardStackWidget(),
          CardMenuWidget(),
        ],
      ),
    );
  }

  IconButton _actionHome() {
    return IconButton(
      icon: const Icon(
        Icons.home,
        size: 40,
      ),
      onPressed: () {
        // Behandeln Sie den Klick auf den Navigationsknopf
      },
    );
  }

  IconButton _actionHistory() {
    return IconButton(
      icon: const Icon(Icons.history, size: 40),
      onPressed: () {
        // Behandeln Sie den Klick auf die Suchschaltfläche
      },
    );
  }

  IconButton _actionLanguage() {
    return IconButton(
      icon: const Icon(Icons.language, size: 40),
      onPressed: () {
        // Behandeln Sie den Klick auf das Menü-Symbol
      },
    );
  }
}
