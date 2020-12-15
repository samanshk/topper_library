import 'package:flutter/material.dart';
import 'package:topper/payment_done.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';


class Plans extends StatefulWidget {
  @override
  _PlansState createState() => _PlansState();
}

class _PlansState extends State<Plans> {

  Razorpay _razorpay;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseReference dbRef = FirebaseDatabase.instance.reference();

  int addedDays = 0;

  updateData() async {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    User user = await _auth.currentUser;
    var uid = user.uid;
    var days_left = await ref.child(uid).child('days').once();
    print((days_left.value).runtimeType);

    
    ref.child(uid).child('days').set(days_left.value + addedDays).then((value) {
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SignIn()));
      print('done');
    });
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

     void openCheckout() async {
        var options = {
          'key': 'rzp_test_1DP5mmOlF5G5ag',
          'amount': 2000,
          'name': 'Acme Corp.',
          'description': 'Fine T-Shirt',
          'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
          'external': {
            'wallets': ['paytm']
          }
        };

        try {
          _razorpay.open(options);
        } catch (e) {
          debugPrint(e);
        }
      }

      void _handlePaymentSuccess(PaymentSuccessResponse response) {
        // Fluttertoast.showToast(
        //     msg: "SUCCESS: " + response.paymentId, timeInSecForIos: 4);
        updateData();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => PaymentDone()));
      }

      void _handlePaymentError(PaymentFailureResponse response) {
        Fluttertoast.showToast(
            msg: "ERROR: " + response.code.toString() + " - " + response.message,
            timeInSecForIosWeb: 4);
      }

      void _handleExternalWallet(ExternalWalletResponse response) {
        Fluttertoast.showToast(
            msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
      }


  Widget cards(BuildContext context, String duration, String number, int days) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Text(
                duration,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                number,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  setState(() {
                    addedDays = days;
                  });
                  openCheckout();
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (_) => PaymentDone()));

                },
                child: Text(
                  'Join Now',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Select Plans'),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/background1.png'), fit: BoxFit.fill),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 8,
              ),
              cards(context, 'Monthly  30 Days', '1500', 30),
              cards(context, '3 Months  90 Days', '4000', 90),
              cards(context, '6 Months', '8000', 180),
              cards(context, '12 Months', '16000', 365),
            ],
          ),
        ),
      ),
    );
  }
}
