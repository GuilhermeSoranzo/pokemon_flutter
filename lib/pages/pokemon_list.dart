import 'package:flutter/material.dart';
import 'package:pokemon_flutter_app/pages/pokemon_info.dart';

import '../models/pokemon.dart';

class PokemonList extends StatefulWidget {
  List<Pokemon> list;

  PokemonList({Key? key, required this.list}) : super(key: key);

  @override
  State<PokemonList> createState() {
    return PokemonListState();
  }
}

/// Widget de estado - onde vai ser implementado o layout
class PokemonListState extends State<PokemonList> {
  late List<Pokemon> pokemonLista = widget.list;
  TextEditingController myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextFormField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Nome do Pokemon",
                icon: Icon(Icons.search)),
            controller: myController,
            onChanged: searchPokemon,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: pokemonLista.length,
              itemBuilder: (context, index) {
                var pokemonsConsulta = pokemonLista[index];
                return ListTile(
                  leading: Image.network(pokemonsConsulta.image),
                  title: Text("${pokemonsConsulta.name} "),
                  subtitle: Text(pokemonsConsulta.getTypeString()),
                  textColor: pokemonsConsulta.baseColor,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PokemonInfo(pokemon: pokemonsConsulta),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void searchPokemon(String query) {
    final poke = widget.list.where((element) {
      final pokeLower = element.name.toLowerCase();
      final input = query.toLowerCase();

      return pokeLower.contains(input);
    }).toList();

    setState(() => pokemonLista = poke);
  }
}
