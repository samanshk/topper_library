import 'package:flutter/material.dart';
import 'package:topper/register.dart';
import 'package:topper/sign_in.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/homeBackground.png'),
                fit: BoxFit.fill)),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: h / 5,
            ),
            Text(
              'logo',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.all(32),
              width: w / 1.7,
              height: h / 14,
              child: RaisedButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => SignIn()));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                child: Text('Sign In',
                    style: TextStyle(fontSize: 32, color: Colors.grey)),
              ),
            ),
            Container(
              margin: EdgeInsets.all(32),
              width: w / 1.7,
              height: h / 14,
              child: RaisedButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => Register()));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                child: Text('Register',
                    style: TextStyle(fontSize: 32, color: Colors.grey)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
