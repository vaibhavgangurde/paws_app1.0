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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: TextFieldInput(
              hintText: 'Enter Unique Id',
              textInputType: TextInputType.emailAddress,
              textEditingController: abc,
            ),
          ),
          ElevatedButton(onPressed: (){
            FirebaseMessaging.instance.subscribeToTopic('NGO');
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
            showSnackBar(context, 'You will be verified within 24hrs');
          }, child: Text('Verify'),),
        ],
      ),
    );
  }
}
