import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;


class Entry {
  Entry({required this.name, required this.description});

  final String name;
  final String description;

  factory Entry.fromJson(Map<String, String> data) {
    final name = data['name'] as String;
    final desc = data['description'] as String;
    return Entry(name: name, description: desc);
  }

  Map<String, String> toJson() {
    return {
      'name': name,
      'description': description,
    };
  }
}

class Translation {
  Translation({required this.entries});

  final Map<String, String> entries;

  String translate(String key) {
    return entries[key] ?? "<missing translation for '$key'>";
  }

  factory Translation.fromJson(List data) {
    final Map<String, String> map = {};
    if (data != null) {
      for (var element in data) {
        String name = element['name'];
        String desc = element['description'];
        if (name != null) {
          //print(name +"  "+ desc);
          map["$name.png"] = desc ?? "";
        }
      }
    }
    return Translation(entries: map);
  }

  factory Translation.parseString(String src) {
    try {
      List data = jsonDecode(src);
      return Translation.fromJson(data);
    }
    catch (e) {
      //print(e.toString());
      return Translation(entries: {});
    }
  }
}

class FileStorage {
  FileStorage({required this.locale});

  final String locale;

  Future<String> readFileAsString() async {
    String contents = "[]";

    await rootBundle.loadString('lang/$locale.json').then((s) => { contents = s });

    return contents;
  }

  Future<Translation> parseFile() async {
    final String src = await readFileAsString();
    return Translation.parseString(src);
  }
}
