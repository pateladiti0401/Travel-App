import 'package:flutter/material.dart';
import 'package:travel_application/components/app_bar.dart';
import 'package:travel_application/components/drawer.dart';
import 'package:travel_application/components/profile_pic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isloggedIn = false;
  User user;

  //check getuser
  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedIn = true;
      });
    }
  }

  signOut() async {
    _auth.signOut();

    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("User Page"),
      drawer: DrawerScreen(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfilePic(),
            SizedBox(height: 20),
            Text(
              'Username: ${user.displayName[0].toUpperCase() + user.displayName.substring(1)}',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Email: ${user.email}.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 20),
            Container(
              // ignore: deprecated_member_use
              child: FlatButton(
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Color(0xFFF5F6F9),
                onPressed: () {},
                child: Row(
                  children: [
                    Container(
                      child: FaIcon(FontAwesomeIcons.userAlt),
                    ),
                    SizedBox(width: 20),
                    Expanded(child: Text('My Account')),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              // ignore: deprecated_member_use
              child: FlatButton(
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Color(0xFFF5F6F9),
                onPressed: () {},
                child: Row(
                  children: [
                    Container(
                      child: FaIcon(FontAwesomeIcons.bell),
                    ),
                    SizedBox(width: 20),
                    Expanded(child: Text('Notifications')),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              // ignore: deprecated_member_use
              child: FlatButton(
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Color(0xFFF5F6F9),
                onPressed: () {},
                child: Row(
                  children: [
                    Container(
                      child: FaIcon(FontAwesomeIcons.cog),
                    ),
                    SizedBox(width: 20),
                    Expanded(child: Text('Settings')),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              // ignore: deprecated_member_use
              child: FlatButton(
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Color(0xFFF5F6F9),
                onPressed: () {},
                child: Row(
                  children: [
                    Container(
                      child: FaIcon(FontAwesomeIcons.questionCircle),
                    ),
                    SizedBox(width: 20),
                    Expanded(child: Text('Help Center')),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              // ignore: deprecated_member_use
              child: FlatButton(
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Color(0xFFF5F6F9),
                onPressed: signOut,
                child: Row(
                  children: [
                    Container(
                      child: FaIcon(FontAwesomeIcons.signOutAlt),
                    ),
                    SizedBox(width: 20),
                    Expanded(child: Text('Logout')),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
