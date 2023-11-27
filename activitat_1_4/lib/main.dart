import 'package:flutter/material.dart';

import 'screens/home_page.dart';

void main() {
  runApp(const PlaceAndPostalCodeSearch());
}

class PlaceAndPostalCodeSearch extends StatelessWidget {
  const PlaceAndPostalCodeSearch({super.key});

  @override
  Widget build(BuildContext context) {
    String title = 'Place & Postal Code Search';

    return MaterialApp(
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
      ),
      home: HomePage(title: title),
    );
  }
}
