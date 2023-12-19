import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import '../models/place.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  return await sql.openDatabase(path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
    return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY, name TEXT, image TEXT)');
  }, version: 1);
}

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier() : super([]);

  void addNewPlace(Place place) async {
    var appDir = await syspath.getApplicationDocumentsDirectory();
    var filename = path.basename(place.selectedImage.path);
    var copiedImage =
        await place.selectedImage.copy('${appDir.path}/$filename');
    var placeToSave = Place(name: place.name, selectedImage: copiedImage);
    state = [...state, placeToSave];

    final db = await _getDatabase();
    db.insert('user_places', {
      "id": placeToSave.id,
      "name": placeToSave.name,
      "image": placeToSave.selectedImage.path
    });
  }

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query("user_places");
    final places = data.map((row) => Place(
        name: row['name'] as String,
        selectedImage: File(row['image'] as String),
        id: row['id'] as String)).toList();
    state = places;
  }
}

final placesNotifierProvider =
    StateNotifierProvider<PlacesNotifier, List<Place>>(
        (ref) => PlacesNotifier());
