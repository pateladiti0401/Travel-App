import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:travel_application/components/navigation.dart';
import 'package:travel_application/auth/signUp.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email, _password;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Navigation()));
      }
    });
  }

  login() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: _email.trim(), password: _password);
      } catch (e) {
        showError(e.message);
        print(e);
      }
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  navigateToSignUp() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 450.0,
              padding: EdgeInsets.fromLTRB(20.0, 80.0, 20.0, 30.0),
              child: Image(
                image: AssetImage("images/login.png"),
                fit: BoxFit.contain,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) return 'Enter Email';
                          },
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                          ),
                          onSaved: (input) => _email = input),
                    ),
                    Container(
                      child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty)
                              return 'provide Password';
                            else if (input.length < 6)
                              return 'Provide minimum 6 letters';
                          },
                          decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock_rounded)),
                          obscureText: true,
                          onSaved: (input) => _password = input),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment(1.0, 0.0),
                      child: InkWell(
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                              color: Color(0xff007580),
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    RaisedButton(
                      padding: EdgeInsets.fromLTRB(100, 15, 100, 15),
                      onPressed: login,
                      color: Color(0xff001027),
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xffffe8d0),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'New User??',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        InkWell(
                          onTap: navigateToSignUp,
                          child: Text(
                            'Register',
                            style: TextStyle(
                                color: Color(0xff007580),
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ),
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
