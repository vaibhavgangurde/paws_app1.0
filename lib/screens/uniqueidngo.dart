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

Idstorage(String Ngoname,String uniqueid) async{
  await FirebaseFirestore.instance.collection('Id').doc().set({
    'NgoName': Ngoname=abc.text,
    'uniqueid': uniqueid=xyz.text,
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 200,
          ),
          Container(
            child: TextFieldInput(
              hintText: 'Enter Ngo Name',
              textInputType: TextInputType.emailAddress,
              textEditingController: abc,
            ),
          ),
          Container(
            child: TextFieldInput(
              hintText: 'Enter Unique Id',
              textInputType: TextInputType.emailAddress,
              textEditingController: xyz,
            ),
          ),
          Container(
          child :ElevatedButton(onPressed: (){

            FirebaseMessaging.instance.subscribeToTopic('NGO');

            Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
            showSnackBar(context, 'You will be verified within 24hrs');
          }, child: Text('Verify'),),),
        ],
      ),
    );
  }
}
