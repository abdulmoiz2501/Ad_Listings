import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  final String uid;
  final CollectionReference userDetails =
  FirebaseFirestore.instance.collection('User Details');

  DataBaseService({required this.uid});


  Future updateUserData(String fullName,String phone,String email,String address,String city) async {
    return await userDetails.doc(uid).set({
      "Full Name ": fullName,
      "Phone ": phone,
      "Email ": email,
      "Address ": address,
      "City ": city,
    });
  }


  Future<void> editProduct(
      String fullName,
      String phone,
      String email,
      String address,
      String city,) async {
    await FirebaseFirestore.instance
        .collection("User Details")
        .doc(uid)
        .update({
      "Full Name ": fullName,
      "Phone ": phone,
      "Email ": email,
      "Address ": address,
      "City ": city,
    });
  }
}
