import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:topper/sign_in.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  // String email, password, userId, userName;
  TextEditingController email = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  reset() async {
    String usrEmail = await _auth.currentUser.email;
    if (email.text == usrEmail) {
      await _auth.sendPasswordResetEmail(email: usrEmail).then((value) {
        Navigator.pop(context);
      });  
    }  
  }

  bool loginSuccess = false;

  Widget forms(BuildContext context, String text, TextEditingController control) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        // onChanged: (val) {
        //   setValue = val;
        // },
        controller: control,
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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.png'), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: h / 12,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    'logo',
                    style: TextStyle(fontSize: 40, color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Reset Password',
                    style: Theme.of(context)
                        .textTheme
                        .headline
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                forms(context, 'Email', email),
                // forms(context, 'Enter New Password', password),
                // forms(context, 'Again Enter New Password', password),
                GestureDetector(
                  child: Container(
                    height: h / 15,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Color(0xff0e427b),
                    ),
                    child: Center(
                        child: Text(
                      "Continue",
                      style: Theme.of(context).textTheme.caption,
                    )), // button text
                  ),
                  onTap: reset,
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
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Password reset link will be sent to your email id.',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.bold))),
                ),
                Padding(padding: EdgeInsets.all(20))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
