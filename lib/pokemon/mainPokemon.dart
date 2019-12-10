import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_test/pokemon/pokeDetail.dart';
import 'package:flutter_api_test/pokemon/pokemon.dart';
import 'package:http/http.dart' as http;

class MainPokemon extends StatefulWidget {
  @override
  _MainPokemonState createState() => _MainPokemonState();
}

class _MainPokemonState extends State<MainPokemon> {
  String url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  PokeHub pokeHub;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(url);
    var decodeJson = jsonDecode(res.body);
    pokeHub = PokeHub.fromJson(decodeJson);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: pokeHub == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 2,
              children: pokeHub.pokemon
                  .map((poke) => Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PokeDetail(
                                          pokemon: poke,
                                        )));
                          },
                          child: Card(
                            child: Column(
                              children: <Widget>[
                                CachedNetworkImage(
                                  width: 100,
                                  height: 100,
                                  imageUrl: poke.img,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(poke.name,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
    );
  }
}
