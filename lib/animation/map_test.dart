import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission/permission.dart';
import 'package:geolocator/geolocator.dart';

class MapTest extends StatefulWidget {
  @override
  _MapTestState createState() => _MapTestState();
}

class _MapTestState extends State<MapTest> {
  List<Marker> allMarker = [];
  GoogleMapController _controller;

  String searchAddr;

  @override
  void initState() {
    super.initState();
    allMarker.add(Marker(
        markerId: MarkerId('myMarker1'),
        draggable: false,
        onTap: () {
          print("Marker Tapped");
        },
        position: LatLng(16.8409, 96.1735)));
    allMarker.add(Marker(
        markerId: MarkerId('myMarker2'),
        draggable: false,
        onTap: () {
          print("Marker Tapped");
        },
        position: LatLng(39.9042, 116.4074)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              onTap: (a) {
                print(a.latitude);
                print(a.longitude);
              },
              initialCameraPosition:
                  CameraPosition(target: LatLng(16.8409, 96.1735), zoom: 12.0),
              markers: Set.from(allMarker),
              onMapCreated: mapCreated,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: InkWell(
              onTap: moveToYangon,
              child: Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.green),
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: moveToBeijing,
              child: Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.green),
                child: Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ),
          ),
          Positioned(
            top: 30.0,
            right: 15.0,
            left: 15.0,
            child: Container(
              height: 50.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Enter Address',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: searchAndNavigate,
                      iconSize: 30.0,
                    )),
                onChanged: (val) {
                  setState(() {
                    searchAddr = val;
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  searchAndNavigate() {
    Geolocator().placemarkFromAddress(searchAddr).then((result) {
      _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target:
              LatLng(result[0].position.latitude, result[0].position.longitude),
          zoom: 10.0)));
    });
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  moveToBeijing() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(39.9042, 116.4074),
          zoom: 12.0,
          bearing: 45.0,
          tilt: 45.0),
    ));
  }

  moveToYangon() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(16.8409, 96.1735),
        zoom: 12.0,
      ),
    ));
  }
}
