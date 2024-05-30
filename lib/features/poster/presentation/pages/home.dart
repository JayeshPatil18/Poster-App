import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:poster_app/features/poster/presentation/pages/poster.dart';
import 'package:poster_app/utils/fonts.dart';

import '../../../../utils/methods.dart';
import '../widgets/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var boarderWidth = 1.4;

  final nameController = TextEditingController();
  final phoneNoController = TextEditingController();

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
        } else if (!isNumeric(input) || input.length != 10) {
          return 'Invalid phone number';
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
                    child: Text('Fill Details', style: MainFonts.labelStyle())),
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
                          borderRadius: BorderRadius.circular(13),
                          borderSide: BorderSide(
                              color: Colors.black, width: boarderWidth)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: BorderSide(
                              color: Colors.black, width: boarderWidth))),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  cursorColor: Colors.grey,
                  controller: phoneNoController,
                  validator: ((value) {
                    return _validateInput(value, 0);
                  }),
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          top: 20, bottom: 20, left: 20, right: 20),
                      prefixIcon: CountryCodePicker(
                        onChanged: ((value) {
                          countryCode = value.dialCode.toString();
                        }),
                        initialSelection: '+91',
                        favorite: ['+91', 'IND'],
                        showFlagDialog: true,
                        showFlagMain: false,
                        alignLeft: false,
                      ),
                      labelText: 'Phone No.',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: BorderSide(
                              color: Colors.black, width: boarderWidth)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: BorderSide(
                              color: Colors.black, width: boarderWidth))),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                    height: 50,
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 60),
                    child: CustomButton(
                      label: 'Generate Poster',
                      onPress: () {
                        bool isValid = _myFormKey.currentState!.validate();

                        if(isValid){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GeneratePosterScreen(
                                name: nameController.text.toString().trim(),
                                phoneNo: countryCode + phoneNoController.text.toString().trim(),
                                imageUrl: 'https://i.pinimg.com/originals/ba/b8/42/bab84265b821d4b0d28f9ca7df82c7cf.jpg',
                              ),
                            ),
                          );
                        }
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
