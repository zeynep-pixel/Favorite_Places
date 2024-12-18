import 'package:favorite_places/models/places.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  const Details({super.key, required this.place});
  final Places place;
  
  String get locationImage{
   
    final lat = place.location.latitude;
    final lng = place.location.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyC0qgLgwLMlDX15E_NmQGyQH1n0D2mpmVw';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                   CircleAvatar(radius: 70, backgroundImage: NetworkImage(locationImage),),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.transparent, Colors.black45],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter
                            ),
                            ),
                    child: Text(place.location.address,  style: Theme.of(context).textTheme.titleMedium!),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
