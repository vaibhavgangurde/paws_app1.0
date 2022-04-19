import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paws_app/resources/auth_methods.dart';
import 'package:paws_app/responsive/mobile_screen_layout.dart';
import 'package:paws_app/responsive/responsive_layout.dart';
import 'package:paws_app/responsive/web_screen_layout.dart';
import 'package:paws_app/screens/login_screen.dart';
import 'package:paws_app/screens/uniqueidngo.dart';
import 'package:paws_app/utils/colors.dart';
import 'package:paws_app/utils/global_variable.dart';
import 'package:paws_app/utils/utils.dart';
import 'package:paws_app/widgets/text_field_input.dart';




class ngo extends StatefulWidget {
  const ngo({Key? key}) : super(key: key);

  @override
  _ngoState createState() => _ngoState();
}

class _ngoState extends State<ngo> {
  final TextEditingController _ngonameController = TextEditingController();
  final TextEditingController _ngoemailController = TextEditingController();
  final TextEditingController _ngopasswordController = TextEditingController();
  final TextEditingController _ngobioController = TextEditingController();
  bool _isLoading = false;
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _ngoemailController.dispose();
    _ngopasswordController.dispose();
    _ngonameController.dispose();
  }

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our authmethodds
    String res = await AuthMethods().signUpUser(
        email: _ngoemailController.text,
        password: _ngopasswordController.text,
        username: _ngonameController.text,
        bio: _ngobioController.text,
        file: _image!);
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      var actionCodeSettings = ActionCodeSettings(
        url: 'https://www.example.com/?email=${user.email}',
        dynamicLinkDomain: 'example.page.link',
        androidPackageName: 'com.example.android',
        androidInstallApp: true,
        androidMinimumVersion: '6',
        iOSBundleId: 'com.example.ios',
        handleCodeInApp: true,
      );

      await user.sendEmailVerification(actionCodeSettings);
    }
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ngouniqueid()
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
        Navigator.of(context).push(
            MaterialPageRoute(
            builder: (context) => const ngouniqueid()));
      });
      // show the error
      showSnackBar(context, res);
    }
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
        child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
    width: double.infinity,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    Flexible(
    child: Container(),
    flex: 2,
    ),
    SvgPicture.asset(
    'assets/ic_paws_app.svg',
    color: primaryColor,
    height: 64,
    ),
    const SizedBox(
    height: 64,
    ),
    Stack(
    children: [
    _image != null
    ? CircleAvatar(
    radius: 64,
    backgroundImage: MemoryImage(_image!),
    backgroundColor: Colors.red,
    )
        : const CircleAvatar(
    radius: 64,
    backgroundImage: NetworkImage(
    'https://i.stack.imgur.com/l60Hf.png'),
    backgroundColor: Colors.red,
    ),
    Positioned(
    bottom: -10,
    left: 80,
    child: IconButton(
    onPressed: selectImage,
    icon: const Icon(Icons.add_a_photo),
    ),
    )
    ],
    ),
    const SizedBox(
    height: 10,
    ),
    TextFieldInput(
    hintText: 'Enter your NGO name',
    textInputType: TextInputType.text,
    textEditingController: _ngonameController,
    ),
    const SizedBox(
    height: 24,
    ),
    TextFieldInput(
    hintText: 'Enter your email',
    textInputType: TextInputType.emailAddress,
    textEditingController: _ngoemailController,
    ),
    const SizedBox(
    height: 24,
    ),
    TextFieldInput(
    hintText: 'Enter your password',
    textInputType: TextInputType.text,
    textEditingController: _ngopasswordController,
    isPass: true,
    ),
    const SizedBox(
    height: 24,
    ),
    TextFieldInput(
    hintText: 'Enter your bio',
    textInputType: TextInputType.text,
    textEditingController: _ngobioController,
    ),
    const SizedBox(
    height: 24,
    ),
    InkWell(
    child: Container(
    child: !_isLoading
    ? const Text(
    'Sign up',
    )
        : const CircularProgressIndicator(
    color: primaryColor,
    ),
    width: double.infinity,
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(vertical: 12),
    decoration: const ShapeDecoration(
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
    color: blueColor,
    ),
    ),
    onTap: signUpUser,
    ),
    //   const SizedBox(
    //   height: 1,
    //),
    Flexible(
    child: Container(),
    flex: 2,
    ), ],),),),  );
  }
}