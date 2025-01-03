
import 'dart:io';

import 'package:favorite_places/models/places.dart';
import 'package:favorite_places/provider/user_place.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class NewItem extends ConsumerStatefulWidget {
  @override
  ConsumerState<NewItem> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends ConsumerState<NewItem> {
  final _titlecontroller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File? selectedImage ;
  PlaceLocation? _selectedLocaton;
 
  void saveItem(){
    final enteredName = _titlecontroller.text;
    if (enteredName.isEmpty || selectedImage == null || _selectedLocaton == null ) { 
      return;
    }
      
    ref.read(UserPlaceProvider.notifier).addPlace(enteredName, selectedImage!, _selectedLocaton!);
    Navigator.of(context).pop();
   
  
  }



  @override
  void dispose() {
    _titlecontroller.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Yeni öğe ekleyin.')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          child: Column(
            children: [TextFormField(
              maxLength: 50,
              decoration: const InputDecoration(label: Text('İsim'))
              ,
              controller: _titlecontroller,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
            ),
            ImageInput(onPickedImage: (image){ selectedImage = image;},),
            const SizedBox(height: 10,),
            LocationInput(onSelectLocation: (location){
              _selectedLocaton =location;

            },),

            const SizedBox(height: 16,),
            ElevatedButton(onPressed: saveItem, child: const Text('Kaydet'))]
          ),
        ),
      ),
    );
  }
}
