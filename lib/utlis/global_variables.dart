import 'package:flutter/material.dart';
import 'package:instagram_clone/Screens/profile_screen.dart';
import 'package:instagram_clone/Screens/add_post_screen.dart';
import 'package:instagram_clone/Screens/feed_screen.dart';
import 'package:instagram_clone/Screens/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

const webScreenSize = 600;
List<Widget> homeScreenitems = [
  FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  Text("Notif"),
  AccountScreeen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
