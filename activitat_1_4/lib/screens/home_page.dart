import 'package:activitat_1_4/model/place_to_postal_code.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/postal_code_to_place.dart';
import '../widgets/place_to_postal_code_result.dart';
import '../widgets/postal_code_to_place_result.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // tab 1: postal code to place
  final TextEditingController _tab1TextFieldController = TextEditingController();
  bool _tab1TextFieldHas5Characters = false;
  PostalCodeToPlace? _postalCodeToPlace;
  bool _tab1ShowResult = false;

  // tab 2: place to postal code
  final TextEditingController _tab2TextFieldController = TextEditingController();
  PlaceToPostalCode? _placeToPostalCode;
  bool _tab2ShowResults = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Postal code to place"),
              Tab(text: "Place to postal code"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Enter a postal code"),
                    const SizedBox(height: 10),
                    TextField(
                      decoration:
                          const InputDecoration(hintText: "Ex: 08907"),
                      controller: _tab1TextFieldController,
                      keyboardType: TextInputType.number,
                      maxLength: 5,
                      onChanged: (value) {
                        setState(() {
                          _tab1TextFieldHas5Characters = (value.length == 5);
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed:
                              _tab1TextFieldHas5Characters ? searchPlace : null,
                          child: const Row(
                            children: [
                              Icon(Icons.search),
                              SizedBox(width: 5),
                              Text("Search"),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (_tab1ShowResult) const SizedBox(height: 10),
                    if (_tab1ShowResult)
                      PostalCodeToPlaceResult(
                          postalCodeToPlace: _postalCodeToPlace),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Enter a place"),
                    const SizedBox(height: 10),
                    TextField(
                      decoration:
                          const InputDecoration(hintText: "Ex: Barcelona"),
                      controller: _tab2TextFieldController,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: searchPostalCodes,
                          child: const Row(
                            children: [
                              Icon(Icons.search),
                              SizedBox(width: 5),
                              Text("Search"),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (_tab2ShowResults) const SizedBox(height: 10),
                    if (_tab2ShowResults && _placeToPostalCode == null)
                      const PlaceToPostalCodeResult(place: null),
                    if (_tab2ShowResults && _placeToPostalCode != null)
                      for (var place in _placeToPostalCode!.places)
                        PlaceToPostalCodeResult(place: place),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void searchPlace() async {
    String postalCode = _tab1TextFieldController.text;

    http.Response response =
        await http.get(Uri.parse("https://api.zippopotam.us/es/$postalCode"));
    try {
      _postalCodeToPlace = postalCodeToPlaceFromJson(response.body);
    } catch (e) {
      _postalCodeToPlace = null;
    }
    _tab1ShowResult = true;
    setState(() {});
  }

  void searchPostalCodes() async {
    String place = _tab2TextFieldController.text;

    http.Response response =
        await http.get(Uri.parse("https://api.zippopotam.us/es/ct/$place"));
    try {
      _placeToPostalCode = placeToPostalCodeFromJson(response.body);
    } catch (e) {
      _placeToPostalCode = null;
    }
    _tab2ShowResults = true;
    setState(() {});
  }
}
