import 'package:favorite_places/models/places.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
   
  const PlacesList({super.key, required this.places});
  final List<Places> places;

  
    @override
  Widget build(BuildContext context) {
    if(places.isEmpty){
      return  Center(child: Text('Şuanlık bir veri bulunmamakta.', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),), );
    }
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(places[index].name, style: Theme.of(context).textTheme.titleMedium!,),
        );
      }
    );
  }
}
