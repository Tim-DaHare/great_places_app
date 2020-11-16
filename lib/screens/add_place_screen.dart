import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places_app/models/place.dart';
import 'package:provider/provider.dart';

import '../providers/places_provider.dart';
import '../widgets/image_input.dart';
import '../widgets/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const String ROUTE_NAME = "/add-place";

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();

  File _pickedImage;

  void _onSubmit() {
    if (_titleController.text.isEmpty || _pickedImage == null) return;

    Provider.of<PlacesProvider>(
      context,
      listen: false,
    ).addPlace(Place(
      id: DateTime.now().toIso8601String(),
      title: _titleController.text,
      location: null,
      image: _pickedImage,
    ));

    Navigator.of(context).pop();
  }

  void _onImageSelected(File pickedImg) {
    _pickedImage = pickedImg;
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a new place"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: "Title"),
                    controller: _titleController,
                  ),
                  const SizedBox(height: 10),
                  ImageInput(onImageSelected: _onImageSelected),
                  const SizedBox(height: 10),
                  // LocationInput()
                ],
              ),
            ),
          ),
          RaisedButton.icon(
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: _theme.accentColor,
            icon: const Icon(Icons.add),
            label: const Text("Add Place"),
            onPressed: _onSubmit,
          )
        ],
      ),
    );
  }
}
