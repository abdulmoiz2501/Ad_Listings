import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:listings/HomePage.dart';
import 'package:listings/constants.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'FirebaseDetails.dart';

class MyAccount extends StatefulWidget {
  String emailID;

  MyAccount(this.emailID, {super.key});


  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {

  var cnicFormater = new MaskTextInputFormatter(mask: '#####-#######-#', filter: { "#": RegExp(r'[0-9]') });
  var phoneFormater = new MaskTextInputFormatter(mask: '####-#######', filter: { "#": RegExp(r'[0-9]') });

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final controller = PageController(
    initialPage: 0,
  );

  final TextEditingController _email = TextEditingController();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _phoneNo = TextEditingController();
  final TextEditingController _city = TextEditingController();


  @override
  void initState() {
    super.initState();
    setState(() {
      _email.text=widget.emailID;
    });
  }

  CollectionReference users =
      FirebaseFirestore.instance.collection('User Details');
  User user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          backgroundColor: kPrimaryColor,
        ),
      ),
      body: Form(
        key: _formKey,
        child:  PageView
        // PERSONAL DETAILS AND ADDRESS DETAILS
          (
            controller: controller,
            children:
            [
              // personal details
              SingleChildScrollView(
                child: new Container(
                  alignment: Alignment.topCenter,
                  color: Colors.white,
                  child: new Column(
                    children: [
                      SizedBox(
                        height:size.height*0.025,
                      ),
                      Text(
                        'Personal Details',
                        style: TextStyle(
                          fontFamily: 'Montserrat Medium',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height:size.height*0.015,
                      ),
                      // Image.asset(
                      //   'assets/images/personal_Info.png',
                      //   width: size.height*0.33,
                      // ),
                      SizedBox(
                        height: size.height*0.03,
                      ),

                      /*
                    1: text is wrapped in align
                    2: a sized box is used
                    3: a text field is wrapped in container
                    4: enabled border and focus border is used
                      */

                      // Full Name
                      customTextField("Full Name", _fullName, size ),
                      // CNIC
                      customTextField("Address", _address, size),
                      // PHONE
                      customTextField("Phone", _phoneNo, size),
                      // EMAIL
                      customTextField("Email", _email, size,readOnly: true),

                      SizedBox(
                        height: size.height*0.01,
                      ),

                      // NEXT BUTTON
                      SizedBox(
                        height: size.height*0.08,
                        width: size.width*0.6,
                        child: TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              controller.animateTo(
                                  MediaQuery.of(context).size.width,
                                  duration: new Duration(milliseconds: 600),
                                  curve: Curves.easeIn);
                            }
                          },
                          style: TextButton.styleFrom(
                           backgroundColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(color: Colors.black),
                            ),
                          ),
                          child: Text(
                            'Next',
                            style: TextStyle(
                              fontFamily: 'Montserrat Medium',
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),

                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // address details
              SingleChildScrollView(
                child: new Container(
                  alignment: Alignment.topCenter,
                  color: Colors.white,
                  child: new Column(
                    children: [
                      SizedBox(
                        height:size.height*0.025,
                      ),
                      Text(
                        'Address Details',
                        style: TextStyle(
                          fontFamily: 'Montserrat Medium',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height:size.height*0.015,
                      ),
                      // Image.asset(
                      //   'assets/images/address_info.png',
                      //   width: size.height*0.20,
                      // ),
                      SizedBox(
                        height: size.height*0.03,
                      ),

                      /*
                    1: text is wrapped in align
                    2: a sized box is used
                    3: a text field is wrapped in container
                    4: enabled border and focus border is used
                      */

                      // Full Name
                      customTextField("City", _city, size ),

                      SizedBox(
                        height: size.height*0.01,
                      ),

                      // Buttons BACK and SUBMIT
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: size.height*0.08,
                            width: size.width*0.4,
                            child: TextButton(
                              onPressed: () {
                                controller.previousPage(
                                    duration: Duration(milliseconds: 600),
                                    curve: Curves.easeIn);
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: kPrimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: BorderSide(color: Colors.black),
                                ),
                              ),
                              child: Text(
                                'Back',
                                style: TextStyle(
                                  fontFamily: 'Montserrat Medium',
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height*0.08,
                            width: size.width*0.4,
                            child: TextButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  print('inputData() function calling');
                                  inputData();
                                }
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: kPrimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: BorderSide(color: Colors.black),
                                ),
                              ),
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  fontFamily: 'Montserrat Medium',
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                ),
              ),

            ],
            physics: NeverScrollableScrollPhysics()
        ),

      ),
    );
  }
  //
  // void inputData() async
  // {
  //   final String uid=user!.uid;
  //   final CollectionReference userDetails =
  //   FirebaseFirestore.instance.collection('User Details');
  //   return await userDetails.doc(uid).set({
  //     "Full Name ": _fullName.text,
  //     "Phone ": _phoneNo.text,
  //     "Email ": _email.text,
  //     "Address ": _address.text,
  //     "City ": _city.text,
  //   });
  // }

  Widget customTextField(String title ,var controller , Size size,{bool readOnly = false} )
  {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '         $title',
            style: TextStyle(
              fontFamily: 'Montserrat Medium',
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        SizedBox(
          height: size.height*0.005,
        ),
        new Container(
          height: size.height*0.07,
          width: size.width*0.85,
          child: TextFormField(
            readOnly: readOnly,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Field is Empty';
              }
              return null;
            },
            controller: controller,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: BorderSide(
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: size.height*0.02,
        ),
      ],
    );
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  void inputData() async {

    // getting current user id
    final User? user = auth.currentUser;
    final uid = user?.uid;
    print ("user id : "+ uid!);

    // updating data entered by user
     await DataBaseService(uid: user!.uid).editProduct(_fullName.text,  _phoneNo.text,
        _email.text, _address.text , _city.text);
    print('In database services');
    if (user != null)
    {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => HomePage(),
        ),
      );
    }
  }
}
Widget fieldForm(String field, String fieldData ,Size size) {
  return new Column(
    children: [
      SizedBox(
        height: size.height *0.02,
      ),

      new Row(
        children: [
          SizedBox(
            width: 45,
          ),
          new Text(
            field,
            style: TextStyle(fontSize: 16, fontFamily: "Montserrat Medium",fontWeight: FontWeight.w700),
          ),
          SizedBox(
            width: 15,
          ),
          new Text(
            fieldData,
            style: TextStyle(fontSize: 16, fontFamily: "Montserrat Medium",fontWeight: FontWeight.w600),
          ),
        ],
      ),

      Divider(
        height: size.height*0.02,
        indent: 35,
        endIndent: 35,
        color: Colors.grey.shade900,
        thickness: 1.5,
      ),

    ],
  );
}