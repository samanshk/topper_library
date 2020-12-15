import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:topper/my_drawer.dart';

import 'features.dart';

class Library extends StatelessWidget {
  Widget cards(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: ListTile(
          leading: Image.asset('images/locatiion1.png'),
          title: AutoSizeText(
            label,
            maxLines: 1,
          ),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => Features()));
          },
        ),
      ),
    );
  }

  List<String> locations = [
    "Library 1-NEW DELHI(10 km)",
    "Library 1-NEW DELHI(10 km)",
    "Library 1-NEW DELHI(10 km)",
    "Library 1-NEW DELHI(10 km)",
    "Library 1-NEW DELHI(10 km)",
    "Lajpat Nagar(20 km)",
    "Laxmi Nagar-NEW DELHI(10 km)",
  ];

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
                'Search Library',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
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
      body: Container(
//        height: MediaQuery.of(context).size.height,
//        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background3.png'), fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 6,
                ),
                Material(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(16),
                  child: ListTile(
                    leading: Image.asset('images/location.png'),
                    title: Text(
                      'Present Address',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    trailing: RaisedButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: () {},
                      child: Text(
                        'Change\nLocation',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 4,
                    vertical: MediaQuery.of(context).size.width / 16,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 32, horizontal: 16.0),
                    child: AutoSizeText(
                      'List of Library',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: locations.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Features())),
                      child: cards(
                        context, 
                        locations[i]
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
