import 'package:invest/imports/imports.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  String initialCountry = 'KE';
  PhoneNumber number = PhoneNumber(isoCode: 'KE');
  bool _obscureText = true;
  TextEditingController fullName = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  String phoneNumber = '';
  String fullNameError = '';
  String emailError = '';
  String phoneError = '';
  String passwordError = '';

  bool validateFormFields() {
    bool isValid = true;
    if (fullName.text.isEmpty) {
      setState(() {
        fullNameError = 'Please enter a full name';
      });
      isValid = false;
    } else {
      setState(() {
        fullNameError = '';
      });
    }

    if (emailAddress.text.isEmpty) {
      setState(() {
        emailError = 'Please enter an email address';
      });
      isValid = false;
    } else {
      setState(() {
        emailError = '';
      });
    }

    if (phoneNumber.isEmpty) {
      setState(() {
        phoneError = 'Please enter a phone number';
      });
      isValid = false;
    } else {
      setState(() {
        phoneError = '';
      });
    }

    if (password.text.isEmpty) {
      setState(() {
        passwordError = 'Please enter a password';
      });
      isValid = false;
    } else {
      setState(() {
        passwordError = '';
      });
    }
    return isValid;
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void _signUpWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        // Handle successful sign-up with Google
        // Navigate to the dashboard or perform any required actions

        // Access the user details from the googleUser object
        final String username = googleUser.displayName!;
        final String email = googleUser.email;
        // final String imageUrl = googleUser.photoUrl ?? '';

        // Perform your desired actions with the user details
        // logger.i('Username: $username');
        // logger.i('Email: $email');

        _openModalSheet(username, email);
      }
    } catch (error) {
      // Handle sign-up error
      // logger.i('Google sign-up error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: backColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Sign Up',
                    style: displayNormalBolderDarkBlueHeading,
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Let us create you an account',
                    style: displayNormalBlack,
                  ),
                ),
                const SizedBox(height: 43),
                SizedBox(
                  height: 48,
                  child: TextFormField(
                    controller: fullName,
                    textCapitalization: TextCapitalization.words,
                    inputFormatters: [
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        if (newValue.text.isNotEmpty) {
                          return TextEditingValue(
                            text: newValue.text.substring(0, 1).toUpperCase() +
                                newValue.text.substring(1),
                            selection: newValue.selection,
                          );
                        }
                        return newValue;
                      }),
                    ],
                    onChanged: (value) {
                      setState(() {
                        fullNameError =
                            InputValidator.validateFullName(value) ?? '';
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Full Name',
                      labelStyle: displayNormalGrey1,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.shade300, width: 2.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: fullNameError.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      fullNameError,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 48,
                  child: TextFormField(
                    controller: emailAddress,
                    onChanged: (value) {
                      setState(() {
                        emailError = InputValidator.validateEmail(value) ?? '';
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Email Address',
                      labelStyle: displayNormalGrey1,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                if (emailError.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      emailError,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 48,
                  child: InternationalPhoneNumberInput(
                    inputDecoration: customInputDecoration,
                    textAlignVertical: TextAlignVertical.top,
                    selectorTextStyle: customSelectorTextStyle,
                    onInputChanged: (PhoneNumber value) {
                      setState(() {
                        phoneNumber = '${value.phoneNumber}';
                        phoneError = InputValidator.validatePhoneNumber(
                                value.toString()) ??
                            '';
                      });
                    },
                    selectorConfig: const SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      setSelectorButtonAsPrefixIcon: true,
                      leadingPadding: 10,
                    ),
                    initialValue: number,
                    formatInput: false,
                  ),
                ),
                if (phoneError.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      phoneError,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 48,
                  child: TextFormField(
                    obscureText: _obscureText,
                    controller: password,
                    onChanged: (value) {
                      setState(() {
                        passwordError =
                            InputValidator.validatePassword(value) ?? '';
                      });
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Password',
                      labelStyle: displayNormalGrey1,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                if (passwordError.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      passwordError,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 12),
                CustomButton(
                  url: '/user/register',
                  method: 'POST',
                  text: 'Create an Account',
                  body: {
                    'user_name': fullName.text,
                    'email': emailAddress.text.replaceAll(' ', ''),
                    'phone_number': phoneNumber,
                    'password': password.text,
                    'authentication_type': 'form',
                  },
                  onCompleted: (res) {
                    setState(() {
                      validateFormFields();
                    });
                    if (res['isSuccessful'] == true && validateFormFields()) {
                      userProvider.setUser(
                        User(
                          name: res['data']['user']['user_name'],
                          email: res['data']['user']['email'],
                          phoneNo: res['data']['user']['phone_number'],
                          token: res['data']['token'],
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Dashboard(),
                        ),
                      );
                    } else {
                      showToast(
                        context,
                        'Error!',
                        res['error'] ?? 'Error, please try again later.',
                        Colors.red,
                      );
                    }
                  },
                ),
                const SizedBox(height: 26.4),
                Center(
                  child: RichText(
                    text: TextSpan(children: [
                      const TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: 'Log in',
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                      ),
                    ]),
                  ),
                ),
                const SizedBox(
                  height: 22.6,
                ),
                const Row(
                  children: <Widget>[
                    Expanded(
                        child: Divider(color: Colors.grey)), // Horizontal line
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('Or continue with'),
                    ),
                    Expanded(
                        child: Divider(color: Colors.grey)), // Horizontal line
                  ],
                ),
                const SizedBox(
                  height: 28,
                ),
                SizedBox(
                  height: 48,
                  child: OutlinedButton(
                    onPressed: _signUpWithGoogle,
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      side: const BorderSide(
                          color: Colors.black), // Add border color
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 20),
                          height: 30,
                          child: Image.asset('assets/icons/google.png'),
                        ),
                        const Text('Sign Up with Google'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 66.41),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'By signing up to create an account I accept ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'Company’s Terms of Use ',
                          style: const TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Handle Terms of Use tap
                            },
                        ),
                        const TextSpan(
                          text: 'and ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: const TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Handle Privacy Policy tap
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _openModalSheet(String username, String email) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          // Wrap the Column with SingleChildScrollView
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            // Remove the height property to allow the modal to take the height of its content
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Please enter your phone number',
                  style: displayNormalBolderDarkBlueHeading,
                ),
                const SizedBox(height: 40),
                SizedBox(
                  height: 48,
                  child: InternationalPhoneNumberInput(
                    inputDecoration: customInputDecoration,
                    textAlignVertical: TextAlignVertical.top,
                    selectorTextStyle: customSelectorTextStyle,
                    onInputChanged: (PhoneNumber value) {
                      setState(() {
                        phoneNumber = '${value.phoneNumber}';
                        phoneError = InputValidator.validatePhoneNumber(
                                value.toString()) ??
                            '';
                      });
                    },
                    selectorConfig: const SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      setSelectorButtonAsPrefixIcon: true,
                      leadingPadding: 10,
                    ),
                    initialValue: number,
                    formatInput: false,
                  ),
                ),
                if (phoneError.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      phoneError,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 30),
                CustomButton(
                  url: null,
                  method: 'POST',
                  text: 'Submit',
                  body: const {},
                  onCompleted: (res) async {
                    // logger.i(res);
                    // final apiClient = ApiClient();
                    // final postData = {
                    //   'user_name': username,
                    //   'email': email,
                    //   'phone_number': phoneNumber,
                    //   'authentication_type': 'google',
                    // };
                    // await apiClient
                    //     .post(
                    //   '/user/register',
                    //   postData,
                    // )
                    //     .then((response) {
                    //   if (response['error'] != null) {
                    //     return showToast(
                    //       context,
                    //       'Error!',
                    //       response['error'] ?? 'Error, please try again later.',
                    //       Colors.red,
                    //     );
                    //   }
                    //   final userProvider = context.read<UserProvider>();
                    //   userProvider.setUser(
                    //     User(
                    //       name: response['user']['user_name'],
                    //       email: response['user']['email'],
                    //       phoneNo: response['user']['phone_number'],
                    //       token: response['token'],
                    //     ),
                    //   );
                    //   Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const Dashboard(),
                    //     ),
                    //   );
                    // }).catchError((error) {
                    //   // Handle the error
                    //   logger.i('error');
                    //   logger.i(error);
                    // });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  final customInputDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    labelText: 'Phone number',
    labelStyle: displayNormalGrey1,
    border: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(8.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.shade300,
        width: 2.0,
      ),
      borderRadius: BorderRadius.circular(8.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(8.0),
    ),
  );

  final customSelectorTextStyle = const TextStyle(
    color: Colors.black,
    fontSize: 16.0,
  );

  final customInputTextStyle = const TextStyle(
    color: Colors.black,
    fontSize: 16.0,
  );

  final customCountryTextStyle = const TextStyle(
    color: Colors.black,
    fontSize: 16.0,
  );

  final customDropdownIcon = const Icon(
    Icons.arrow_drop_down,
    color: Colors.black,
  );

  saveUser(name, email, phoneNo, token) {
    final userProvider = Provider.of<UserProvider>(context);
    userProvider.setUser(
      User(
        name: name,
        email: email,
        phoneNo: phoneNo,
        token: token,
      ),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Dashboard(),
      ),
    );
  }
}
