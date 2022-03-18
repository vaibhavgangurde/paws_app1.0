import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
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

            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'CODE',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),

            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          ),
          Container(
            padding: const EdgeInsets.only(top: 160, left: 130),
            child: ElevatedButton(onPressed: () {}, child: const Text('Done')),
          ),
          Container(
            padding: const EdgeInsets.only(top: 200, left: 30),
            child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Resend code',
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
