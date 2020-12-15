import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:topper/my_drawer.dart';
import 'package:topper/plans.dart';
import 'package:topper/total_days.dart';

import 'models/feature_model.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {


  final FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseReference dbRef = FirebaseDatabase.instance.reference();

  int days = 0;

  getData() async {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    User user = await _auth.currentUser;
    var uid = user.uid;
    var days_left = await ref.child(uid).child('days').once();
    print((days_left.value).runtimeType);
    setState(() {
      days = days_left.value;
    });
  }

  // initState() {
  //   @override
  //   initState();
  // }

  Widget cards(BuildContext context, FeatureModel object) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => TotalDays()));
      },
      child: Material(
        elevation: 8,
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: GridTile(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    object.imgPath,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AutoSizeText(
                    object.label,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(34),
        child: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Dashboard',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'Name(place)',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      drawer: MyDrawer(),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/background33.png'),
                    fit: BoxFit.fill)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 18,
                    ),
                    Card(
                      elevation: 16,
                      margin: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: MediaQuery.of(context).size.width / 16,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 32.0),
                        child: AutoSizeText(
                          'Membership Id: \n\nSeat No Library: ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Material(
                        color: Colors.white,
                        elevation: 16,
                        borderRadius: BorderRadius.circular(16),
                        child: ListTile(
                          leading: Image.asset('images/calender.png', width: 40,),
                          title: Text(
                            'Exp Date- ',
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          trailing: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Plans()));
                            },
                            child: Text(
                              'Renew Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      children: <Widget>[
                        cards(
                            context,
                            FeatureModel(
                                'images/icon.png', 'Total Days/Hours- $days')),
                        cards(
                            context,
                            FeatureModel('images/latestUpdate.png',
                                'Latest Notification')),
                        cards(
                            context,
                            FeatureModel(
                                'images/donateBook.png', 'Donate Books')),
                      ],
                    ),
                    Card(
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AutoSizeText(
                          "You are better than 56% of people",
                          style: TextStyle(color: Colors.white),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            child: Text(
              "TL Updates",
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
            ),
            top: MediaQuery.of(context).size.height / 1.7,
            width: MediaQuery.of(context).size.width,
            left: 0,
          ),
        ],
      ),
    );
  }
}
