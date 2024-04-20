import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              CustomAppBar(
                title: '',
                actions: const [],
                leadingOnTap: () {
                  context.pop();
                },
                overlay: SystemUiOverlayStyle.dark,
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
                      // TODO: Got to register new user
                      print('should register user');
                      return;
                    }
                    GoRouter.of(context).push(
                      '/password',
                      extra: {'email': userEmail},
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
