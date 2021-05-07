import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_application/auth/login.dart';
import 'package:travel_application/components/navigation.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _username, _email, _password;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Navigation()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
  }

  signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email.trim(), password: _password);
        if (user != null) {
          // UserUpdateInfo updateuser = UserUpdateInfo();
          // updateuser.displayName = _name;
          //  user.updateProfile(updateuser);
          await _auth.currentUser.updateProfile(displayName: _username);
          // await Navigator.pushReplacementNamed(context,"/") ;

        }
      } on FirebaseAuthException catch (e) {
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

  navigateToSignIn() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
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
                            if (input.isEmpty) return 'Enter Username';
                          },
                          decoration: InputDecoration(
                            labelText: 'Username',
                            focusColor: Color(0xff007580),
                            prefixIcon: Icon(Icons.person),
                          ),
                          onSaved: (input) => _username = input),
                    ),
                    Container(
                      child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) return 'Enter Email';
                          },
                          decoration: InputDecoration(
                            labelText: 'Email',
                            focusColor: Color(0xff007580),
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
                              focusColor: Color(0xff007580),
                              prefixIcon: Icon(Icons.lock_rounded)),
                          obscureText: true,
                          onSaved: (input) => _password = input),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    RaisedButton(
                      padding: EdgeInsets.fromLTRB(100, 15, 100, 15),
                      onPressed: signUp,
                      color: Color(0xff001027),
                      child: Text(
                        'SIGNUP',
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
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Already Have Account??',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        InkWell(
                          onTap: navigateToSignIn,
                          child: Text(
                            'LogIn',
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
            )
          ],
        ),
      ),
    );
  }
}
