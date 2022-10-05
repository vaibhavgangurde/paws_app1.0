import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:paws_app/utils/utils.dart';
import 'package:paws_app/widgets/text_field_input.dart';
import 'login_screen.dart';

class ngouniqueid extends StatefulWidget {
  const ngouniqueid({Key? key}) : super(key: key);
  @override
  _ngouniqueidState createState() => _ngouniqueidState();
}

class _ngouniqueidState extends State<ngouniqueid> {
  final TextEditingController abc = TextEditingController();
  final TextEditingController xyz = TextEditingController();

  Idstorage(String Ngoname, String uniqueid) async {
    await FirebaseFirestore.instance.collection('Id').doc().set({
      'NgoName': Ngoname = abc.text,
      'uniqueid': uniqueid = xyz.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 250,
          ),
          Container(
            alignment: Alignment.center,
            width: 350.00,
            child: TextFieldInput(
              hintText: 'Enter Ngo Name',
              textInputType: TextInputType.emailAddress,
              textEditingController: abc,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            width: 350.00,
            child: TextFieldInput(
              hintText: 'Enter Unique Id',
              textInputType: TextInputType.emailAddress,
              textEditingController: xyz,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                FirebaseMessaging.instance.subscribeToTopic('NGO');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
                showSnackBar(context, 'You will be verified within 24hrs');
              },
              child: const Text(
                'Verify',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
