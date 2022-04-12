import 'package:flutter/material.dart';
import 'package:paws_app/utils/utils.dart';
import 'package:paws_app/widgets/text_field_input.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);



  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _otp = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 30, left: 90),
            child: const Text(
              'Enter Code',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            color: Colors.yellow,
            //padding: EdgeInsets.only(top: 500),
            width: 500,
            height: 200,
            margin: const EdgeInsets.only(top: 60, left: 10, right: 10),

            child: TextFieldInput(
              textInputType: TextInputType.emailAddress,
              textEditingController: _email,
              hintText: 'EMAIL',
            ),
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          ),
const SizedBox(
  height: 200,
),
          Container(
            padding: const EdgeInsets.only(top: 300, left: 30),
            child: TextButton(
                onPressed: () {
                  auth.sendPasswordResetEmail(email: _email.text );
                  Navigator.of(context).pop();
                  showSnackBar(context, 'PASSWORD RESET EMAIL HAS BEEN SENT');
    },
                child: const Text(
                  'Send Password reset Email.',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                )),
          )
          // Container(
          //   padding: EdgeInsets.only(top: 30, left: 20),
          //   color: Colors.blue,
          //   child: TextField(
          //       obscureText: true,
          //       decoration: InputDecoration(
          //           fillColor: Colors.white,
          //           hintText: 'password',
          //           border: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(10)))),
          // )
        ],
      ),
    );
  }
}
