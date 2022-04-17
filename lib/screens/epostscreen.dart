import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paws_app/utils/colors.dart';
import 'package:paws_app/utils/global_variable.dart';
import 'package:paws_app/widgets/eposte_card.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class epostScreen extends StatefulWidget {
  const epostScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<epostScreen> createState() => _epostScreenState();
}

class _epostScreenState extends State<epostScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    return Scaffold(
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'NGO list',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Peta'),
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Welfare for stray dogs'),
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Ngo 3'),
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Ngo 4'),
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Ngo 5'),
            ),
           ],

        ),
      ),
      backgroundColor:
      width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
      appBar: width > webScreenSize
          ? null
          : AppBar(
        backgroundColor: mobileBackgroundColor,
        foregroundColor: Colors.red,
        centerTitle: false,
        title: SvgPicture.asset(
          'assets/ic_paws_app.svg',
          color: primaryColor,
          height: 32,
        ),
        actions: [
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Emergencyimage').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Container(
              margin: EdgeInsets.symmetric(
                horizontal: width > webScreenSize ? width * 0.3 : 0,
                vertical: width > webScreenSize ? 15 : 0,
              ),
              child: ePostCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            ),
          );
        },
      ),
    );

  }
}
