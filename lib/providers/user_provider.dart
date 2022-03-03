import 'package:flutter/widgets.dart';
import 'package:paws_app/models/user.dart';
import 'package:paws_app/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User? get getUser => _user;

  Future<void> refreshUser() async {
    _user = await _authMethods.getUserDetails();
  // _user = user;

    notifyListeners();
  }
}

/*
*
*  Dogs and Cats can be friends., username: amtmindia, likes: [], postId: ab372590-9408-11ec-9d5e-a780cfce6f4d, profImage: https://firebasestorage.googleapis.com/v0/b/paws-app-1.appspot.com/o/profilePics%2F0lOwm0pS2lTZQqfpVZhb9yrvLel1%2Ff7ede380-9406-11ec-8017-553491a96b27?alt=media&token=dea952de-ab4b-4346-a4af-d6b2bef8feed, uid: 0lOwm0pS2lTZQqfpVZhb9yrvLel1, postUrl: https://firebasestorage.googleapis.com/v0/b/paws-app-1.appspot.com/o/posts%2F0lOwm0pS2lTZQqfpVZhb9yrvLel1%2Fa8104310-9408-11ec-9d5e-a780cfce6f4d?alt=media&token=47d6dd84-0c44-45b5-94f7-0dc0235ad161}
* */