import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget{
  const ImageInput({super.key, required this.onPickedImage});
  final void Function(File image) onPickedImage;



  @override
  State<StatefulWidget> createState() {
    
    return _ImageInputState();
  }}

  class _ImageInputState extends State<ImageInput>{
    File? selectedImage;


    void _takePicture() async {
      final imagePicker = ImagePicker();
      final pickedImage = await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);
      if(pickedImage == null){
        return;
      }
     
     setState(() {
        selectedImage = File(pickedImage.path);
     });
     widget.onPickedImage(selectedImage!);

    }
  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(icon: const Icon(Icons.camera), onPressed: _takePicture, label: const Text('Fotoğraf çek.'));
    
    if(selectedImage != null){
      content = GestureDetector(onTap: _takePicture, child: Image.file(selectedImage!, fit: BoxFit.cover, width: double.infinity, height: double.infinity,));
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Theme.of(context).colorScheme.primary)
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
    
  }