import 'dart:io';

import 'package:favorite_places/models/places.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class UserPlaceNotifier extends StateNotifier<List<Places>>{
  UserPlaceNotifier() : super(const []);

  void addPlace(String title, File image){
    final newPlace = Places(name: title, image: image);
    state = [newPlace, ...state];
  }
  
}

final UserPlaceProvider = StateNotifierProvider<UserPlaceNotifier, List<Places>>((ref)=>UserPlaceNotifier());