import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:listings/FAQ.dart';
import 'package:listings/adPosting.dart';
import 'package:listings/constants.dart';
import 'package:listings/listings.dart';
import 'package:listings/widgets/NavDrawer.dart';
import 'package:listings/widgets/bottom_nav_bar.dart';
import 'package:listings/widgets/category_card.dart';

import 'About.dart';



class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final user = FirebaseAuth.instance.currentUser!;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      endDrawerEnableOpenDragGesture: false,
      drawer: const NavDrawer(),
      //backgroundColor: kBackgroundColor,
      //drawer: NavigationDrawer(),
      //appBar: AppBar(),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        height: 70,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            BottomNavItem(svgScr: "assets/images/account.svg", title: "Account"),
            BottomNavItem(svgScr: "assets/images/home.svg", title: "Home"),
            BottomNavItem(svgScr: "assets/images/category-icon.svg", title: "Categories"),
            BottomNavItem(svgScr: "assets/images/cart.svg", title: "Cart"),

            // Column(
            //   children: <Widget>[
            //     SvgPicture.asset("assets/images/post.svg"),
            //     Text("Today"),
            //   ],
            // ),
          ],
        ),
      ),
      //bottomNavigationBar: BottomNavBar(),
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * 0.3,
            decoration: BoxDecoration(
              color: Color(0xFFF5CEB8),
              image: DecorationImage(
                alignment: Alignment.centerLeft,
                image: AssetImage("assets/images/undraw.png"),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                      child: Container(
                          alignment: Alignment.center,
                          height: 52,
                          width: 52,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFF2BEA1),
                          ),
                          child: IconButton(
                              icon: SvgPicture.asset("assets/images/menu.svg"),
                            onPressed: () {
                                _scaffoldKey.currentState?.openDrawer();
                            },
                          ),
                      ),
                  ),
                  //SizedBox(width: 90,child: Container(color: Colors.white,),),
                  Text(
                    'Welcome',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'Time to shop!',
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        ?.copyWith(fontWeight: FontWeight.w600, fontSize: 22),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(29.5),
                      border: Border.all(color: Colors.black),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "What are you looking for?",
                        //hintStyle: TextStyle(color: Colors.black54.withOpacity(0.7)),
                        icon: SvgPicture.asset(
                          "assets/images/search.svg",
                          height: 20,
                          width: 20,
                          fit: BoxFit.scaleDown,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: <Widget>[
                        CategoryCard(
                          svgSrc: "assets/images/post.svg",
                          title: "Post an ad",
                          press: (){
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) => adPosting(),
                                ),
                            );
                          },
                        ),
                        CategoryCard(
                          svgSrc: "assets/images/view.svg",
                          title: "View the ads",
                            press: (){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) => Listings(),
                                ),
                              );
                            },
                        ),
                        CategoryCard(
                          svgSrc: "assets/images/FAQ.svg",
                          title: "FAQ",
                            press: (){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) => FAQ(),
                                ),
                              );
                            }
                        ),
                        CategoryCard(
                          svgSrc: "assets/images/Conact.svg",
                          title: "About Us",
                            press: (){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) => About(),
                                ),
                              );
                          },
                        ),
                        // CategoryCard(),
                        // CategoryCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // title: Text('Welcome back, ' + user.email!),
      // body: Padding(
      //   padding: EdgeInsets.all(30),
      //   child: Column(
      //     children: [
      //       ElevatedButton.icon(
      //         onPressed: () => FirebaseAuth.instance.signOut(),
      //         icon: Icon(Icons.arrow_back, size: 32),
      //         label: Text(
      //           'Sign Out',
      //           style: TextStyle(fontSize: 24),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}


