import 'package:flutter/material.dart';
import 'package:invest/screens/authentication/existing_user/forgot_password.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../utils/constants.dart';

class EmailReset extends StatelessWidget {
  EmailReset({super.key});

  final int maxLength = 9;
  final TextEditingController _controller = TextEditingController();
  // String phoneNumber;
  String initialCountry = 'KE';
  PhoneNumber number = PhoneNumber(isoCode: 'KE');
  String _textValue = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 40,
              ),

              Text(
                'Forgot Password,',
              ),

              SizedBox(height: 8),

              Text(
                'Choose how you want to reset your password',
              ),
              SizedBox(height: 40),
              // Here, default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor

              ToggleSwitch(
                initialLabelIndex: 0,
                minWidth: 150,
                activeBgColor: [(Color.fromARGB(36, 77, 97, 1))],
                totalSwitches: 2,
                labels: [
                  'Phone',
                  'Email',
                ],
                onToggle: (index) {
                  print('switched to: $index');
                  if (index == 0) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPassword()));
                  }
                },
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Email Address', // Set the desired label text

                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey, // Set the desired border color
                      width: 1.0, // Set the desired border width
                    ),
                    borderRadius: BorderRadius.circular(
                        8.0), // Set the desired border radius
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey
                          .shade300, // Set the desired border color for enabled state
                      width:
                          2.0, // Set the desired border width for enabled state
                    ),
                    borderRadius: BorderRadius.circular(
                        8.0), // Set the desired border radius for enabled state
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors
                          .grey, // Set the desired border color for focused state
                      width:
                          1.0, // Set the desired border width for focused state
                    ),
                    borderRadius: BorderRadius.circular(
                        8.0), // Set the desired border radius for focused state
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              // Other

              SizedBox(
                height: 80,
              ),

              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: _textValue.isEmpty
                      ? null
                      : () {
                          // Add your elevated button logic here
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryDarkColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Continue',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
