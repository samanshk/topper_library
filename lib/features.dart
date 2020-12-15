import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:topper/my_drawer.dart';
import 'package:topper/plans.dart';

import 'models/feature_model.dart';

class Features extends StatelessWidget {
  Widget cards(BuildContext context, FeatureModel object) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: GridTile(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Image.asset(
                object.imgPath,
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              flex: 1,
              child: AutoSizeText(
                object.label,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<FeatureModel> features = [
    FeatureModel('images/airPollution.png', 'Air Pollution Control'),
    FeatureModel('images/airConditioner.png', 'Airconditional Ambience'),
    FeatureModel('images/completeSecurity.png', 'Complete Security'),
    FeatureModel('images/fire.png', 'Fire Safety'),
    FeatureModel('images/highSpeed.png', 'High Speed Fibernet'),
    FeatureModel('images/hygeen.png', 'Hygienic Washrooms'),
    FeatureModel('images/inOut.png', 'In and Out Biometric'),
    FeatureModel('images/noise.png', 'Noise Cancellation'),
    FeatureModel('images/performance.png', 'Performance Approval'),
    FeatureModel('images/looker.png', 'Seperate Locker'),
    FeatureModel('images/water.png', 'Water cooler and purifier'),
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
                'Features',
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
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background2.png'), fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 8,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.width / 16,
                  ),
                  elevation: 16,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: AutoSizeText(
                          'Seats Available',
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Image.asset(
                          'images/seat.png',
                          height: 40,
                          width: 40,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(16),
                                bottomRight: Radius.circular(16)),
                            color: Theme.of(context).primaryColor,
                          ),
                          alignment: Alignment.center,
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                          child: Text(
                            '25',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: features.length,
                  itemBuilder: (context, i) {
                    return cards(context, features[i]);
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: MediaQuery.of(context).size.height / 8),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => Plans()));
                    },
                    child: Text(
                      'View Plan',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
