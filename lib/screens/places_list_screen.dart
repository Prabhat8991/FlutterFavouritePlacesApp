import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/providers/places_provider.dart';
import 'package:favourite_places/screens/add_new_place_screen.dart';
import 'package:favourite_places/screens/place_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesListScreen extends ConsumerStatefulWidget {
  const PlacesListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _PlacesListState();
  }
}

class _PlacesListState extends ConsumerState<PlacesListScreen> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(placesNotifierProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
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
        body: FutureBuilder(
          future: _placesFuture,
          builder: (context, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? const CircularProgressIndicator()
              : PlacesList(places: places),
        ));
  }
}

class PlacesList extends StatelessWidget {
  const PlacesList({
    super.key,
    required this.places,
  });

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      PlaceDetailsScreen(place: places[index])));
            },
            leading: CircleAvatar(
              backgroundImage: FileImage(places[index].selectedImage),
            ),
            title: Text(
              places[index].name,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(
                      color:
                          Theme.of(context).colorScheme.onBackground),
            ),
          );
        });
  }
}
