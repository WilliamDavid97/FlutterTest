import 'package:flutter/material.dart';
import 'package:flutter_api_test/pokemon/pokemon.dart';

class PokeDetail extends StatelessWidget {
  final Pokemon pokemon;

  PokeDetail({this.pokemon});

  bodyWidget(BuildContext context) => Stack(
        children: <Widget>[
          Container(
            child: Positioned(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width - 20,
              left: 10,
              top: MediaQuery.of(context).size.height * 0.15,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      height: 90,
                    ),
                    Text(
                      pokemon.name,
                      style: TextStyle(fontSize: 20),
                    ),
                    Text("Height = ${pokemon.height}"),
                    Text("Width = ${pokemon.weight}"),
                    Text(
                      "Type",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: pokemon.type
                          .map((t) => FilterChip(
                                backgroundColor: Colors.amberAccent,
                                label: Text(t),
                                onSelected: (b) {},
                              ))
                          .toList(),
                    ),
                    Text(
                      "Weekness",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: pokemon.weaknesses
                          .map((t) => FilterChip(
                                backgroundColor: Colors.redAccent[100],
                                label: Text(t),
                                onSelected: (b) {},
                              ))
                          .toList(),
                    ),
                    Text(
                      "Next Evolution",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: pokemon.nextEvolution == null
                          ? <Widget>[Text('Data not exist')]
                          : pokemon.nextEvolution
                              .map((n) => FilterChip(
                                    backgroundColor: Colors.greenAccent,
                                    label: Text(n.name),
                                    onSelected: (b) {},
                                  ))
                              .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: pokemon.img,
              child: Container(
                height: 200.0,
                width: 200.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(pokemon.img))),
              ),
            ),
          )
        ],
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent[100],
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          pokemon.name,
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: bodyWidget(context),
    );
  }
}
