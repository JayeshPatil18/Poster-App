import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poster_app/features/authentication/presentation/pages/login.dart';
import 'package:poster_app/features/poster/presentation/pages/home.dart';
import 'package:poster_app/features/poster/presentation/pages/poster.dart';
import 'package:poster_app/features/poster/presentation/pages/template.dart';
import 'package:poster_app/utils/fonts.dart';

import '../../../../utils/methods.dart';
import '../../../poster/presentation/widgets/button.dart';
import '../../data/repositories/signup.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  var boarderWidth = 1.5;

  final nameController = TextEditingController();
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

      case 2:
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
                    child: Text('Sign Up', style: MainFonts.labelStyle())),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  cursorColor: Colors.grey,
                  controller: nameController,
                  validator: ((value) {
                    return _validateInput(value, 0);
                  }),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          top: 20, bottom: 20, left: 20, right: 20),
                      labelText: 'Full Name',
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
                  controller: usernameController,
                  validator: ((value) {
                    return _validateInput(value, 1);
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
                    return _validateInput(value, 2);
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
                      label: 'Sign Up',
                      onPress: () async {
                        bool isValid = _myFormKey.currentState!.validate();

                        if(isValid){

                          bool result = await addUser(nameController.text.trim(), usernameController.text.trim(), passwordController.text.trim());

                          if(result){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Sign Up Successfully')),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
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
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      Container(
                        width: 4,
                      ),
                      Text(
                        'Login',
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
