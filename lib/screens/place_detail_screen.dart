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
        child: Stack(
              children: [
                Image.file(
                  place.selectedImage,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                )
              ],
            )
        ),
    );
  }
}

