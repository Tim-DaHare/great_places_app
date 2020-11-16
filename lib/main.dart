import 'package:flutter/material.dart';
import 'package:great_places_app/providers/places_provider.dart';
import 'package:great_places_app/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

import './screens/places_list_screen.dart';
import './screens/place_details_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => PlacesProvider()),
      ],
      builder: (ctx, child) => MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.ROUTE_NAME: (ctx) => AddPlaceScreen(),
          PlaceDetailsScreen.ROUTE_NAME: (ctx) => PlaceDetailsScreen(),
        },
      ),
    );
  }
}
