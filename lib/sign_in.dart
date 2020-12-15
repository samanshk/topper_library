import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:topper/reset_password.dart';

import 'dashboard.dart';
import 'home.dart';
import 'home.dart';
import 'library.dart';
import 'register.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool enable = true;
  bool warn = false;

  signIn() async {

    if (email.text != '' && password.text != '') {
      setState(() {
        enable = false;
      });
      try {
        final myUser = await _auth.signInWithEmailAndPassword(email: email.text, password: password.text)
        .then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Library())));
        print(myUser.user.email);  
      } catch (e) {
        print(e);
        setState(() {
          enable = true;
          warn = true;
        });
        warning(context);
      }  
    }
  }



  warning(BuildContext context) {
    showDialog(
      context: context,
      builder: (_)  {
        return AlertDialog(
          title: Text(
            'Incorrect username or password',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20
            ),
          ),
        );
      }
    );
  }

  bool loginSuccess = false;

  Widget forms(BuildContext context, String text, TextEditingController setValue) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 14),
      child: TextField(
        // onChanged: (val) {
        //   setValue = val;
        // },
        controller: setValue,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          hintText: text,
          hintStyle: Theme.of(context).textTheme.body1,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: h / 12,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'logo',
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                SizedBox(
                  height: h / 12,
                ),
                forms(context, 'Your Email Address', email),
                forms(context, 'Password', password),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassword()));},
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Color(0xff0e427b),
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                        )
                      ),
                    )
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    signIn();
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => Library()));
                  },
                  child: Container(
                    height: h / 12,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      color: Color(0xff0e427b),
                    ),
                    child: Center(
                        child: Text(
                      "Login",
                      style: Theme.of(context).textTheme.caption,
                    )), // button text
                  ),
//                onTap: () async {
//                  try {
//                    var x = await _auth.signInWithEmailAndPassword(
//                        email: email, password: password);
//                    if (x != null) {
//                      var user = await _auth.currentUser();
////                      await user.sendEmailVerification();
////                        await _firestore
////                            .collection('users')
////                            .document(user.uid)
////                            .setData({
////                          'name': name,
////                          'mobile': mobile,
////                        });
//                      userId = user.uid;
//                      userName = user.email;
//                    }
//                  } catch (e) {
//                    print('ERROR: ');
//                    print(e);
//                  }
//                  if (userId != null) {
//                    Navigator.pushReplacement(
//                        context, MaterialPageRoute(builder: (_) => SignIn()));
//                  } else {
//                    Navigator.pop(context);
//                    showDialog(
//                        context: context,
//                        builder: (_) {
//                          return SimpleDialog(
//                            title: Text(
//                              'Login error!',
//                              style: Theme.of(context).textTheme.subtitle,
//                            ),
//                          );
//                        });
//                  }
//
//                  Navigator.pushReplacement(
//                      context, MaterialPageRoute(builder: (_) => HomePage()));
//                },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Don\'t have an account? ',
                        style: Theme.of(context).textTheme.body1,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => Register()));
                        },
                        child: Text(
                          ' Sign Up',
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset('images/loginImage.png'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
