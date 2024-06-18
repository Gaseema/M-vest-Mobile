import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:invest/widgets/appbar.dart';
import 'package:invest/widgets/buttons.dart';
import 'package:invest/widgets/input.dart';
import 'package:invest/utils/helpers.dart';
import 'package:invest/utils/constants.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({super.key});

  @override
  State<EmailPage> createState() => EmailPageState();
}

class EmailPageState extends State<EmailPage> {
  late FocusNode _firstInputFocusNode;
  String userEmail = '';

  // Form Validation
  bool isFormValid = false;
  String formValidationError = 'Enter Email';

  formValidationChecker() {
    if (userEmail.isEmpty) {
      setState(() {
        isFormValid = false;
      });
    } else if (isEmailValid(userEmail) == false) {
      setState(() {
        isFormValid = false;
        formValidationError = 'Enter a valid email';
      });
    } else {
      setState(() {
        isFormValid = true;
        formValidationError = '';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    formValidationChecker();
    _firstInputFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _firstInputFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              CustomAppBar(
                title: '',
                actions: const [],
                leadingOnTap: () {
                  context.pop();
                },
                statusBarBrightness: Brightness.light,
              ),
              Expanded(
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Continue with email',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 20),
                    InputWidget(
                      hintText: 'doe@example.com',
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        setState(() {
                          userEmail = value;
                        });
                        formValidationChecker();
                      },
                      focusNode: _firstInputFocusNode,
                    ),
                  ],
                )),
              ),
              CustomButton(
                formValid: isFormValid,
                validationMessage: formValidationError,
                text: 'Continue',
                url: '/user/verify/email',
                method: 'POST',
                body: {'email': userEmail},
                onCompleted: (res) {
                  print('<<<<<<<<<<<<<<email>>>>>>>>>>>>>>');
                  print(res);
                  try {
                    print(res['data']['user']);
                    if (res['isSuccessful'] == false) {
                      return showToast(
                        context,
                        'Error!!!',
                        res['data']['error'],
                        Colors.red,
                      );
                    }
                    if (res['data']['user'] == null) {
                      return GoRouter.of(context).push(
                        '/otp_verification',
                        extra: userEmail,
                      );
                    }
                    // Check the status of the user
                    var userStatus = res['data']['user']['status'];
                    print('user status: $userStatus');
                    if (userStatus <= 1) {
                      // User has to set a password
                      return GoRouter.of(context).push(
                        '/create_pin',
                        extra: userEmail,
                      );
                    }
                    // Take user to dashboard
                    GoRouter.of(context).push(
                      '/verify_user_pin',
                      extra: userEmail,
                    );
                  } catch (err) {
                    print(err);
                    return showToast(
                      context,
                      'Error!!!',
                      'Email validation error',
                      Colors.red,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
