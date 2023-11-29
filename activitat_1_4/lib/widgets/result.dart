import 'package:flutter/material.dart';

import '../model/place_response.dart' as place_response;
import '../model/postal_codes_response.dart' as postal_codes_response;

class Result extends StatelessWidget {
  const Result({
    super.key,
    required this.place,
  });

  final Object? place;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: (place == null) ? Colors.red : Colors.green),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: LayoutBuilder(builder: (context, constraints) {
          if (place == null) {
            return Row(
              children: [
                const Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                const SizedBox(width: 5),
                Text(
                  (place is place_response.Place)
                      ? "This postal code does not exist."
                      : "This place does not exist.",
                )
              ],
            );
          } else {
            if (place is place_response.Place) {
              place_response.Place place1 = place as place_response.Place;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place1.placeName,
                    style: const TextStyle(fontSize: 24.0),
                  ),
                  Text("State: ${place1.state} (${place1.stateAbbreviation})"),
                  Text(
                      "Longitude: ${place1.longitude}, Latitude: ${place1.latitude}"),
                ],
              );
            } else {
              postal_codes_response.Place place2 =
                  place as postal_codes_response.Place;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place2.placeName,
                    style: const TextStyle(fontSize: 24.0),
                  ),
                  Text("Postal code: ${place2.postCode}"),
                  Text(
                      "Longitude: ${place2.longitude}, Latitude: ${place2.latitude}"),
                ],
              );
            }
          }
        }),
      ),
    );
  }
}
