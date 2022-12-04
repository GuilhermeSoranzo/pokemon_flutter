import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pokemon_flutter_app/models/pokemon.dart';
import 'package:pokemon_flutter_app/repository/pokemon_repository.dart';
import '../consts/api.dart';

class PokemonInfo extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonInfo({Key? key, required this.pokemon}) : super(key: key);

  TextStyle titulo() {
    return const TextStyle(
        fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold);
  }

  TextStyle subTitulo() {
    return const TextStyle(
        fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(pokemon.name)),
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: [
              Image.network(pokemon.image),
              Text(
                "${pokemon.id} - ${pokemon.name}",
                style: titulo(),
              ),
              Text(
                "Altura: ${pokemon.height} \n Peso: ${pokemon.weight}",
                style: subTitulo(),
              ),
              Column(
                children: getEvolucao(pokemon),
              )
            ],
          ),
        ));
  }

  Widget resizePokemon(Widget widget) {
    return SizedBox(height: 80, width: 80, child: widget);
  }

  List<Widget> getEvolucao(Pokemon pokemon) {
    List<Widget> _list = [];
    if (pokemon.nextEvolution != null) {
      _list.add(Icon(Icons.keyboard_arrow_down));
      pokemon.nextEvolution?.forEach((f) {
        var split1 = f.split("num: ");
        var split2 = split1[1].split(",");
        var splitName1 = f.split("name: ");
        var splitName2 = splitName1[1].split("}");
        var url = Api.pokemonPic + split2[0] + ".png";
        _list.add(resizePokemon(getImage(url)));
        _list.add(
          Container(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text(
              splitName2[0],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );

        if (splitName2[0] != pokemon.name) {
          _list.add(Icon(Icons.keyboard_arrow_down));
        }
      });
    }

    return _list;
  }

  Widget getImage(String num) {
    return CachedNetworkImage(
      placeholder: (context, url) => new Container(
        color: Colors.transparent,
      ),
      imageUrl: num,
    );
  }
}
