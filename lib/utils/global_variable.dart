import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paws_app/screens/add_post_screen.dart';
import 'package:paws_app/screens/emergency_screen.dart';
import 'package:paws_app/screens/feed_screen.dart';
import 'package:paws_app/screens/profile_screen.dart';
import 'package:paws_app/screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const EmergencyScreen(),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
