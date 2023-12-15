import 'package:uuid/uuid.dart';

class Place {
  Place({required this.name}) : id = const Uuid().v4();

  final String id;
  final String name;
}
