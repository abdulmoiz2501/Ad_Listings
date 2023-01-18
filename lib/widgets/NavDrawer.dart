import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:listings/MyListings.dart';
import 'package:listings/auth_page.dart';

import '../main.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.all(14),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [

            ListTile(),
            const Divider(color: Colors.black45),
            const ListTile(
              leading: Icon(Icons.account_circle),
              title: Text(
                'My Account',
                style: TextStyle(fontSize: 17, fontFamily: 'Montserrat Regular'),
              ),
              //onTap: ()=>MyAccount(user.email!),
            ),
            const Divider(color: Colors.black45),
            const ListTile(
              leading: Icon(Icons.contact_support),
              title: Text(
                'Help/Support',
                style: TextStyle(fontSize: 17, fontFamily: 'Montserrat Regular'),
              ),
              // onTap: () {
              //   Navigator.push(
              //       context, MaterialPageRoute(builder: (context) => FAQ()));
              // },
            ),
            const Divider(color: Colors.black45),
            //LOGOUT
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(
                'Logout',
                style: TextStyle(fontSize: 17, fontFamily: 'Montserrat Regular'),
              ),
              onTap: (){
                signOut();
                } ,
            ),
            const Divider(color: Colors.black45),
             ListTile(
              leading: Icon(Icons.contact_support),
              title: Text(
                'Help/Support',
                style: TextStyle(fontSize: 17, fontFamily: 'Montserrat Regular'),
              ),
              // onTap: () {
              //   Navigator.push(
              //       context, MaterialPageRoute(builder: (context) => FAQ()));
              // },
              onTap: ()=>myListings(),
            ),
          ],
        ),
      ),
    );
  }
  // Future<void> signOut() async {
  //   try {
  //     await _firebaseAuth.signOut();
  //     navigatorKey.currentState!.popUntil((route) => route.isFirst);
  //     Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(
  //           builder: (BuildContext context) => AuthPage(),
  //         ),
  //     );
  //   } catch (error) {
  //     print(error.toString());
  //     return null;
  //
  //   }
  // }
  signOut() async {
    await _firebaseAuth.signOut().then((value) =>
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => AuthPage(),),),).onError((error, stackTrace) {
            print(error);
    });
  }
}
