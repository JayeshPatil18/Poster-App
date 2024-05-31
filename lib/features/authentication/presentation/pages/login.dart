import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poster_app/features/authentication/presentation/pages/signup.dart';
import 'package:poster_app/features/poster/presentation/pages/home.dart';
import 'package:poster_app/features/poster/presentation/pages/poster.dart';
import 'package:poster_app/features/poster/presentation/pages/template.dart';
import 'package:poster_app/utils/fonts.dart';

import '../../../../main.dart';
import '../../../../utils/methods.dart';
import '../../../poster/presentation/widgets/button.dart';
import '../../data/repositories/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  void initState() {
    super.initState();

    _checkLogin();
  }

  _checkLogin() async {
    var isLoggedIn = await checkLoginStatus();
    if(isLoggedIn){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }
  }

  var boarderWidth = 1.5;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  var _myFormKey = GlobalKey<FormState>();

  String countryCode = '+91';

  String? _validateInput(String? input, int index) {
    switch (index) {

      case 0:
        if (input == null || input.isEmpty) {
          return 'Field empty';
        }
        break;

      case 1:
        if (input == null || input.isEmpty) {
          return 'Field empty';
        }
        break;

      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 100, bottom: 40, left: 40, right: 40),
        child: Container(
          child: Form(
            key: _myFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.only(top: 20, bottom: 60),
                    child: Text('Login', style: MainFonts.labelStyle())),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  cursorColor: Colors.grey,
                  controller: usernameController,
                  validator: ((value) {
                    return _validateInput(value, 0);
                  }),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          top: 20, bottom: 20, left: 20, right: 20),
                      labelText: 'Username',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                              color: Colors.black, width: boarderWidth)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                              color: Colors.black, width: boarderWidth))),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  cursorColor: Colors.grey,
                  controller: passwordController,
                  validator: ((value) {
                    return _validateInput(value, 1);
                  }),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          top: 20, bottom: 20, left: 20, right: 20),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                              color: Colors.black, width: boarderWidth)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                              color: Colors.black, width: boarderWidth))),
                ),
                SizedBox(height: 40),
                Container(
                    height: 60,
                    width: double.infinity,
                    child: CustomButton(
                      label: 'Login',
                      onPress: () async {
                        bool isValid = _myFormKey.currentState!.validate();

                        if(isValid){

                          int result = await login(usernameController.text.trim(), passwordController.text.trim());

                          if(result == 200){
                            updateLoginStatus(true);
                            FocusScope.of(context).unfocus();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Login Successfully')),
                            );
                            // Remove all backtrack pages
                            Navigator.popUntil(
                                context, (route) => route.isFirst);

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          } else if(result == 1) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Incorrect Password!')),
                            );
                          } else if(result == 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Username not exist!')),
                            );
                          } else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Something went wrong!')),
                            );
                          }
                        }
                      },
                    )),
                SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      Container(
                        width: 4,
                      ),
                      Text(
                        'Sign Up',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
