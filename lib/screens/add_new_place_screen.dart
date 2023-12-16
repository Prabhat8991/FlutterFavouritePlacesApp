import 'dart:io';

import 'package:favourite_places/providers/places_provider.dart';
import 'package:favourite_places/widgets/image_input.dart';
import 'package:favourite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/place.dart';

class AddNewPlaceScreen extends ConsumerStatefulWidget {
  const AddNewPlaceScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AddNewPlaceState();
  }
}

class _AddNewPlaceState extends ConsumerState<AddNewPlaceScreen> {
  String _name = '';
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new place"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
              decoration: const InputDecoration(
                label: Text("Enter place name"),
              ),
              onChanged: (value) {
                _name = value;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ImageInput(onImageSelected: (selectedImage) {
              _selectedImage = selectedImage;
            }),
            const SizedBox(
              height: 20,
            ),
            const LocationInput(),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  ref.read(placesNotifierProvider.notifier).addNewPlace(
                      Place(name: _name, selectedImage: _selectedImage!));
                  Navigator.of(context).pop();
                },
                child: const Text("Submit"))
          ],
        ),
      ),
    );
  }
}
