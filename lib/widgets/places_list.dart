import 'package:favorite_places/models/places.dart';
import 'package:favorite_places/screens/details.dart';
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
        return Padding(
          padding: const EdgeInsets.only( bottom: 10.0),
          child: ListTile(
            leading: CircleAvatar(radius: 26,backgroundImage: FileImage(places[index].image),),
            title: Text(places[index].name, style: Theme.of(context).textTheme.titleMedium!,),
            subtitle: Text(places[index].location.address, style: Theme.of(context).textTheme.titleSmall!,),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> Details(place: places[index],)));
            },
          ),
        );
      }
    );
  }
}
