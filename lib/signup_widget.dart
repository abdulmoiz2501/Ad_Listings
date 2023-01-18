import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:listings/utils.dart';

import 'main.dart';

class SignUpWidget extends StatefulWidget {
  final Function() onClickedSignIn;
  const SignUpWidget({
    Key? key,
    required this.onClickedSignIn,
}): super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}
final formKey = GlobalKey<FormState>();
final emailController = TextEditingController();
final passwordController = TextEditingController();
final confirmPasswordController = TextEditingController();

@override
void dispose()
{
  emailController.dispose();
  passwordController.dispose();

}

class _SignUpWidgetState extends State<SignUpWidget> {
  @override
  Widget build(BuildContext context) {
    // return Material(
    //   child: SingleChildScrollView(
    //     child: Form(
    //       key: formKey,
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           SizedBox(
    //             height: 50,
    //           ),
    //           TextFormField(
    //             controller: emailController,
    //             cursorColor: Colors.white,
    //             textInputAction: TextInputAction.next,
    //             decoration: InputDecoration(labelText: 'Email'),
    //             autovalidateMode: AutovalidateMode.onUserInteraction,
    //             validator: (email)=>
    //             email != null && !EmailValidator.validate(email)
    //             ? 'Enter a valid email'
    //             : null,
    //           ),
    //           SizedBox(height: 10),
    //           TextFormField(
    //             controller: passwordController,
    //             cursorColor: Colors.white,
    //             textInputAction: TextInputAction.next,
    //             decoration: InputDecoration(labelText: 'Password'),
    //             autovalidateMode: AutovalidateMode.onUserInteraction,
    //             validator: (value)=>
    //             value != null && value.length < 6
    //                 ? 'Enter 6 characters (minimum)'
    //                 : null,
    //           ),
    //           SizedBox(
    //             height: 20,
    //           ),
    //           ElevatedButton.icon(
    //             style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
    //             icon: Icon(Icons.lock_open_rounded, size: 32),
    //             label: Text(
    //               'Sign up',
    //               style: TextStyle(fontSize: 24),
    //             ),
    //             onPressed: signUp,
    //           ),
    //           SizedBox(height: 24),
    //           RichText(
    //             text: TextSpan(
    //               style: TextStyle(
    //                 color: Colors.black,
    //                 fontSize: 22,
    //               ),
    //               text: 'Already have an account?',
    //               children: [
    //                 TextSpan(
    //                   recognizer: TapGestureRecognizer()
    //                     ..onTap = widget.onClickedSignIn,
    //                   text: 'Login',
    //                   style: TextStyle(
    //                     decoration: TextDecoration.underline,
    //                     color: Theme.of(context).colorScheme.secondary,
    //                   ),
    //                 ),
    //
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Welcome to Shopify!',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 55,
                    ),
                  ),
                  SizedBox(height: 10,),
                  SvgPicture.asset(
                    "assets/images/welcome2.svg",
                    height: 200,
                    width: 200,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 65,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextFormField(
                          controller: emailController,
                          cursorColor: Colors.white,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: InputBorder.none,
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (email) =>
                          email != null && !EmailValidator.validate(email)
                              ? 'Enter a valid email'
                              : null,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 65,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextFormField(
                          obscureText: true,
                          controller: passwordController,
                          cursorColor: Colors.white,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: InputBorder.none,
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                          value != null && value.length < 6
                              ? 'Enter 6 characters (minimum)'
                              : null,
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 65,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextFormField(
                          obscureText: true,
                          controller: confirmPasswordController,
                          cursorColor: Colors.white,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: ' Confirm Password',
                            border: InputBorder.none,
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value){
                              value != null && value.length < 6
                                  ? 'Enter 6 characters (minimum)'
                                  : null;
                              if(value!.isEmpty)
                                return 'Empty';
                              if(value != passwordController.text)
                                return 'Passwords donot match';
                              return null;
                            }
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      padding: EdgeInsets.all(13),
                      child: Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          onPressed: signUp,
                        ),
                        // child: const Text(
                        //   'Sign In',
                        //   style: TextStyle(
                        //           fontSize: 18,
                        //           fontWeight: FontWeight.bold,
                        //         color: Colors.white,
                        //       ),
                        // ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                      text: 'Already have an account??',
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.onClickedSignIn,
                          text: ' Login',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if(!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e)
    {
     Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
