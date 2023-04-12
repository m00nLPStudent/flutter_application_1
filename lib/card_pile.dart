import 'package:flutter/material.dart';
import 'card_stack.dart';
import 'card_menu.dart';

class CardPileWidget extends StatelessWidget {
  const CardPileWidget({Key? key}) : super(key: key);

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
          _actionLanguage(context),
        ],
      ),
      body: Column(
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

  Widget _actionLanguage(BuildContext context) {
    return LanguageDropDown();
  }
}

class LanguageDropDown extends StatefulWidget {
  const LanguageDropDown({Key? key}) : super(key: key);

  @override
  _LanguageDropDownState createState() => _LanguageDropDownState();
}

class _LanguageDropDownState extends State<LanguageDropDown> {
  List<DropdownMenuItem<Map<String, String>>>? _dropdownMenuItems;
  Map<String, String>? _selectedItem;

  @override
  void initState() {
    _dropdownMenuItems = buildDropDownMenuItems();
    _selectedItem = _dropdownMenuItems![0].value;
    super.initState();
  }

  List<DropdownMenuItem<Map<String, String>>> buildDropDownMenuItems() {
    List<DropdownMenuItem<Map<String, String>>> items = [];
    items.add(
      DropdownMenuItem(
        child: Row(
          children: [
            Image.asset('images/ger.png', width: 60, height: 60,),
            const SizedBox(width: 10),
            const Text('Deutsch', style: TextStyle(color: Colors.white)),
          ],
        ),
        value: {'text': 'Deutsch', 'image': 'images/ger.png'},
      ),
    );
    items.add(
      DropdownMenuItem(
        child: Row(
          children: [
            Image.asset('images/eng.png', width: 60, height: 60,),
            const SizedBox(width: 10),
            const Text('Englisch', style: TextStyle(color: Colors.white)),
          ],
        ),
        value: {'text': 'Englisch', 'image': 'images/eng.png'},
      ),
    );
    items.add(
      DropdownMenuItem(
        child: Row(
          children: [
            Image.asset('images/china.png', width: 60, height: 60,),
            const SizedBox(width: 10),
            const Text('Chinesisch', style: TextStyle(color: Colors.white)),
          ],
        ),
        value: {'text': 'Chinesisch', 'image': 'images/china.png'},
      ),
    );
    items.add(
      DropdownMenuItem(
        child: Row(
          children: [
            Image.asset('images/ru.png', width: 60, height: 60,),
            const SizedBox(width: 10),
            const Text('Russisch', style: TextStyle(color: Colors.white)),
          ],
        ),
        value: {'text': 'Russisch', 'image': 'images/ru.png'},
      ),
    );
    items.add(
      DropdownMenuItem(
        child: Row(
          children: [
            Image.asset('images/tr.png', width: 60, height: 60,),
            const SizedBox(width: 10),
            const Text('Türkisch', style: TextStyle(color: Colors.white)),
          ],
        ),
        value: {'text': 'Türkisch', 'image': 'images/tr.png'},
      ),
    );
    items.add(
      DropdownMenuItem(
        child: Row(
          children: [
            Image.asset('images/ar.png', width: 60, height: 60,),
            const SizedBox(width: 10),
            const Text('Arabisch', style: TextStyle(color: Colors.white)),
          ],
        ),
        value: {'text': 'Arabisch', 'image': 'images/ar.png'},
      ),
    );
    items.add(
      DropdownMenuItem(
        child: Row(
          children: [
            Image.asset('images/fr.png', width: 60, height: 60,),
            const SizedBox(width: 10),
            const Text('Französisch', style: TextStyle(color: Colors.white)),
          ],
        ),
        value: {'text': 'Französisch', 'image': 'images/fr.png'},
      ),
    );
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(_selectedItem!['image']!, width: 60, height: 60,),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: Container(
                width: double.maxFinite,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Map<String, String>>(
                    dropdownColor: Colors.transparent,
                    iconEnabledColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    value: _selectedItem,
                    items: _dropdownMenuItems,
                    onChanged: (Map<String, String>? newValue) {
                      setState(() {
                        _selectedItem = newValue;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}



