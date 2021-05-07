import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:travel_application/auth/login.dart';
import 'package:travel_application/auth/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travel_application/components/navigation.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  //google sign in authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> googleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        final UserCredential user =
            await _auth.signInWithCredential(credential);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Navigation()));

        return user;
      } else {
        throw StateError('Missing Google Auth Token');
      }
    } else
      throw StateError('Sign in Aborted');
  }

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Navigation()));
      }
    });
  }

  navigateToLogin() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  navigateToSignUp() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.checkAuthentification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 400.0,
              padding: EdgeInsets.fromLTRB(20.0, 80.0, 20.0, 30.0),
              child: Image(
                image: AssetImage("images/home_page.jpg"),
                fit: BoxFit.contain,
              ),
            ),
            //text container
            Container(
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'WELCOME TO                       ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Color(0xff001027),
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' "TRAVEL MATE"',
                      style: TextStyle(
                        fontSize: 43,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff007580),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 5.0),
              child: Text(
                'Discover new places and explore with us!!',
                style: TextStyle(
                  color: Color(0xff000000),
                  fontSize: 20.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 80.0,
            ),
            //button
            Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // ignore: deprecated_member_use
                    RaisedButton(
                      padding: EdgeInsets.only(
                          left: 55.0, right: 55.0, top: 10.0, bottom: 10.0),
                      onPressed: navigateToLogin,
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xffffe8d0),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Color(0xff001027),
                    ),
                    SizedBox(
                      width: 35.0,
                    ),
                    RaisedButton(
                      padding: EdgeInsets.only(
                          left: 40.0, right: 40.0, top: 10.0, bottom: 10.0),
                      onPressed: navigateToSignUp,
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xffffe8d0),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Color(0xff001027),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),

            Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  SignInButton(
                    Buttons.Google,
                    text: "Sign up with Google",
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: googleSignIn,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
