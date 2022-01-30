import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/user.dart';
import 'package:instagram_flutter/providers/user_provider.dart';
import 'package:instagram_flutter/screens/login.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/widgets/user_profile_card.dart';
import 'package:provider/provider.dart';
import '../resources/auth_methods.dart';
import '../utils/utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
    final User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
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
        title: Text(user.username),
      ),
      body: Column(
        children: [
          UserCard(
            user: user,
          ),
          InkWell(
            onTap: () {},
            // child: const Text('Edit Profile'),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 5,
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 30,
              // transformAlignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(color: primaryColor),
                  borderRadius: BorderRadius.circular(6)),
              child: const Text(
                'Edit Profile',
              ),
              alignment: Alignment.center,
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
