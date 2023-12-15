import 'package:favourite_places/providers/places_provider.dart';
import 'package:favourite_places/screens/add_new_place_screen.dart';
import 'package:favourite_places/screens/place_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesListScreen extends ConsumerWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var places = ref.watch(placesNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Favourite Places"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddNewPlaceScreen()));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
          itemCount: places.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        PlaceDetailsScreen(place: places[index])));
              },
              leading: Container(
                height: 20,
                width: 20,
                color: Colors.orange,
              ),
              title: Text(
                places[index].name,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            );
          }),
    );
  }
}
