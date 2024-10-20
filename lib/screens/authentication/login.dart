import 'package:invest/imports/imports.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  bool rememberMe = false;

  TextEditingController password = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  String emailError = '';
  String passwordError = '';

  bool validateForm() {
    bool isValid = true;

    if (emailAddress.text.isEmpty) {
      setState(() {
        emailError = 'Please enter your email address';
      });
      isValid = false;
    } else {
      setState(() {
        emailError = '';
      });
    }

    if (password.text.isEmpty) {
      setState(() {
        passwordError = 'Please enter your password';
      });
      isValid = false;
    } else {
      setState(() {
        passwordError = '';
      });
    }
    return isValid;
  }

  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  void _signInWithGoogle() async {
    // try {
    //   final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    //   if (googleUser != null) {
    //     // Handle successful sign-up with Google
    //     // Navigate to the dashboard or perform any required actions

    //     // Access the user details from the googleUser object
    //     final String username = googleUser.displayName!;
    //     final String email = googleUser.email;
    //     // final String imageUrl = googleUser.photoUrl ?? '';

    //     // Perform your desired actions with the user details
    //     logger.i('Username: $username');
    //     logger.i('Email: $email');
    //     // Retrieve user information from provider
    //     final userProvider = Provider.of<UserProvider>(context, listen: false);

    //     final token = userProvider.user?.token;

    //     final postData = {
    //       'username': username,
    //       'email': email,
    //       'authentication_type': 'google',
    //     };

    //     final apiClient = ApiClient();
    //     final headers = {
    //       'Authorization': 'Bearer $token',
    //       'Content-Type': 'application/json',
    //     };
    //     await apiClient
    //         .post('/user/login', postData, headers: headers)
    //         .then((response) {
    //       if (response['error'] != null) {
    //         return showToast(
    //           context,
    //           'Error!',
    //           response['error'] ?? 'Error, please try again later.',
    //           Colors.red,
    //         );
    //       }

    //       final userProvider = context.read<UserProvider>();
    //       userProvider.setUser(
    //         User(
    //           name: response['user']['user_name'],
    //           email: response['user']['email'],
    //           phoneNo: response['user']['phone_number'],
    //           token: response['token'],
    //         ),
    //       );
    //       // If the login is successful and you want to navigate to the next page:
    //       Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => Dashboard(),
    //         ),
    //       );
    //     });
    //   }
    // } catch (error) {
    //   // Handle sign-up error
    //   logger.i('Google sign-up error: $error');
    // }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Welcome back,',
                  style: displayNormalBolderDarkBlueHeading,
                ),
                const SizedBox(height: 8),
                Text(
                  'Login to your account',
                  style: displayNormalBolderBlack,
                ),
                const SizedBox(height: 60),
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
                      labelText: 'Email Address or Phone',
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
                  Text(
                    emailError,
                    style: const TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 48,
                  child: TextFormField(
                    controller: password,
                    onChanged: (value) {
                      setState(() {
                        passwordError =
                            InputValidator.validatePassword(value) ?? '';
                      });
                    },
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
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
                  Text(
                    passwordError,
                    style: const TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 42.15),
                CustomButton(
                  url: '/user/login',
                  method: 'POST',
                  text: 'login',
                  body: {
                    'email': emailAddress.text,
                    'password': password.text,
                    'authentication_type': 'form',
                  },
                  onCompleted: (res) {
                    setState(() {
                      validateForm();
                    });
                    if (res['isSuccessful'] == true && validateForm()) {
                      userProvider.setUser(
                        User(
                          name: res['data']['user']['user_name'],
                          email:
                              res['data']['user']['email'].replaceAll(' ', ''),
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
                        res['error'],
                        Colors.red,
                      );
                    }
                  },
                ),
                const SizedBox(height: 11.33),
                Center(
                  child: TextButton(
                    child: Text(
                      'Forgot Password?',
                      style: displayNormalBolderDarkBlue,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPassword(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 22.67,
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
                  height: 20,
                ),
                SizedBox(
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () {
                      _signInWithGoogle();
                    },
                    //
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
                        const Text('Sign in with Google'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 61.84),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Do not have an account yet? ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'Create now ',
                          style: const TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              logger.i('Create now tapped');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUp(),
                                ),
                              );
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
}
