import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';
import '../helpers/db_helpers.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  void addPlace(Place newPlace) {
    _items.add(newPlace);
    notifyListeners();

    DBHelper.insert("places", {
      "id": newPlace.id,
      "title": newPlace.title,
      "image": newPlace.image.path,
    });
  }

  Future<void> loadPlaces() async {
    final placesData = await DBHelper.getData("places");
    _items = placesData
        .map(
          (placeData) => Place(
            id: placeData["id"].toString(),
            title: placeData["title"].toString(),
            location: null,
            image: File(placeData["image"].toString()),
          ),
        )
        .toList();

    notifyListeners();
  }
}
