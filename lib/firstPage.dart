import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_test/constants.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_api_test/movie_response.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<Results> finalresults = [];
  int page = 1;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  String url =
      "https://api.themoviedb.org/3/movie/popular?api_key=f45b7e038139d8e9bb9f8878d46b6030&page=";
  Future<MovieResponse> getMovie() async {
    return await http.get(url + page.toString()).then((res) {
      MovieResponse mr = MovieResponse.fromJson(json.decode(res.body));
      // page = page + 1;
      return mr;
    });
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length + 1).toString());
    page = (page + 1);
    if (mounted) setState(() {});
    _refreshController.loadComplete();
    print(page);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: getMovie(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              MovieResponse mr = snapshot.data;
              if (mr.results != null) {
                finalresults.addAll(mr.results);
              }

              return SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                header: WaterDropHeader(),
                footer: CustomFooter(
                  builder: (BuildContext context, LoadStatus mode) {
                    Widget body;
                    if (mode == LoadStatus.idle) {
                      body = Text("pull up load");
                    } else if (mode == LoadStatus.loading) {
                      body = CupertinoActivityIndicator();
                    } else if (mode == LoadStatus.failed) {
                      body = Text("Load Failed!Click retry!");
                    } else if (mode == LoadStatus.canLoading) {
                      body = Text("release to load more");
                    } else {
                      body = Text("No more Data");
                    }
                    return Container(
                      height: 55.0,
                      child: Center(child: body),
                    );
                  },
                ),
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: ListView(
                  children: finalresults.map((m) {
                    return Column(
                      children: <Widget>[
                        Card(
                          color: Colors.lightGreenAccent[100],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              ClipOval(
                                child: CachedNetworkImage(
                                  width: 200,
                                  height: 250,
                                  imageUrl: IMG_LINK + m.posterPath,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  Wrap(children: [
                                    Text(
                                      m.title,
                                      maxLines: 2,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15.0),
                                    ),
                                  ]),
                                  Row(
                                    children: <Widget>[
                                      StarRating(
                                        starCount: 5,
                                        rating: double.parse(m.voteAverage) / 2,
                                        color: Colors.grey[700],
                                        borderColor: Colors.grey[700],
                                        size: 20.0,
                                      ),
                                      Text(
                                        '(' + m.voteAverage + ')',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.grey[700]),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    m.releaseDate,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  FlatButton.icon(
                                    color: Colors.blue[300],
                                    icon: Icon(Icons.error),
                                    onPressed: () {
                                      print('FLatButton');
                                    },
                                    label: Text(
                                      'Details',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 2.0,
                                color: Colors.red[600],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
