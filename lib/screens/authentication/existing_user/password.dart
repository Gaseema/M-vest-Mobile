import 'package:invest/imports/imports.dart';

class PasswordPage extends StatefulWidget {
  final Map user;
  const PasswordPage({
    super.key,
    required this.user,
  });

  @override
  State<PasswordPage> createState() => PasswordPageState();
}

class PasswordPageState extends State<PasswordPage> {
  String userPassword = '';

  // Form Validation
  bool isFormValid = false;
  String formValidationError = 'Enter password';

  formValidationChecker() {
    if (userPassword.isEmpty) {
      setState(() {
        isFormValid = false;
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
    final userProvider = Provider.of<UserProvider>(context);
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
                statusBarBrightness: Brightness.light,
              ),
              Expanded(
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Enter your password',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 20),
                    InputWidget(
                      hintText: '*******',
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          userPassword = value;
                        });
                        formValidationChecker();
                      },
                    ),
                  ],
                )),
              ),
              CustomButton(
                text: 'Continue',
                url: '/user/login',
                method: 'POST',
                body: {
                  'email': widget.user['email'],
                  'password': userPassword,
                },
                onCompleted: (res) {
                  try {
                    if (res['isSuccessful'] == false) {
                      return showToast(
                        context,
                        'Error!!!',
                        res['data']['error'],
                        Colors.red,
                      );
                    }
                    userProvider.setUser(
                      User(
                        name: res['data']['user']['user_name'],
                        email: res['data']['user']['email'].replaceAll(' ', ''),
                        phoneNo: res['data']['user']['phone_number'],
                        token: res['data']['token'],
                      ),
                    );
                    context.push('/dashboard');
                    logger(res);
                  } catch (err) {
                    logger(err);
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
