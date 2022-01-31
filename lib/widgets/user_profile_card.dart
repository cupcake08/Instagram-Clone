import 'package:flutter/material.dart';
// import '../models/user.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
    required this.followers,
    required this.following,
    required this.postLen,
    this.bio,
    required this.username,
    required this.profilePhotoUrl,
  }) : super(key: key);

  final int followers;
  final int following;
  final int postLen;
  final String? bio;
  final String username;
  final String profilePhotoUrl;

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
                  backgroundImage: NetworkImage(profilePhotoUrl),
                  radius: 40,
                ),
                Column(
                  children: [
                    _top(postLen, FontWeight.bold),
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
                      _top(followers, FontWeight.bold),
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
                      _top(following, FontWeight.bold),
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
              username,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          if (bio != null)
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                top: 8,
              ),
              child: Text(bio as String),
            ),
        ],
      ),
    );
  }
}
