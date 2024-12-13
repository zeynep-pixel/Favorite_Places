
import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Places  {
  final String id;
  final String name;
  final File image;

  

  Places({ required this.name, required this.image}): id = uuid.v4()  ;
  
}
