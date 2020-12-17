import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qrreader/models/scan_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    final CameraPosition posicionInicial = CameraPosition(
      target: scan.getLatLong(),
      zoom: 17.5,
      tilt: 50,
    );

    //Creación de marcadores
    Set<Marker> markers = new Set<Marker>();
    markers.add(Marker(
      markerId: MarkerId('geo-location'),
      position: scan.getLatLong(),
      // icon: BitmapDescriptor.fromAsset('assets/img/bluemarkerjpg.jpg'),
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
        actions: [
          IconButton(
            icon: Icon(Icons.location_disabled),
            onPressed: () async{
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: scan.getLatLong(),
                    zoom: 17.5,
                    tilt: 50,
                  )
                )
              ); 
            },
          ),
        ],
      ),
      body: GoogleMap(
        mapType: mapType,
        markers: markers,
        initialCameraPosition: posicionInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.layers),
        onPressed: (){
          setState(() {
            if(mapType == MapType.normal){
              mapType = MapType.satellite;
            }else{
              mapType = MapType.normal;
            }  
          });
        }
      ),
    );
  }
}