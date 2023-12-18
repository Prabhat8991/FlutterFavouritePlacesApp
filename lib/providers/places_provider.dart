import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/place.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier() : super([]);

  void addNewPlace(Place place) async {
    var appDir = await syspath.getApplicationDocumentsDirectory();
    var filename = path.basename(place.selectedImage.path);
    var copiedImage = await place.selectedImage.copy('${appDir.path}/$filename');
    var placeToSave = Place(name: place.name, selectedImage: copiedImage);
    state = [...state, placeToSave];
  }
}

final placesNotifierProvider =
    StateNotifierProvider<PlacesNotifier, List<Place>>(
        (ref) => PlacesNotifier());
