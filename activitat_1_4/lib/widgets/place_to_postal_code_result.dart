import 'package:flutter/material.dart';

import '../model/place_to_postal_code.dart';

class PlaceToPostalCodeResult extends StatelessWidget {
  const PlaceToPostalCodeResult({
    super.key,
    required this.place,
  });

  final Place? place;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: (place == null) ? Colors.red : Colors.green),
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        if (place == null) {
          return const Row(
            children: [
              Icon(
                Icons.error,
                color: Colors.red,
              ),
              SizedBox(width: 5),
              Text("This place does not exist."),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                place!.placeName,
                style: const TextStyle(fontSize: 24.0),
              ),
              Text(
                  "Postal code: ${place!.postCode}"),
              Text(
                  "Longitude: ${place!.longitude}, Latitude: ${place!.latitude}"),
            ],
          );
        }
      }),
    );
  }
}
