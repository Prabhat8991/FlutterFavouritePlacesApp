import 'package:flutter/material.dart';

import '../models/place.dart';

class PlaceDetailsScreen extends StatelessWidget {

  const PlaceDetailsScreen({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Place details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(place.name, style: Theme
                .of(context)
                .textTheme
                .titleMedium
                ?.copyWith(
                color: Theme
                    .of(context)
                    .colorScheme
                    .onBackground
            ),)
          ],
        ),
      ),
    );
  }


}