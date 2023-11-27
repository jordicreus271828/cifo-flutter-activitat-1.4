import 'package:flutter/material.dart';

import '../model/postal_code_to_place.dart';

class PostalCodeToPlaceResult extends StatelessWidget {
  const PostalCodeToPlaceResult({
    super.key,
    required this.postalCodeToPlace,
  });

  final PostalCodeToPlace? postalCodeToPlace;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: (postalCodeToPlace == null) ? Colors.red : Colors.green),
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        if (postalCodeToPlace == null) {
          return const Row(
            children: [
              Icon(
                Icons.error,
                color: Colors.red,
              ),
              SizedBox(width: 5),
              Text("This postal code does not exist."),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                postalCodeToPlace!.places.first.placeName,
                style: const TextStyle(fontSize: 24.0),
              ),
              Text(
                  "State: ${postalCodeToPlace!.places.first.state} (${postalCodeToPlace!.places.first.stateAbbreviation})"),
              Text(
                  "Longitude: ${postalCodeToPlace!.places.first.longitude}, Latitude: ${postalCodeToPlace!.places.first.latitude}"),
            ],
          );
        }
      }),
    );
  }
}
