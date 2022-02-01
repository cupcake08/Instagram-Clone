import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../resources/firestore_methods.dart';
import '../widgets/custom_button.dart';
import '../utils/colors.dart';
import '../widgets/user_profile_card.dart';
import '../resources/auth_methods.dart';
import '../utils/utils.dart';
import './login.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int posts = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    setState(() => isLoading = true);
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      userData = userSnap.data()!;
      posts = postSnap.docs.length;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() => isLoading = false);
  }

  void logout() async {
    String res = await AuthMethods().logoutUser();
    if (res != "success") {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator.adaptive(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              actions: [
                PopupMenuButton(
                  itemBuilder: (context) => <PopupMenuEntry>[
                    PopupMenuItem(
                      child: const Text(
                        'LogOut',
                      ),
                      onTap: logout,
                    )
                  ],
                )
              ],
              title: Text(userData['username']),
            ),
            body: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Column(
                  children: [
                    UserCard(
                      followers: followers,
                      following: following,
                      username: userData['username'],
                      postLen: posts,
                      profilePhotoUrl: userData['photoUrl'],
                      bio: userData['bio'],
                    ),
                    FirebaseAuth.instance.currentUser!.uid == widget.uid
                        ? CustomButton(
                            textColor: Colors.white,
                            borderColor: Colors.grey,
                            text: "Edit Profile",
                            func: () {},
                            backgroundColor: mobileBackgroundColor,
                          )
                        : isFollowing
                            ? CustomButton(
                                textColor: Colors.black,
                                borderColor: Colors.grey,
                                text: 'UnFollow',
                                backgroundColor: Colors.white,
                                func: () async {
                                  await FirestoreMethods().following(
                                    currentUserUid:
                                        FirebaseAuth.instance.currentUser!.uid,
                                    displayUserUid: userData['uid'],
                                    context: context,
                                  );
                                  setState(() {
                                    isFollowing = false;
                                    followers--;
                                  });
                                },
                              )
                            : CustomButton(
                                textColor: Colors.white,
                                borderColor: Colors.blueAccent,
                                text: 'Follow',
                                func: () async {
                                  await FirestoreMethods().following(
                                    currentUserUid:
                                        FirebaseAuth.instance.currentUser!.uid,
                                    displayUserUid: userData['uid'],
                                    context: context,
                                  );
                                  setState(() {
                                    isFollowing = true;
                                    followers++;
                                  });
                                },
                                backgroundColor: Colors.blueAccent,
                              ),
                    const Divider(),
                    FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('posts')
                          .where(
                            'uid',
                            isEqualTo: widget.uid,
                          )
                          .get(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        }

                        return GridView.builder(
                          itemCount: snapshot.data!.docs.length,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 1.5,
                          ),
                          itemBuilder: (context, index) {
                            DocumentSnapshot doc = snapshot.data!.docs[index];
                            return SizedBox(
                              child: Image(
                                image: NetworkImage(doc['postUrl']),
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
