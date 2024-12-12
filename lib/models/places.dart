
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Places  {
  final String id;
  final String name;
  

  Places({ required this.name}): id = uuid.v4()  ;
  
}
