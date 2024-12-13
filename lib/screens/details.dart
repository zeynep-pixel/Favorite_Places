import 'package:favorite_places/models/places.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget{
  const Details({super.key, required this.place});
  final Places place;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(place.name),),
      body:Stack(children: [
        Image.file(
         place.image,
         fit: BoxFit.cover,
         width: double.infinity,
         height: double.infinity,
        )
      ],),
    );
  }
  
}