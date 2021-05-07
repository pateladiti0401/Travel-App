import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travel_application/screen/subScreen/heritage.dart';
import 'package:travel_application/screen/subScreen/wildlife.dart';
import 'package:travel_application/screen/subScreen/beach.dart';
import 'package:travel_application/screen/subScreen/mountain.dart';
import 'package:travel_application/screen/subScreen/museum.dart';
import 'package:travel_application/screen/subScreen/temple.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isloggedIn = false;
  User user;

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
    return SizedBox(
        child: Drawer(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          height: 250,
          child: DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal[100]),
              child: Padding(
                padding: EdgeInsets.all(6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('images/Profile Image.png'),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // Text(
                    //   user.email ?? "email",
                    //   style: TextStyle(
                    //       fontSize: 15,
                    //       fontWeight: FontWeight.w300,
                    //       color: Colors.teal[900]),
                    // ),
                  ],
                ),
              )),
        ),
        Container(
          padding: EdgeInsets.only(top: 20, left: 15, bottom: 20),
          child: Text(
            "Pick Your Trail",
            style: TextStyle(
              fontSize: 25,
              color: Color(0xff007580),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Divider(
          height: 10,
          thickness: 2,
        ),
        ListTile(
          leading: Icon(CupertinoIcons.arrowtriangle_right_fill),
          title: Text(
            "Heritage Sites",
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HeritageScreen()));
          },
        ),
        ListTile(
          leading: Icon(CupertinoIcons.arrowtriangle_right_fill),
          title: Text("Wildlife Experience"),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => WildlifeScreen()));
          },
        ),
        ListTile(
          leading: Icon(CupertinoIcons.arrowtriangle_right_fill),
          title: Text("Mountain"),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MountainScreen()));
          },
        ),
        ListTile(
          leading: Icon(CupertinoIcons.arrowtriangle_right_fill),
          title: Text("Museums"),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MuseumScreen()));
          },
        ),
        ListTile(
          leading: Icon(CupertinoIcons.arrowtriangle_right_fill),
          title: Text("Temples"),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TempleScreen()));
          },
        ),
        ListTile(
          leading: Icon(CupertinoIcons.arrowtriangle_right_fill),
          title: Text("Beaches"),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BeachScreen()));
          },
        ),
        SizedBox(
          height: 100,
        ),
        Container(
          padding: EdgeInsets.only(left: 20),
          child: GestureDetector(
            onTap: signOut,
            child: Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.signOutAlt,
                  size: 20,
                  color: Colors.black54,
                ),
                Padding(padding: EdgeInsets.only(left: 8)),
                Text(
                  'Log Out',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    )));
  }
}

// Widget drawer() {
//   return Drawer(
//     child: Container(
//       child: Column(
//         children: <Widget>[
//           Container(
//             height: 100,
//             child: DrawerHeader(
//               child: Center(
//                 child: Text(
//                   'TRAVEL MATE',
//                   style: TextStyle(),
//                 ),
//               ),
//               decoration: BoxDecoration(color: Color(0xff007580)),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
