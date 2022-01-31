import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//screen imports
import '../screens/profile_screen.dart';
import '../screens/search_screen.dart';
import '../screens/add_post_screen.dart';
import '../screens/feed_screen.dart';

const webScreenSize = 600;

var homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Text('fav'),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
