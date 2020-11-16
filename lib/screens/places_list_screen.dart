import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/places_provider.dart';
import '../models/place.dart';
import './add_place_screen.dart';
import './place_details_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _placesProv = Provider.of<PlacesProvider>(context, listen: false);

    void _onPressAdd() {
      Navigator.of(context).pushNamed(AddPlaceScreen.ROUTE_NAME);
    }

    void _onTapPlace(Place place) {
      Navigator.of(context).pushNamed(
        PlaceDetailsScreen.ROUTE_NAME,
        arguments: PlaceDetailsScreenArgs(place: place),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your places"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _onPressAdd,
          )
        ],
      ),
      body: FutureBuilder(
        future: _placesProv.loadPlaces(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return Consumer<PlacesProvider>(
            builder: (ctx, placesProv, child) => placesProv.items.isNotEmpty
                ? ListView.builder(
                    itemCount: placesProv.items.length,
                    itemBuilder: (ctx, i) => ListTile(
                      key: ValueKey(placesProv.items[i].id),
                      leading: CircleAvatar(
                        backgroundImage: FileImage(
                          placesProv.items[i].image,
                        ),
                      ),
                      title: Text(placesProv.items[i].title),
                      onTap: () => _onTapPlace(placesProv.items[i]),
                    ),
                  )
                : const Center(
                    child: const Text("Got no places yet, start adding some!"),
                  ),
          );
        },
      ),
    );
  }
}
