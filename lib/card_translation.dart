import 'dart:convert';
import 'dart:async';
import 'dart:io';

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
    return entries[key] ?? "<missing translation>";
  }

  factory Translation.fromJson(List<dynamic> data) {
    final entries = data as List<Entry>;
    final Map<String, String> map = {};
    for (var e in entries) {
      map[e.name] = e.description;
    }
    return Translation(entries: map);
  }

  factory Translation.parseString(String src) {
    List<dynamic> data = jsonDecode(src);
    return Translation.fromJson(data);
  }
}

class FileStorage {
  FileStorage({required this.locale});

  final String locale;

  Future<File> get _localFile async {
    return File('lang/$locale.json');
  }

  Future<String> readFileAsString() async {
    String contents = "";
    final file = await _localFile;
    if (file.existsSync()) {
      //Must check or error is thrown
      contents = await file.readAsString();
    }
    return contents;
  }

  Future<Translation> parseFile() async {
    final String src = await readFileAsString();
    return Translation.parseString(src);
  }
}
