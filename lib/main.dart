
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'City Map',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GoogleMaps(),
    );
  }
}

class GoogleMaps extends StatefulWidget {
  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  int index = 0;
  GoogleMapController mapController;
  String currentCity = 'Bangalore';
  List cities = [
    ['Bengaluru', LatLng(12.9716, 77.5946)],
    ['Delhi', LatLng(28.7041, 77.1025)],
    ['Mumbai', LatLng(19.0760, 72.8777)],
    ['Chennai', LatLng(13.0827, 80.2707)],
    ['Kolkata', LatLng(22.5726, 88.3639)],
    ['Jaipur', LatLng(26.9124, 75.7873)]
  ];

  GoogleMapController myController;
  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    myController = controller;
  }



  void _onCameraMove(CameraPosition position) {

  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId(cities[1][1].toString()),
          position: cities[1][1],
          infoWindow: InfoWindow(title: 'Location'),
          icon: BitmapDescriptor.defaultMarker));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF398D3C),
        centerTitle: true,
        title: Text('City Map App'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: GoogleMap(
              onCameraMove: _onCameraMove,
              markers: _markers,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: cities[0][1],
                zoom: 8.0,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: FlatButton(
                        child: Text(cities[index][0], style: TextStyle(fontSize: 24),),
                        onPressed: () {
                          index++;
                          myController.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: cities[index][1],
                                zoom: 14.0,
                              ),
                            ),
                          );
                          currentCityLocation(1);
                        },
                      ),
                  ),
            ),
          )
        ],
      ),
    );

  }

  void currentCityLocation(int index) {
    if (index == cities.length) {
      index = 0;
    }
    if (index != 0) {
      _onAddMarkerButtonPressed();
    }
    index++;
  }


}
