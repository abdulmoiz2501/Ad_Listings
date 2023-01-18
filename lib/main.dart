import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:listings/FAQ.dart';
import 'package:listings/LoginWidget.dart';
import 'package:listings/adPosting.dart';
import 'package:listings/constants.dart';
import 'package:listings/listings.dart';
import 'package:listings/utils.dart';

import 'HomePage.dart';
import 'auth_page.dart';
import 'onboarding.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Cairo",
       primarySwatch:  buildMaterialColor(const  Color(0xFF005B47)),
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(displayColor: kTextColor),
      ),
      //home:   const MainPage(),
      home:   OnboardingScreen(),
    );
  }
}

class MainPage extends StatelessWidget{
   const MainPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting)
          {
            return Center(child: CircularProgressIndicator(),);
          }
        else if(snapshot.hasError)
          {
            return Center(child: Text('Something went wrong!'),);
          }
        else if (snapshot.hasData)
          {
            print('snapshot has data');
            Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => HomePage(),
            ),
          );

            return HomePage();
          }
        else
          {
            print('snapshot has NO data');
            return AuthPage();
          }
        // else
        // {
        // return OnboardingScreen();
        // }
      }
    ),
  );
}