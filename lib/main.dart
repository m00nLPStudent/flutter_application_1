import 'dart:async';
import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'card_pile.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreenWidget(),
  ));
  Future.delayed(const Duration(seconds: 6), () {
    runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CardPileWidget(),
    ));
  });
}
