
import 'package:favorite_places/provider/user_place.dart';
import 'package:favorite_places/screens/new_item.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';



class FavoritePlaces extends ConsumerWidget {
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPlaces = ref.watch(UserPlaceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Favorite Places')),
        actions: [IconButton(onPressed: (){ Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>  NewItem()));}, icon: const Icon(Icons.add))],
      ),
      body: Padding(padding: const EdgeInsets.all(8),child: PlacesList(places: userPlaces))
    );
  }
}
