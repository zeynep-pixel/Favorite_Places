import 'dart:convert';

import 'package:favorite_places/models/places.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  final void Function( PlaceLocation location) onSelectLocation;

  const LocationInput({super.key, required this.onSelectLocation});
  @override
  State<StatefulWidget> createState() {
    
    return _LocationInputsState();
  }
}

class _LocationInputsState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  var _isGettingLocation = false;
  
  String get locationImage{
    if(_pickedLocation == null){
      return '';
    }
    final lat = _pickedLocation!.latitude;
    final lng = _pickedLocation!.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyC0qgLgwLMlDX15E_NmQGyQH1n0D2mpmVw';
  }

  void getLocation() async {
    
    
    Location location = new Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
     
       _isGettingLocation = true;
    });


    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final lng = locationData.longitude;

    if(lat == null|| lng == null){
      return;
    }



    final url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyC0qgLgwLMlDX15E_NmQGyQH1n0D2mpmVw');
    final response = await http.get(url);
    final resData = json.decode(response.body);
    final address = resData['results'][0]['formatted_address'];


     setState(() {
       _pickedLocation = PlaceLocation(latitude: lat, longitude: lng, address: address);
       _isGettingLocation = false;
    });
    widget.onSelectLocation(_pickedLocation!);
    
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent =  Text(
           style: Theme.of(context).textTheme.titleSmall!,
            'Lokasyon seçili değil',
            textAlign: TextAlign.center,
             
          );

    if(_pickedLocation != null){
      previewContent = Image.network(locationImage, fit: BoxFit.cover, width: double.infinity, height: double.infinity,);
    }
    
    if(_isGettingLocation == true){
      previewContent = const CircularProgressIndicator();
    }
    
  


    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1, color: Theme.of(context).colorScheme.primary)),
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
                icon: const Icon(Icons.location_on),
                onPressed: getLocation,
                label: const Text('Get Current Location')),
            TextButton.icon(
                icon: const Icon(Icons.map),
                onPressed: () {},
                label: const Text('Selected on Map'))
          ],
        )
      ],
    );
  }
}
