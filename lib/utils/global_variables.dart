import 'package:flutter/material.dart';
//screen imports
import '../screens/profile_screen.dart';
import '../screens/search_screen.dart';
import '../screens/add_post_screen.dart';
import '../screens/feed_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  Text('fav'),
  ProfileScreen(),
];
