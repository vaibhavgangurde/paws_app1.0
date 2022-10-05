
import 'dart:convert';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:paws_app/models/user.dart' as model;
import 'package:paws_app/providers/user_provider.dart';
import 'package:paws_app/resources/firestore_methods.dart';
import 'package:paws_app/utils/colors.dart';
import 'package:paws_app/utils/global_variable.dart';
import 'package:paws_app/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:paws_app/resources/lcn.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:paws_app/screens/comments_screen.dart';


class ePostCard extends StatefulWidget {
  final snap;
  const ePostCard({
    Key? key,
    required this.snap,
  }) : super(key: key);
  @override
  State<ePostCard> createState() => _ePostCardState();
}

class _ePostCardState extends State<ePostCard> {
  // storeNotificationToken()async{
  //   String? token = await FirebaseMessaging.instance.getToken();
  //   FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set(
  //       {
  //         'token': token
  //       },SetOptions(merge: true));
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.display(event);
    });
  }
bool show = true;
  void hide(){
    show !=show;
  }
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
            'notification': <String,dynamic> {'title': title,'body':'Someone need help'},
            'priority': 'high',
            'data': data,
            'to': '/topics/NGO',
          })
      );

      if(response.statusCode == 200){
        print("Yeh notificatin is sended");
      }else{
        print("Error");
      }

    }catch(e){
      e.toString();

    }

  }

  deleteePost(String postId) async {
    try {
      await FireStoreMethods().deleteePost(postId);
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;
    final width = MediaQuery.of(context).size.width;
   return Container(
      // boundary needed for web
      decoration: BoxDecoration(
        border: Border.all(
          color: width > webScreenSize ? secondaryColor : mobileBackgroundColor,
        ),
        color: mobileBackgroundColor,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          // HEADER SECTION OF THE POST
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    widget.snap['profImage'].toString(),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.snap['username'].toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                 widget.snap['uid'].toString()==user.uid
                    ? IconButton(
                  onPressed: () {
                    showDialog(
                      useRootNavigator: false,
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: ListView(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16),
                              shrinkWrap: true,
                              children: [
                                'Delete',
                              ]
                                  .map(
                                    (e) => InkWell(
                                    child: Container(
                                      padding:
                                      const EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 16),
                                      child: Text(e),
                                    ),
                                    onTap: () {
                                      deleteePost(
                                        widget.snap['postId']
                                            .toString(),
                                      );
                                      // remove the dialog box
                                      Navigator.of(context).pop();
                                    }),
                              )
                                  .toList()),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.more_vert),
                )
                :Container(),
              ],
            ),
          ),
          // IMAGE SECTION OF THE POST
          // LIKE, COMMENT SECTION OF THE POST
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(
              widget.snap['postUrl'].toString(),
              fit: BoxFit.cover,
            ),
          ),
          //DESCRIPTION AND NUMBER OF COMMENTS
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DefaultTextStyle(
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontWeight: FontWeight.w800),
                    child: Text(widget.snap['location'].toString(),
                      style: Theme.of(context).textTheme.bodyText2,
                    )),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: primaryColor),
                      children: [
                        TextSpan(
                          text: widget.snap['username'].toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ' ${widget.snap['description']}',
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    DateFormat.jm()
                        .format(widget.snap['datePublished'].toDate()),
                    style: const TextStyle(
                      color: secondaryColor,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 4),
                ),
                Container(
                  child: Text(
                    DateFormat.yMMMd()
                        .format(widget.snap['datePublished'].toDate()),
                    style: const TextStyle(
                      color: secondaryColor,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 4),
                ),
                widget.snap['uid'].toString()==user.uid
                ?
                ArgonTimerButton(
                    initialTimer: 10,
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.45,
                    minWidth: MediaQuery.of(context).size.width * 0.30,
                    borderRadius: 5.0,
                    color: Colors.blue,
                    child: Text(
                      "Send Post",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700
                      ),),
                    loader: (timeLeft) {
                      return Text(
                        "Wait | $timeLeft",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w700
                        ),
                      );
                    },
    onTap: (StartTimer,BtnState) {
                      StartTimer(600);
                      sendNotificationToTopic('Emergency Alert');
    }
                )
                    :Container()
                ,
                IconButton(
                  icon: const Icon(
                    Icons.comment_outlined,
                  ),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CommentsScreen(
                        postId: widget.snap['postId'].toString(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
