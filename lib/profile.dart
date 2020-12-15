import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'my_drawer.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  var name = TextEditingController();
  var gender = TextEditingController();
  var dob = TextEditingController();
  var fatherName = TextEditingController();
  var address = TextEditingController();
  var mobile = TextEditingController();
  var email = TextEditingController();
  var qualification = TextEditingController();
  var idType = TextEditingController();
  var idNum = TextEditingController();

  var days_left;
  
  DatabaseReference dbRef;
  FirebaseStorage storage = FirebaseStorage.instance;
    var user = FirebaseAuth.instance.currentUser;
    

  File _image;
  final picker = ImagePicker();

  var img_url = '';

  uploadImage() async {
    var uid = user.uid;
    var ref = storage.ref('images/$uid.jpeg');
    ref.putFile(_image);
    setState(() async {
      img_url = await ref.getDownloadURL();      
    });
  }

  getUserData() async {
    var uid = user.uid;
    // List<dynamic> sortedScores;
    DatabaseReference ref = FirebaseDatabase.instance.reference();

    await ref.child(uid).once().then((data) {
      // print(data.value[1].toString());
      setState(() {
        name.text = data.value['name'];
        gender.text = data.value['gender'];
        dob.text = data.value['dob'];
        fatherName.text = data.value['fatherName'];
        address.text = data.value['address'];
        mobile.text = data.value['mobile'];
        email.text = data.value['email'];
        qualification.text = data.value['qualification'];
        idType.text = data.value['id_type'];
        idNum.text = data.value['id_num'];
        img_url = data.value['img'];
        days_left = data.value['days'];
      });
    });
  }

  setUserData() async {
    var user = await FirebaseAuth.instance.currentUser;
    var uid = user.uid;
    DatabaseReference ref = FirebaseDatabase.instance.reference();
  
    var userData = {
      'name': name.text,
      'gender': gender.text,
      'dob': dob.text,
      'fatherName': fatherName.text,
      'address': address.text,
      'mobile': mobile.text,
      'email': email.text,
      'qualification': qualification.text,
      'id_type': idType.text,
      'id_num': idNum.text, 
      'img': img_url,
      'days': days_left
    };

    ref.child(uid).set(userData).then((value) {
      // uploadImage();
      print('done');
    });
  }

  Widget fields(String label, var control) {
    return (label == 'Upload File')
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              img_url == '' ?
              Text(
                label,
                style: TextStyle(color: Colors.black, fontSize: 14),
              ): Image.network(img_url),
              RaisedButton(
                color: Color(0xff0e427b),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                onPressed: () async {
                  var image = await picker.getImage(source: ImageSource.gallery);
                  setState(() {
                    _image = File(image.path); 
                  });
                  uploadImage();                    
                },
                child: Text(
                  'Upload',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          )
        : TextFormField(
            controller: control,
            decoration: InputDecoration(
              isDense: true,
              hintText: label + ' ',
              hintStyle: TextStyle(color: Colors.black),
              border: InputBorder.none,
//                          border: OutlineInputBorder(
//                            borderSide: BorderSide(color: Colors.grey),
//                          ),
            ),
          );
  }

  List<String> formFields = [
    'Name',
    'Gender',
    'Date of Birth',
    'Father Name',
    'Address',
    'Mobile Number',
    'Email',
    'Qualification',
    'Enter your card type(ex-aadhar card,Voter id)',
    'Provide individual identification number',
    'Upload File'
  ];

  
  var controllers = [];

  @override
  void initState() {
    controllers = [name, gender, dob, fatherName, address, mobile, email, qualification, idType, idNum];
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/background2.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(34),
          child: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: Text(
              'Edit Profile',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        drawer: MyDrawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Image.asset(
                  'images/profile.png',
                  height: 100,
                  width: 100,
                ),
                Form(
                  autovalidate: true,
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        return fields(formFields[i], i <= 9 ? controllers[i] : '');
                      },
                      separatorBuilder: (context, i) {
                        return Divider(
                          color: Colors.grey,
                        );
                      },
                      itemCount: formFields.length),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  color: Color(0xff0e427b),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  onPressed: () {setUserData();},
                  child: Text(
                    'Save Changes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'images/man.png',
                    scale: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
