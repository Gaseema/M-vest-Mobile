import 'package:invest/imports/imports.dart';

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
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SafeArea(
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
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        text: 'Continue with email',
                        style: displayMediumTextNormal(context),
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
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                formValid: isFormValid,
                validationMessage: formValidationError,
                text: 'Continue',
                url: '/user/verify/email',
                method: 'POST',
                body: {'email': userEmail},
                onCompleted: (res) {
                  try {
                    logger(res['data']['user']);
                    if (res['isSuccessful'] == false) {
                      return showToast(
                        context,
                        'Error!!!',
                        res['data']['error'],
                        Colors.red,
                      );
                    }
                    if (res['data']['user'] == null) {
                      // Email verification page
                      return GoRouter.of(context).push(
                        '/otp_verification',
                        extra: userEmail,
                      );
                    }

                    // Check the status of the user
                    var userData = res['data']['user'];
                    if (userData['status'] == 1) {
                      // User has to set a password
                      return GoRouter.of(context).push(
                        '/register_user_data',
                        extra: res['data']['user'],
                      );
                    }

                    // User has been saved and need to save user info to the user provider
                    updateUserProvider(userProvider, res['data']);
                    if (userData['status'] == 2) {
                      return GoRouter.of(context).push(
                        '/create_pin',
                        extra: res['data']['user'],
                      );
                    }
                    logger('<<<<<<<<<<userData>>>>>>>>>>');
                    logger(userData);
                    // Take user to dashboard
                    GoRouter.of(context).push(
                      '/verify_user_pin',
                      extra: userData,
                    );
                  } catch (err) {
                    logger(err);
                    return showToast(
                      context,
                      'Error!!!',
                      'Email validation error',
                      Colors.red,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
