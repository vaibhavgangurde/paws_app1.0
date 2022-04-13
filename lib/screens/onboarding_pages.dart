// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:introduction_screen/introduction_screen.dart';
// import 'package:paws_app/screens/login_screen.dart';
// import 'package:paws_app/screens/signup_screen.dart';

// class App extends StatelessWidget {
//   const App({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//       SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
//     );

//     return MaterialApp(
//       title: 'Introduction screen',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const OnBoardingPages(),
//     );
//   }
// }

// class OnBoardingPages extends StatefulWidget {
//   const OnBoardingPages({Key? key}) : super(key: key);

//   @override
//   _OnBoardingPagesState createState() => _OnBoardingPagesState();
// }

// class _OnBoardingPagesState extends State<OnBoardingPages> {
//   final introKey = GlobalKey<IntroductionScreenState>();

//   void _onIntroEnd(context) {
//     Navigator.of(context).push(
//       MaterialPageRoute(builder: (_) => const HomePage()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     const bodyStyle = TextStyle(fontSize: 18.0);

// const pageDecoration = PageDecoration(
//   titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
//   bodyTextStyle: bodyStyle,
//   descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
//   pageColor: Colors.white,
//   imagePadding: EdgeInsets.zero,
// );

//     return IntroductionScreen(
//       key: introKey,
//       globalBackgroundColor: Colors.white,
//       pages: [
//         PageViewModel(
// title: "Welcome to Paws",
// body: "Dicover buddies around you, Connect with their Owners!",
// image: Image.asset(
//   'assets/onb_screen_img1.png',
//   height: 400,
//   width: MediaQuery.of(context).size.width,
//   fit: BoxFit.cover,
//           ),
//           decoration: pageDecoration,
//         ),
//         PageViewModel(
// title: "Bring a buddy home",
// body: "Adopt or own a buddy at home! You can made easy to someone",
// image: Image.asset(
//   'assets/onb_screen_img2.png',
//   width: MediaQuery.of(context).size.width,
//   height: 400.00,
//   fit: BoxFit.cover,
//           ),
//           decoration: pageDecoration,
//         ),
//         PageViewModel(
//           title: "Your buddy's care",
//           body:
//               "100+Vets, Trainers, Groomers, Sitters, Organizations, Hotels and more",
//           image: Image.asset(
//             'assets/onb_screen_img3.png',
//             width: MediaQuery.of(context).size.width,
//             height: 400.00,
//             fit: BoxFit.cover,
//           ),
//           decoration: pageDecoration,
//         ),
//       ],
//       onDone: () => _onIntroEnd(context),
//       showSkipButton: true,
//       skipFlex: 0,
//       nextFlex: 0,
//       skip: const Text('Skip'),
//       next: const Icon(Icons.arrow_forward),
//       done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
//       curve: Curves.fastLinearToSlowEaseIn,
//       controlsMargin: const EdgeInsets.all(16),
//       controlsPadding: kIsWeb
//           ? const EdgeInsets.all(12.0)
//           : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
//       dotsDecorator: const DotsDecorator(
//         size: Size(10.0, 10.0),
//         color: Color(0xFFBDBDBD),
//         activeSize: Size(22.0, 10.0),
//         activeShape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(25.0)),
//         ),
//       ),
//       dotsContainerDecorator: const ShapeDecoration(
//         color: Colors.transparent,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(8.0)),
//         ),
//       ),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             color: Colors.blueGrey,
//             child: Image.asset(
//               "assets/onb_screen_img4.png",
//               width: MediaQuery.of(context).size.width,
//               height: 400.00,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 300),
//             child: Container(
//               height: MediaQuery.of(context).size.height,
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//               ),
//               child: Column(
//                 children: [
//                   const SizedBox(
//                     height: 35.0,
//                   ),
//                   const Text(
//                     "Your Social feeds",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 28.0,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 30.0,
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
//                     child: Text(
//                       "social networking app for all pets & pet owners.",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 18.0,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 60.0,
//                   ),
//                   ElevatedButton(
//                     onPressed: () => {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const SignupScreen(),
//                         ),
//                       ),
//                     },
//                     style: ButtonStyle(
//                       shape: MaterialStateProperty.all(
//                         RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                     ),
//                     child: const Padding(
//                       padding: EdgeInsets.all(10.0),
//                       child: Text(
//                         'Get Started',
//                         style: TextStyle(fontSize: 18.0),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 15.0,
//                   ),
//                   TextButton(
//                     onPressed: () => {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const LoginScreen(),
//                         ),
//                       ),
//                     },
//                     child: const Text(
//                       'Already have an Account ? Login',
//                       style: TextStyle(fontSize: 14.0, color: Colors.black),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:paws_app/screens/login_screen.dart';
import 'package:paws_app/screens/signup_screen.dart';

class OnBoardingPages extends StatelessWidget {
  const OnBoardingPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      title: 'Introduction screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const OnBoardingPage(),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/fullscreen.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,

      pages: [
        PageViewModel(
          title: "Welcome to Paws",
          body: "Dicover buddies around you, Connect with their Owners!",
          image: Image.asset(
            'assets/onb_screen_img1.png',
            height: 400,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        ),
        PageViewModel(
          title: "Bring a buddy home",
          body: "Adopt or own a buddy at home! You can made easy to someone",
          image: Image.asset(
            'assets/onb_screen_img2.png',
            width: MediaQuery.of(context).size.width,
            height: 400.00,
            fit: BoxFit.cover,
          ),
        ),
        PageViewModel(
          title: "Your buddy's care",
          body:
              "100+Vets, Trainers, Groomers, Sitters, Organizations, Hotels and more",
          image: Image.asset(
            'assets/onb_screen_img3.png',
            width: MediaQuery.of(context).size.width,
            height: 400.00,
            fit: BoxFit.cover,
          ),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        // color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.blueGrey,
            child: Image.asset(
              "assets/onb_screen_img4.png",
              width: MediaQuery.of(context).size.width,
              height: 400.00,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 300),
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 35.0,
                  ),
                  const Text(
                    "Your Social feeds",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                    child: Text(
                      "social networking app for all pets & pet owners.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60.0,
                  ),
                  ElevatedButton(
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      ),
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Get Started',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextButton(
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      ),
                    },
                    child: const Text(
                      'Already have an Account ? Login',
                      style: TextStyle(fontSize: 14.0, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
