import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onImageSelected});

  final void Function(File file) onImageSelected;

  @override
  State<StatefulWidget> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedFile;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final selectedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (selectedImage == null) {
      return;
    }
    setState(() {
      _selectedFile = File(selectedImage.path);
    });
    widget.onImageSelected(_selectedFile!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
        onPressed: _takePicture,
        icon: const Icon(Icons.camera),
        label: const Text("Pick an image"));

    if (_selectedFile != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          _selectedFile!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    return Container(
      alignment: Alignment.center,
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
      ),
      child: content,
    );
  }
}
