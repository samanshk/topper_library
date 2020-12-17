import 'package:flutter/material.dart';
import 'package:share/share.dart';

class Refer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('logo'),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.grey,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Refer',
                  style: TextStyle(color: Colors.grey, fontSize: 30),
                ),
              ),
              Card(
                elevation: 16,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'images/loginImage.png',
                          height: 100,
                          width: 100,
                        ),
                      ),
                      Text(
                        'Your personal referral URL is',
                        style: TextStyle(color: Colors.grey, fontSize: 22),
                      ),
                      Text(
                        'Your URL\n',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        'Anyone you refer using this link(aka URL) will get connected to you and earn money.\n',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Refer via',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Share.share('https://drive.google.com/file/d/1cTa_24bVIFm5ShPDV4DmD_PdXJAgFWFT/view?usp=sharing'),
                        child: GridView.count(
                          crossAxisCount: 4,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 25,
                          padding: EdgeInsets.all(16),
                          childAspectRatio: 2,
                          children: <Widget>[
                            Image.asset('images/mail.png', height: 10, width: 10,),
                            Image.asset('images/profile.png', height: 10,),
                            Image.asset('images/facbook.png', height: 10,),
                            Image.asset('images/twitter.png', height: 10,),
                            Image.asset('images/google.png', height: 10,),
                            Image.asset('images/linkedin.png', height: 10,),
                            Image.asset('images/whatsup.png', height: 10,),
                            Image.asset('images/pin.png', height: 10,),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
