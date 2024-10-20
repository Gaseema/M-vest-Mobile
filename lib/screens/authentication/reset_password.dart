import 'package:invest/imports/imports.dart';

class ResetPassword extends StatefulWidget {
  final String? email;
  const ResetPassword({super.key, this.email});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  String confirmPasswordError = '';
  TextEditingController confirmPassword = TextEditingController();
  String passwordError = '';
  TextEditingController password = TextEditingController();
  bool _obscureText = true;
  bool _obscureConfirmText = true;
  bool passwordsMatch = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Reset your password',
                  style: displayNormalBolderDarkBlueHeading,
                ),
                const SizedBox(
                  height: 10,
                ),
                // Text('Choose how you want to reset your password',
                //     style: displayNormalBlack),
                Text(
                    'Here’s a tip: Use a combination of Numbers, Uppercase, lowercase and Special characters',
                    style: displayNormalBlack),

                const SizedBox(
                  height: 40,
                ),
                const SizedBox(height: 24),
                Center(
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.asset('assets/images/secure_password.png'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 48,
                  child: TextFormField(
                    obscureText: _obscureText,
                    controller: password,
                    onChanged: (value) {
                      setState(() {
                        passwordError =
                            InputValidator.validatePassword(value) ?? '';
                        passwordsMatch = confirmPassword.text == value;
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
                    focusNode: _passwordFocusNode,
                  ),
                ),
                Focus(
                  onFocusChange: (hasFocus) {
                    if (!hasFocus) {
                      setState(() {
                        passwordError =
                            InputValidator.validatePassword(password.text) ??
                                '';
                      });
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (passwordError.isNotEmpty)
                        Text(
                          passwordError,
                          style: const TextStyle(color: Colors.red),
                        )
                      else
                        const SizedBox(height: 0),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 48,
                  child: TextFormField(
                    obscureText: _obscureConfirmText,
                    controller: confirmPassword,
                    onChanged: (value) {
                      setState(() {
                        confirmPasswordError = _validateConfirmPassword(value);
                        passwordsMatch = value == password.text;
                      });
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(_obscureConfirmText
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmText = !_obscureConfirmText;
                          });
                        },
                      ),
                      filled: true,
                      suffix: passwordsMatch
                          ? const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            )
                          : null,
                      fillColor: Colors.white,
                      labelText: 'Confirm Password',
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
                    focusNode: _confirmPasswordFocusNode,
                  ),
                ),
                if (confirmPasswordError.isNotEmpty)
                  Text(
                    confirmPasswordError,
                    style: const TextStyle(color: Colors.red),
                  )
                else
                  const SizedBox(height: 0),
                const SizedBox(
                  height: 56,
                ),
                CustomButton(
                  url: '/user/password/reset',
                  method: 'POST',
                  text: 'Confirm',
                  body: {
                    'email': widget.email,
                    'password': password.text,
                    'confirmPassword': confirmPassword.text,
                  },
                  onCompleted: (res) {
                    // logger.i('res');
                    // logger.i(res);
                    if (res['isSuccessful'] == true) {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: const ResetSuccess(),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _validateConfirmPassword(String value) {
    if (value.isEmpty) {
      return 'Please enter the confirm password.';
    } else if (value != password.text) {
      return 'Passwords do not match.';
    }
    return '';
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }
}
