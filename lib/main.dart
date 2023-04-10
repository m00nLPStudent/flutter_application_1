import 'dart:async';
import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'card_pile.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
  Future.delayed(const Duration(seconds: 6), () {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CardPile(),
    ));
  });
}
