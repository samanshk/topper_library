import 'sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController name = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController number = TextEditingController();

  TextEditingController password = TextEditingController();

  bool verified = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseReference dbRef = FirebaseDatabase.instance.reference();

  String msg = '';

  signUp() async {
    if (!email.text.contains('@') || password.text.length < 6 || email.text.length == 0 || password.text.length == 0) {
      setState(() {
        msg = 'Invalid email or password';
      });
      return;
    }
    else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text
        ).then((value)  {
          createUser();
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          msg = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          msg = 'The account already exists for that email.';
        }
        setState(() {
          msg = msg;
        });
        warning(context);
      } catch (e) {
        warning(context);
      }
    }
  }

  createUser() async {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    User user = await _auth.currentUser;
    var uid = user.uid;
    List<int> scores = [0,];
    var userData = {
      'name': name.text,
      'gender': '',
      'dob': '',
      'fatherName': '',
      'address': '',
      'mobile': number.text,
      'email': email.text,
      'qualification': '',
      'id_type': '',
      'id_num': '' ,
      'img': '',
      'days': 0
    };

    ref.child(uid).set(userData).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SignIn()));
    });
  }

  warning(BuildContext context) {
    showDialog(
      context: context,
      builder: (_)  {
        return AlertDialog(
          title: Text(msg),
        );
      }
    );
  }

  Widget forms(BuildContext context, String text, TextEditingController control) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 14),
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
        height: h,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background2.png'), fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: h / 8,
                ),
                Text(
                  'logo',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: h / 24,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Create Account',
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                ),
                forms(context, 'User Name', name),
                forms(context, 'Your Email Address', email),
                forms(context, 'Mobile Number', number),
                forms(context, 'Password', password),
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 24),
                    height: h / 12,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      color: Color(0xff0e427b),
                    ),
                    child: Center(
                        child: Text(
                      "Sign Up",
                      style: Theme.of(context).textTheme.caption,
                    )), // button text
                  ),
                  onTap: () {
                    signUp();
                  },
//                  onTap: () async {
//                    try {
//                      var x = await _auth.createUserWithEmailAndPassword(
//                          email: email, password: password);
//                      if (x != null) {
//                        var user = await _auth.currentUser();
////                      await user.sendEmailVerification();
//                        await _firestore
//                            .collection('users')
//                            .document(user.uid)
//                            .setData({
//                          'name': name,
//                          'mobile': mobile,
//                        });
////                                          Navigator.push(
////                        context, MaterialPageRoute(builder: (_) => ()));
//                        print(user.uid);
//                        print(user.email);
//                      }
//                    } catch (e) {
//                      print('ERROR: ');
//                      print(e);
//                    }
//                    _verify(context);
//                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Already have an account?',
                      style: Theme.of(context).textTheme.body1,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => SignIn()));
                      },
                      child: Text(
                        ' Login',
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
