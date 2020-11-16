import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  final _location = Location();

  Future<void> _getCurrentUserLocation() async {
    final loc = await _location.getLocation();
    print(loc.latitude);
    print(loc.longitude);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(children: [
      Container(
        height: 170,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.grey,
          ),
        ),
        child: _previewImageUrl != null
            ? Image.network(_previewImageUrl)
            : const Text(
                "No location chosen",
                textAlign: TextAlign.center,
              ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlatButton.icon(
            icon: const Icon(Icons.location_on),
            label: const Text("Current location"),
            textColor: theme.primaryColor,
            onPressed: _getCurrentUserLocation,
          ),
          FlatButton.icon(
            icon: const Icon(Icons.map),
            onPressed: null,
            label: const Text("Select on map"),
            textColor: theme.primaryColor,
          ),
        ],
      ),
    ]);
  }
}
