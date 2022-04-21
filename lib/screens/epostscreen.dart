import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paws_app/utils/colors.dart';
import 'package:paws_app/utils/global_variable.dart';
import 'package:paws_app/utils/utils.dart';
import 'package:paws_app/widgets/eposte_card.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:paws_app/resources/lcn.dart';

class epostScreen extends StatefulWidget {
  const epostScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<epostScreen> createState() => _epostScreenState();
}

class _epostScreenState extends State<epostScreen> {
  bool isLoading = false;

  storeNotificationToken()async{
    String? token = await FirebaseMessaging.instance.getToken();
    FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set(
        {
          'token': token
        },SetOptions(merge: true));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.display(event);
    });
    storeNotificationToken();
    FirebaseMessaging.instance.subscribeToTopic('subscription');

  }



  // sendNotification(String title, String token)async{
  //
  //   final data = {
  //     'click_action': 'FLUTTER_NOTIFICATION_CLICK',
  //     'id': '1',
  //     'status': 'done',
  //     'message': title,
  //   };
  //
  //   try{
  //     http.Response response = await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),headers: <String,String>{
  //       'Content-Type': 'application/json',
  //       'Authorization': 'key=AAAAUzng3eQ:APA91bEedhbpUv4dH5AFzgIEtoOhtNTBqpuaGSdzCiKSo2IeixhrbSNGZdPbKFgYxxKDraDO0sZUQj2gg66dWUFRbsH1r1OL-Ji1geaO1PfKbfi_GwNKH-KMq-Wu5cCkFFZcyrboAx0a'
  //     },
  //         body: jsonEncode(<String,dynamic>{
  //           'notification': <String,dynamic> {'title': title,'body': 'You are followed by someone'},
  //           'priority': 'high',
  //           'data': data,
  //           'to': '$token'
  //         })
  //     );
  //
  //
  //     if(response.statusCode == 200){
  //       print("Yeh notificatin is sended");
  //     }else{
  //       print("Error");
  //     }
  //
  //   }catch(e){
  //
  //   }
  //
  // }


  sendNotificationToTopic(String title)async{

    final data = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done',
      'message': title,
    };

    try{
      http.Response response = await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),headers: <String,String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=AAAAUzng3eQ:APA91bEedhbpUv4dH5AFzgIEtoOhtNTBqpuaGSdzCiKSo2IeixhrbSNGZdPbKFgYxxKDraDO0sZUQj2gg66dWUFRbsH1r1OL-Ji1geaO1PfKbfi_GwNKH-KMq-Wu5cCkFFZcyrboAx0a'
      },
          body: jsonEncode(<String,dynamic>{
            'notification': <String,dynamic> {'title': title,'body': 'Someone in trouble'},
            'priority': 'high',
            'data': data,
            'to': '/topics/subscription'
          })
      );


      if(response.statusCode == 200){
        print("Yeh notificatin is sended");
      }else{
        print("Error");
      }

    }catch(e){

    }

  }

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
           // IconButton(onPressed: (){
           //   sendNotification('title', token);
           // }, icon: Icon(Icons.send)),
    //    StreamBuilder<QuerySnapshot>(
    // stream: FirebaseFirestore.instance
    //     .collection('users')
    //     .snapshots(),
    // builder: (context, secSnapshot) {
    // if (!secSnapshot.hasData) {
    // return const CircularProgressIndicator();
    // }
    //
    // return ListView.builder(
    // itemCount: secSnapshot.data!.docs.length,
    // physics: const NeverScrollableScrollPhysics(),
    // shrinkWrap: true,
    // itemBuilder: (context, i) {
    // String? token;
    // try {
    // token = secSnapshot.data!.docs[i]
    //     .get('token');
    // } catch (e) {}
    // User? user =
    // FirebaseAuth.instance.currentUser;
    // final docId = secSnapshot.data!.docs[i].id;
    // return Container(
    // margin: const EdgeInsets.all(15),
    // padding: const EdgeInsets.all(10),
    // decoration: BoxDecoration(
    // border: Border.all(width: 1),
    // ),
    // child: Row(
    // children: [
    // Column(
    // crossAxisAlignment:
    // CrossAxisAlignment.start,
    // children: [
    // Text(
    // secSnapshot.data!.docs[i]['Name'],
    // style: TextStyle(
    // fontSize: 20,
    // color: Colors.black,
    // ),
    // ),
    // Text(
    // secSnapshot.data!.docs[i]
    // ['Email'],
    // style: TextStyle(
    // fontSize: 14,
    // color: Colors.black45,
    // ))
    // ],
    // ),
    // ],
    // ),
    // );
    // },
    // );
    // },
    // );},icon: Icon(Icons.people) ),
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
