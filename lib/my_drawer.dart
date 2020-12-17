import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:topper/dashboard.dart';
import 'package:topper/home.dart';
import 'package:topper/plans.dart';
import 'package:topper/profile.dart';
import 'package:topper/refer.dart';
import 'package:topper/reset_password.dart';
import 'package:topper/share.dart';

import 'library.dart';

class MyDrawer extends StatelessWidget {
  Widget ops(BuildContext context, String imgPath, String label, Widget page) {
    return ListTile(
      leading: Image.asset(
        imgPath,
        width: 40,
        height: 40,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),
        // maxLines: 1,
        // fontSize: 10,
      ),
      onTap: () async {
        if(label != 'Log Out')
          Navigator.push(context, MaterialPageRoute(builder: (_) => page));
        else {
          await FirebaseAuth.instance.signOut().then((value) => 
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => page), ModalRoute.withName('/'))
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      width: MediaQuery.of(context).size.width / 1.6,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/background2.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 32,
            ),
            Text(
              'Toppers Library',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Image.asset(
                'images/drawerIcons/11.png',
                fit: BoxFit.fill,
                scale: 3,
              ),
            ),
            Text(
              '  Name\nAddress',
              style: TextStyle(color: Colors.black),
            ),
            ops(context, 'images/dashboard.png', 'Dashboard', Dashboard()),
            ops(context, 'images/drawerIcons/2.png', 'Profile', Profile()),
            ops(context, 'images/drawerIcons/1.png', 'Attendance', Dashboard()),
            ops(context, 'images/drawerIcons/3.png', 'Search Library',
                Library()),
            ops(context, 'images/drawerIcons/4.png', 'View Plan', Plans()),
            ops(context, 'images/drawerIcons/5.png', 'Transaction Details',
                Dashboard()),
            ops(context, 'images/drawerIcons/10.png', 'Practice', Dashboard()),
            ops(context, 'images/drawerIcons/6.png', 'Terms and Conditions',
                Dashboard()),
            ops(context, 'images/exe.png', 'Refer', Refer()),
            ops(context, 'images/drawerIcons/7.png', 'Share', ShareScreen()),
            ops(context, 'images/drawerIcons/8.png', 'Reset Password',
                ResetPassword()),
            ops(context, 'images/drawerIcons/9.png', 'Log Out', Home()),
          ],
        ),
      )),
    );
  }
}
