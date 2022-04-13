import 'package:cloud_firestore/cloud_firestore.dart';

class eposte{
  final String description;
  final String uid;
  final String username;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String location;

  const eposte(
      {required this.description,
        required this.uid,
        required this.username,
        required this.postId,
        required this.datePublished,
        required this.postUrl,
        required this.location,
      });

  static eposte fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return eposte(
        description: snapshot["description"],
        uid: snapshot["uid"],
        postId: snapshot["postId"],
        datePublished: snapshot["datePublished"],
        username: snapshot["username"],
        postUrl: snapshot['postUrl'],
        location: snapshot["location"],
    );
  }

  Map<String, dynamic> toJson() => {
    "description": description,
    "uid": uid,
    "username": username,
    "postId": postId,
    "datePublished": datePublished,
    'postUrl': postUrl,
    "location": location,
  };
}
