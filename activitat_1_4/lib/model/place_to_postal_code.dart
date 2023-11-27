// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

PlaceToPostalCode placeToPostalCodeFromJson(String str) => PlaceToPostalCode.fromJson(json.decode(str));

String placeToPostalCodeToJson(PlaceToPostalCode data) => json.encode(data.toJson());

class PlaceToPostalCode {
  String countryAbbreviation;
  List<Place> places;
  String country;
  // PlaceName placeName;
  String placeName;
  String state;
  String stateAbbreviation;

  PlaceToPostalCode({
    required this.countryAbbreviation,
    required this.places,
    required this.country,
    required this.placeName,
    required this.state,
    required this.stateAbbreviation,
  });

  factory PlaceToPostalCode.fromJson(Map<String, dynamic> json) => PlaceToPostalCode(
    countryAbbreviation: json["country abbreviation"],
    places: List<Place>.from(json["places"].map((x) => Place.fromJson(x))),
    country: json["country"],
    // placeName: placeNameValues.map[json["place name"]]!,
    placeName: json["place name"],
    state: json["state"],
    stateAbbreviation: json["state abbreviation"],
  );

  Map<String, dynamic> toJson() => {
    "country abbreviation": countryAbbreviation,
    "places": List<dynamic>.from(places.map((x) => x.toJson())),
    "country": country,
    "place name": placeNameValues.reverse[placeName],
    "state": state,
    "state abbreviation": stateAbbreviation,
  };
}

enum PlaceName {
  BARCELONA
}

final placeNameValues = EnumValues({
  "Barcelona": PlaceName.BARCELONA
});

class Place {
  // PlaceName placeName;
  String placeName;
  String longitude;
  String postCode;
  String latitude;

  Place({
    required this.placeName,
    required this.longitude,
    required this.postCode,
    required this.latitude,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
    // placeName: placeNameValues.map[json["place name"]]!,
    placeName: json["place name"],
    longitude: json["longitude"],
    postCode: json["post code"],
    latitude: json["latitude"],
  );

  Map<String, dynamic> toJson() => {
    "place name": placeNameValues.reverse[placeName],
    "longitude": longitude,
    "post code": postCode,
    "latitude": latitude,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
