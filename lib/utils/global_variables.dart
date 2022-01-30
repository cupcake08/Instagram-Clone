import 'package:flutter/material.dart';
import 'package:instagram_flutter/screens/search_screen.dart';

//screens import
import '../screens/add_post_screen.dart';
import '../screens/feed_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  Text('fav'),
  Text('account'),
];
