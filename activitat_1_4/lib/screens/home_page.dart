import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/place_response.dart';
import '../model/postal_codes_response.dart';
import '../widgets/result_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // tab 1: postal code to place
  final TextEditingController _tab1TextFieldController =
      TextEditingController();
  bool _tab1TextFieldHas5Characters = false;
  PlaceResponse? _placeResponse;
  bool _tab1ShowResult = false;

  // tab 2: place to postal code
  final TextEditingController _tab2TextFieldController =
      TextEditingController();
  PostalCodesResponse? _postalCodesResponse;
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
                      decoration: const InputDecoration(hintText: "Ex: 08907"),
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
                    if (_tab1ShowResult) ...tab1ShowResult(),
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
                    if (_tab2ShowResults) ...tab2ShowResults(),
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
      _placeResponse = placeResponseFromJson(response.body);
    } catch (e) {
      _placeResponse = null;
    }
    _tab1ShowResult = true;
    setState(() {});
  }

  void searchPostalCodes() async {
    String place = _tab2TextFieldController.text;

    http.Response response =
        await http.get(Uri.parse("https://api.zippopotam.us/es/ct/$place"));
    try {
      _postalCodesResponse = postalCodesResponseFromJson(response.body);
    } catch (e) {
      _postalCodesResponse = null;
    }
    _tab2ShowResults = true;
    setState(() {});
  }

  tab1ShowResult() {
    return [
      const SizedBox(height: 10),
      if (_placeResponse == null)
        const ResultCard(isError: true, tab: 1, place: null),
      if (_placeResponse != null)
        ResultCard(isError: false, tab: 1, place: _placeResponse!.places.first),
    ];
  }

  tab2ShowResults() {
    return [
      const SizedBox(height: 10),
      if (_postalCodesResponse == null)
        const ResultCard(isError: true, tab: 2, place: null),
      if (_postalCodesResponse != null)
        for (var place in _postalCodesResponse!.places) ...[
          ResultCard(isError: false, tab: 2, place: place),
          const SizedBox(height: 10),
        ],
    ];
  }
}
