import 'package:flutter/material.dart';
import '../models/user.dart';

class UserCard extends StatelessWidget {
  const UserCard({Key? key, required this.user}) : super(key: key);

  final User user;

  Widget _top(int value, FontWeight weight) {
    return Text(
      '$value',
      style: TextStyle(
        fontWeight: weight,
        fontSize: 18,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(user.photoUrl),
                  radius: 40,
                ),
                Column(
                  children: [
                    _top(0, FontWeight.bold),
                    const Text(
                      'Posts',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: Column(
                    children: [
                      _top(user.followers.length, FontWeight.bold),
                      const Text(
                        'Followers',
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  style: TextButton.styleFrom(primary: Colors.white),
                ),
                TextButton(
                  onPressed: () {},
                  child: Column(
                    children: [
                      _top(user.following.length, FontWeight.bold),
                      const Text(
                        'Following',
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  style: TextButton.styleFrom(primary: Colors.white),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
            ),
            child: Text(
              user.username,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              top: 8,
            ),
            child: Text(user.bio),
          ),
        ],
      ),
    );
  }
}
