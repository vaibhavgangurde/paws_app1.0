import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({Key? key}) : super(key: key);

  @override
  _EmergencyScreenState createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  List<String> myItems = [
    "select type ok",
    "Accident",
    "Injury",
    "Weak",
    "Physically abused",
    "In danger/lost",
    "Not In List"
  ];
  var myInitialItem = "select type ok";
  String colourGroupVariable = '';
  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);

      this.image = imageTemporary;
    } on PlatformException catch (e) {
      print('success: $e');
    }
  }

  var locationMessage = "";

  var locationMessa = "";

  void getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    var Lastposition = await Geolocator.getLastKnownPosition();
    print(Lastposition);

    setState(() {
      locationMessage = " $position.altitude";
      //locationMessa = "$position.longitude";

      Placemark() async {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 90)),
                    Row(
                      children: [
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        const Text(
                          'Help',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 260,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.notifications_active_rounded),
                        )
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     Padding(padding: EdgeInsets.only(left: 150)),
                    //     ElevatedButton.icon(
                    //         onPressed: () {},
                    //         icon: Icon(
                    //           Icons.image_search,
                    //           color: Colors.black,
                    //           size: 40,
                    //         ),
                    //         label: Text(
                    //           'Upload Image',
                    //           style: TextStyle(
                    //               fontSize: 20,
                    //               fontWeight: FontWeight.bold,
                    //               color: Colors.black),
                    //         ))
                    //   ],
                    // ),
                    Row(
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(top: 200, left: 50)),
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.orange.shade50,
                              minimumSize: const Size(300, 100)),
                          onPressed: () => pickImage(),
                          icon: const Icon(
                            Icons.image_search,
                          ),
                          label: const Text(
                            'Upload Image',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.orange.shade50,
                              minimumSize: const Size(300, 100)),
                          onPressed: () {
                            getCurrentLocation();
                          },
                          icon: const Icon(Icons.location_on_sharp),
                          label: const Text('Get Location',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                      ],
                    ),
                    Container(
                      child: Text(
                        " Current Location:\n" + locationMessage,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.yellow.shade100,
                          border: Border.all(
                            width: 2,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                      margin: const EdgeInsets.all(20),
                    ),

                    Row(
                      children: const [
                        Padding(padding: EdgeInsets.only(top: 40, left: 20)),
                        Text(
                          'Select Issue',
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        DropdownButtonHideUnderline(
                          child: Container(
                            decoration:
                                const BoxDecoration(color: Colors.green),
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 40),
                            child: DropdownButton(
                              onChanged: (value) {
                                setState(() {
                                  myInitialItem = value as String;
                                });
                              },
                              value: myInitialItem,
                              items: myItems.map((items) {
                                return DropdownMenuItem(
                                    value: items, child: Text(items));
                              }).toList(),
                            ),
                          ),
                        )
                      ],
                    ),

                    Column(
                      children: [
                        Row(
                          children: [
                            const Padding(
                                padding: EdgeInsets.only(top: 10, left: 20)),
                            const Text(
                              'How urgent is the case ?',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: 'Urgent',
                                groupValue: colourGroupVariable,
                                onChanged: (val) {
                                  colourGroupVariable = val as String;
                                  setState(() {});
                                }),
                            const Text('Urgent')
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: 'Not Urgent',
                                groupValue: colourGroupVariable,
                                onChanged: (val) {
                                  colourGroupVariable = val as String;

                                  setState(() {});
                                }),
                            const Text('Not Urgent'),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: 'Very Urgent',
                                groupValue: colourGroupVariable,
                                onChanged: (val) {
                                  colourGroupVariable = val as String;

                                  setState(() {});
                                }),
                            const Text('Very Urgent')
                          ],
                        ),
                      ],
                    ),

                    Column(
                      children: [
                        Row(
                          children: [
                            const Padding(padding: EdgeInsets.only(left: 20)),
                            const Text(
                              'Comment down',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Row(
                      children: <Widget>[
                        const Padding(padding: EdgeInsets.all(10)),
                        Flexible(
                          child: TextField(
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0))),
                              fillColor: Colors.yellow.shade100,
                              filled: true,
                            ),
                          ),
                        )
                      ],
                    ),

                    Container(),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
