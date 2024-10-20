import 'package:invest/imports/imports.dart';

class RegisterUserPage extends StatefulWidget {
  final String email;
  const RegisterUserPage({
    super.key,
    required this.email,
  });
  @override
  State<RegisterUserPage> createState() => RegisterUserPageState();
}

class RegisterUserPageState extends State<RegisterUserPage> {
  String firstName = '';
  String lastName = '';
  String phoneNo = '';
  String idNo = '';

  // Form Validation
  bool isFormValid = false;
  String formValidationError = 'Enter all input fields';

  formValidationChecker() {
    if (firstName.isEmpty) {
      setState(() {
        isFormValid = false;
        formValidationError = 'Enter first name';
      });
    } else if (lastName.isEmpty) {
      setState(() {
        isFormValid = false;
        formValidationError = 'Enter last name';
      });
    } else if (phoneNo.isEmpty) {
      setState(() {
        isFormValid = false;
        formValidationError = 'Enter phone number';
      });
    } else if (idNo.isEmpty) {
      setState(() {
        isFormValid = false;
        formValidationError = 'Enter ID number';
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
                statusBarBrightness: Brightness.light,
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Nice to meet you. Let's sign you up.",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.black,
                            fontSize: 30,
                            height: 1,
                          ),
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Let your ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 16),
                          ),
                          TextSpan(
                            text: 'savings ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                ),
                          ), // Add a space between words
                          TextSpan(
                            text: 'build wealth, the ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 16),
                          ),
                          TextSpan(
                            text: 'smart way',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    const InputLabel(text: 'First name'),
                    const SizedBox(height: 5),
                    InputWidget(
                      hintText: 'First name',
                      keyboardType: TextInputType.name,
                      onChanged: (value) {
                        setState(() {
                          firstName = value;
                        });
                        formValidationChecker();
                      },
                    ),
                    const SizedBox(height: 30),
                    const InputLabel(text: 'Last name'),
                    const SizedBox(height: 5),
                    InputWidget(
                      hintText: 'Last name',
                      keyboardType: TextInputType.name,
                      onChanged: (value) {
                        setState(() {
                          lastName = value;
                        });
                        formValidationChecker();
                      },
                    ),
                    const SizedBox(height: 30),
                    const InputLabel(text: 'Phone number'),
                    const SizedBox(height: 5),
                    InputWidget(
                      hintText: 'Phone number',
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          phoneNo = value;
                        });
                        formValidationChecker();
                      },
                    ),
                    const SizedBox(height: 30),
                    const InputLabel(text: 'ID number'),
                    const SizedBox(height: 5),
                    InputWidget(
                      hintText: 'ID number',
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          idNo = value;
                        });
                        formValidationChecker();
                      },
                    ),
                    Expanded(child: Container()),
                    CustomButton(
                      formValid: isFormValid,
                      validationMessage: formValidationError,
                      text: 'Continue',
                      url: '/user/register',
                      method: 'POST',
                      body: {
                        'first_name': firstName,
                        'last_name': lastName,
                        'email': widget.email,
                        'phone_number': phoneNo,
                        'id_number': idNo,
                      },
                      onCompleted: (res) {
                        try {
                          logger.i('<<<<<<<<<<<<<<email>>>>>>>>>>>>>>');
                          logger.i(res);
                          if (res['isSuccessful'] == true) {
                            return context.push(
                              '/create_pin',
                              extra: widget.email,
                            );
                          } else {
                            showToast(
                              context,
                              'Error!',
                              res['error'] ?? 'Error creating account',
                              redDarkColor,
                            );
                          }
                        } catch (err) {
                          logger.i(
                              '<<<<<<<<<<<<<<< register user >>>>>>>>>>>>>>>');
                          logger.i(err);
                          showToast(
                            context,
                            'Error!',
                            'Error creating account',
                            redDarkColor,
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 20),
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
