import 'dart:io';

import 'package:uuid/uuid.dart';

class Place {
  Place({required this.name, required this.selectedImage, String? id})
      : id = id ?? const Uuid().v4();

  final String id;
  final String name;
  final File selectedImage;
}
