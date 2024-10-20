import 'package:invest/imports/imports.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  //final TextEditingController _controller = TextEditingController();
  TextEditingController email = TextEditingController();
  String emailError = '';

  String initialCountry = 'KE';

  PhoneNumber number = PhoneNumber(isoCode: 'KE');

  String phoneNumber = '';
  int currentTabIndex = 0;

  String phoneError = '';
  bool validateForm() {
    bool isValid = true;

    if (email.text.isEmpty) {
      setState(() {
        emailError = 'Please enter your email address';
      });
      isValid = false;
    } else {
      setState(() {
        emailError = '';
      });
    }

    return isValid;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    setState(() {
      currentTabIndex = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: primaryDarkColor,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Forgot Password?',
                style: displayNormalBolderDarkBlueHeading,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Please enter your email address to reset your password',
                style: displayNormalBlack,
              ),
              const SizedBox(
                height: 40,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),
                    SizedBox(
                      height: 48,
                      child: TextFormField(
                        controller: email,
                        onChanged: (value) {
                          setState(() {
                            emailError =
                                InputValidator.validateEmail(value) ?? '';
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
                      Text(
                        emailError,
                        style: const TextStyle(color: Colors.red),
                      ),
                    const SizedBox(height: 80),
                    CustomButton(
                      url: '/user/password/reset/email_checker',
                      method: 'POST',
                      text: 'Confirm',
                      body: {'email': email.text},
                      onCompleted: (res) {
                        setState(() {
                          validateForm();
                        });
                        if (res['isSuccessful'] == true && validateForm()) {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: VerifyEmail(
                              // otp: res['data']['otp'],
                              email: email.text,
                            ),
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
            ],
          ),
        ),
      ),
    );
  }
}
