import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_api_test/movie_response.dart';
import 'package:flutter_api_test/constants.dart';
import 'package:flutter_rating/flutter_rating.dart';

class MovieListPage extends StatefulWidget {
  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  String url =
      "https://api.themoviedb.org/3/movie/popular?api_key=f45b7e038139d8e9bb9f8878d46b6030&page=2";

  Future<MovieResponse> getMovie() async {
    return await http.get(url).then((res) {
      MovieResponse mr = MovieResponse.fromJson(json.decode(res.body));
      return mr;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              MovieResponse mr = snapshot.data;
              return Container(
                color: Colors.red,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Ranking",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 40.0)),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.black12,
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.white54,
                                  ),
                                ),
                                hintText: "Search",
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: ListView(
                        children: mr.results.map((m) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(top: 0.0, bottom: 0.0),
                            child: Stack(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 138.0),
                                  child: Card(
                                    color: Colors.black54,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Container(
                                          height: 150.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 100.0, bottom: 80.0),
                                          child: Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(m.title,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize: 16.0)),
                                                Row(
                                                  children: <Widget>[
                                                    StarRating(
                                                      size: 20.0,
                                                      rating: 10 /
                                                          2, // m.voteAverage/2,
                                                      color: Colors.orange,
                                                      borderColor: Colors.grey,
                                                      starCount: 5,
                                                    ),
                                                    Text(
                                                        m.voteAverage
                                                            .toString(),
                                                        style: TextStyle(
                                                            color:
                                                                Colors.orange)),
                                                  ],
                                                ),
                                                Text(m.releaseDate,
                                                    style: TextStyle(
                                                        color: Colors.white54)),
                                                Container(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment(-0.8, 0),
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      width: 150.0,
                                      height: 300.0,
                                      imageUrl: IMG_LINK + m.posterPath,
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
          future: getMovie(),
        ),
      ),
    );
  }
}
