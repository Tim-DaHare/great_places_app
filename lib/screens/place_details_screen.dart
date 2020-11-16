import 'package:flutter/material.dart';
import '../models/place.dart';

class PlaceDetailsScreenArgs {
  final Place place;

  PlaceDetailsScreenArgs({
    @required this.place,
  });
}

class PlaceDetailsScreen extends StatelessWidget {
  static const String ROUTE_NAME = "/place-details";

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as PlaceDetailsScreenArgs;

    return Scaffold(
      appBar: AppBar(
        title: Text(routeArgs.place.title),
      ),
      body: Column(children: [
        Container(
          height: 250,
          width: double.infinity,
          child: Image.file(
            routeArgs.place.image,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        SizedBox(height: 10),
      ]),
    );
  }
}
