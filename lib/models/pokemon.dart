import 'package:flutter/material.dart';

class Pokemon {
  final int id;
  final String name;
  final String num;
  final String image;
  final List<String> type;
  final String height;
  final String weight;
  List<String>? nextEvolution;
  List<String>? prevEvolution;

  Pokemon(
      {required this.id,
      required this.name,
      required this.num,
      required this.image,
      required this.type,
      required this.height,
      required this.weight,
      this.nextEvolution,
      this.prevEvolution});

  factory Pokemon.fromMap(Map<String, dynamic> json) {
    var poke = Pokemon(
        id: json['id'],
        name: json['name'],
        num: json['num'],
        image: json['img'],
        type: (json['type'] as List<dynamic>).map((e) => e as String).toList(),
        height: json['height'],
        weight: json['weight']);

    if (json.containsKey('next_evolution')) {
      poke.nextEvolution = (json['next_evolution'] as List<dynamic>)
          .map((e) => e.toString() as String)
          .toList();
    }

    if (json.containsKey('prev_evolution')) {
      poke.prevEvolution = (json['prev_evolution'] as List<dynamic>)
          .map((e) => e.toString() as String)
          .toList();
    }

    return poke;
  }

  String getTypeString() {
    String retorno = "";
    for (var t in type) {
      retorno += "$t ";
    }
    return retorno;
  }

  Color? get baseColor => _color(type: type[0]);

  static Color? _color({required String type}) {
    switch (type) {
      case 'Normal':
        return Colors.brown[400];
      case 'Fire':
        return Colors.red;
      case 'Water':
        return Colors.blue;
      case 'Grass':
        return Colors.green;
      case 'Electric':
        return Colors.amber;
      case 'Ice':
        return Colors.cyanAccent[400];
      case 'Fighting':
        return Colors.orange;
      case 'Poison':
        return Colors.purple;
      case 'Ground':
        return Colors.orange[300];
      case 'Flying':
        return Colors.indigo[200];
      case 'Psychic':
        return Colors.pink;
      case 'Bug':
        return Colors.lightGreen[500];
      case 'Rock':
        return Colors.grey;
      case 'Ghost':
        return Colors.indigo[400];
      case 'Dark':
        return Colors.brown;
      case 'Dragon':
        return Colors.indigo[800];
      case 'Steel':
        return Colors.blueGrey;
      case 'Fairy':
        return Colors.pinkAccent[100];
      default:
        return Colors.grey;
    }
  }
}

class NextEvolution {
  String num = '';
  String name = '';

  NextEvolution.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['num'] = this.num;
    data['name'] = this.name;
    return data;
  }
}

class PrevEvolution {
  String num = '';
  String name = '';

  PrevEvolution.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['num'] = this.num;
    data['name'] = this.name;
    return data;
  }
}
