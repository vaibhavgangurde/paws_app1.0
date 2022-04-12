import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:paws_app/models/eposte.dart';
import 'package:paws_app/resources/firestore_methods.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paws_app/models/post.dart';
import 'package:paws_app/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';
import 'dart:typed_data';
import 'package:paws_app/providers/user_provider.dart';
import 'package:paws_app/resources/firestore_methods.dart';
import 'package:paws_app/utils/colors.dart';
import 'package:paws_app/utils/utils.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';
import '../widgets/text_field_input.dart';
import 'package:geocoding/geocoding.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({Key? key}) : super(key: key);

  @override
  _EmergencyScreenState createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController t1= new TextEditingController();
  bool isLoading = false;
  Uint8List? _file;
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
  Future<String> eimage1(String description, Uint8List file, String uid,
      String username, String profImage) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    try {
      String photoUrl =
      await StorageMethods().uploadImageToStorage('eposts', file, true);
      String postId = const Uuid().v1(); // creates unique id based on time
      eposte epost = eposte(
        description: description,
        uid: uid,
        username: username,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
      );
      _firestore.collection('Emergencyimage').doc(postId).set(epost.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
  void postImage(String uid, String username, String profImage) async {
    setState(() {
      isLoading = true;
    });
    // start the loading
    try {
      // upload to storage and db
      String res = await eimage1(
        t1.text,
        _file!,
        uid,
        username,
        profImage,
      );
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        showSnackBar(
          context,
          'Posted!',
        );
      } else {
        showSnackBar(context, res);
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }
  @override
  void dispose() {
    super.dispose();
    t1.dispose();
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
      Placemark() async {}
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    _file == null;
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
                   Column(
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(top: 10, left: 50)),
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.orange.shade50,
                              minimumSize: const Size(300, 100)),
                          onPressed:() async {
                        Uint8List file = await pickImage(ImageSource.camera);
                        setState(() {
                        _file = file;
                        });
                        },
                          icon: const Icon(
                            Icons.image_search,
                          ),
                          label: const Text(
                            'CLICK IMAGE',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        TextFieldInput(
                          hintText: 'Enter in detail',
                          textInputType: TextInputType.text,
                          textEditingController: t1,
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
                        TextButton(
                          onPressed: () => postImage(
                            userProvider.getUser.uid,
                            userProvider.getUser.username,
                            userProvider.getUser.photoUrl,
                          ),
                          child: const Text(
                            "Post",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          ),
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
