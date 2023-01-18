import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:listings/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'dart:io';

import 'HomePage.dart';

class adPosting extends StatefulWidget {
  const adPosting({Key? key}) : super(key: key);

  @override
  State<adPosting> createState() => _adPostingState();
}

class _adPostingState extends State<adPosting> {
  File? _image;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _number = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: kContrast),
            onPressed: () {}
            ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Fill the Information",
            style: TextStyle(
              color: Colors.black45,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),

          ///AppBar
          actions: [
            SizedBox(
              height: size.height * 0.049,
              width: size.width * 0.20,
              child: TextButton.icon(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    addAdvertisements(_title.text, _description.text, _image!,
                        _price.text, _number.text);
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                label: Text(''),
                // label: Text(
                //   'Post',
                //   style: GoogleFonts.roboto(
                //     fontSize: 18,
                //     color: kContrast,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
                icon: Row(
                  children: [
                    Text(
                      'Post',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        color: kContrast,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: size.width * 0.045,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.03,
              ),

              Container(
                height: size.height * 0.3,
                width: size.width * 0.9,
                child: _image == null
                    ? Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(12),
                      padding: EdgeInsets.all(12),
                      width: size.width * 0.3,
                      height: size.height * 0.9,
                      decoration: BoxDecoration(
                        color: Color(0xFFc4c4c4),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Wrap(
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.image_outlined),
                                    title: Text('Get From Gallery'),
                                    onTap: getFromGallery,
                                  ),
                                  ListTile(
                                    leading:
                                    Icon(Icons.camera_alt_outlined),
                                    title: Text('Take From Camera'),
                                    onTap: getFromCamera,
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 26,
                            ),
                            Container(
                              margin: EdgeInsets.all(4),
                              child: Icon(
                                Icons.add,
                                color: Color(0xff000000),
                                size: 43,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(4),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Color(0xff000000),
                                size: 43,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
                    : Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.file(
                        _image!,
                        fit: BoxFit.cover,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _image = null;
                            });
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: size.height * 0.016,
              ),

              ///TITLE BOX
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Colors.grey.shade300),
                    color: Colors.grey.shade200,
                  ),
                  height: size.height * 0.08,
                  width: size.width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12, top: 24),
                    child: TextFormField(
                      maxLength: 25,
                      controller: _title,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is Empty';
                        }
                        return null;
                      },
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                        fontFamily: "Montserrat Regular",
                        fontWeight: FontWeight.bold,
                      ),
                      cursorColor: Colors.black54,
                      decoration: InputDecoration(
                        hintText: "Enter Title",
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),

              ///DESCRIPTION BOX
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Colors.grey.shade300),
                    color: Colors.grey.shade200,
                  ),
                  height: size.height * 0.25,
                  width: size.width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 25,
                      controller: _description,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is Empty';
                        }
                        return null;
                      },
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 18,
                        fontFamily: "Montserrat Regular",
                        fontWeight: FontWeight.bold,
                      ),
                      cursorColor: Colors.black54,
                      decoration: InputDecoration(
                        hintText: "Enter Description",
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: size.height * 0.04,
              ),

              ///PRICE BOX
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Colors.grey.shade300),
                    color: Colors.grey.shade200,
                  ),
                  height: size.height * 0.08,
                  width: size.width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      controller: _price,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is Empty';
                        }
                        return null;
                      },
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 18,
                        fontFamily: "Montserrat Regular",
                        fontWeight: FontWeight.bold,
                      ),
                      cursorColor: Colors.black54,
                      decoration: InputDecoration(
                        hintText: "Enter price",
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: size.height * 0.03,
              ),

              ///PhoneNo box
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Colors.grey.shade300),
                    color: Colors.grey.shade200,
                  ),
                  height: size.height * 0.08,
                  width: size.width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      controller: _number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is Empty';
                        }
                        return null;
                      },
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 18,
                        fontFamily: "Montserrat Regular",
                        fontWeight: FontWeight.bold,
                      ),
                      cursorColor: Colors.black54,
                      decoration: InputDecoration(
                        hintText: "Enter Your Phone Number",
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: size.height * 0.03,
              ),

              // SizedBox(
              //   height: size.height * 0.08,
              //   width: size.width * 0.8,
              //   child: ElevatedButton(
              //     onPressed: () async {
              //       if (_formKey.currentState!.validate()) {
              //         addIncident(_title.text, _description.text, _image!);
              //       }
              //     },
              //     style: ElevatedButton.styleFrom(
              //         primary: kContrast,
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(30),
              //             side: BorderSide(color: Colors.black))),
              //     child: Text(
              //       'Upload',
              //       style: TextStyle(
              //         fontFamily: 'Montserrat Medium',
              //         fontSize: 20,
              //         color: Colors.white,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  } //second

  /// Get from gallery
  getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  /// Get from Camera
  getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> addAdvertisements(String title, String description, File image,
      String price, String number) async {
    final CollectionReference ads =
    FirebaseFirestore.instance.collection('Ads');
    final ProgressDialog pr = ProgressDialog(context);
    pr.style(
      message: 'Please Wait...',
      progressWidget: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF6F35A5)),
      ),
      progress: 0,
      maxProgress: 100,
    );
    pr.show();

    FirebaseStorage storage = FirebaseStorage.instance;
    String url;
    if (image == null) {
      await ads.doc().set({
        "title": title,
        "description": description,
        "price": price,
        "Phone": number,
        "image": null,
        "email": user.email,
      }).whenComplete(() =>
      {
        pr.hide(),
      Navigator.of(context).push(
      MaterialPageRoute(
      builder: (BuildContext context) => HomePage()),
      ),
      },
      );
    } else if (image != null) {
      Reference ref = storage.ref().child("image" + DateTime.now().toString());
      UploadTask uploadTask = ref.putFile(image);
      uploadTask.whenComplete(() async {
        url = await ref.getDownloadURL();
        print("url: $url");
        if (url != null) {
          await ads.doc().set({
            "title": title,
            "description": description,
            "price": price,
            "Phone": number,
            "image": url,
            "email": user.email,
          }).whenComplete(() =>
          {
            pr.hide(),
          Navigator.of(context).push(
          MaterialPageRoute(
          builder: (BuildContext context) => HomePage()),
          ),
          }).catchError((onError) {
            print(onError);
          }).whenComplete(() =>
          {
            pr.hide(),
            Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage(),),),
          });
        }
      });
    }
  }
}