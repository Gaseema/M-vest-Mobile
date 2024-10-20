import 'package:invest/imports/imports.dart';

class PinCodePage extends StatefulWidget {
  final String email;
  const PinCodePage({super.key, required this.email});

  @override
  State<PinCodePage> createState() => PinCodePageState();
}

class PinCodePageState extends State<PinCodePage> {
  String codeValue = '';
  bool pincodeError = false;
  late Timer timer;
  List<bool> processingStates = List.filled(4, false);

  void startProcessing() {
    const interval = Duration(milliseconds: 120);
    int count = 0;

    timer = Timer.periodic(interval, (Timer t) {
      setState(() {
        processingStates[count % 4] = !processingStates[count % 4];
        count++;
      });
    });
  }

  void stopProcessing() {
    timer.cancel();
    setState(() {
      processingStates = List.filled(4, false);
    });
  }

  void pinError() {
    setState(() {
      pincodeError = true;
    });
    stopProcessing();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomAppBar(
                title: '',
                actions: const [],
                leadingOnTap: () {
                  context.pop();
                },
                statusBarBrightness: Brightness.light,
              ),
              Expanded(child: Container()),
              Text(
                'Enter your PIN',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return PinCodeField(
                      processing: processingStates[index],
                      filled: codeValue.length >= index + 1,
                      hasError: pincodeError,
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                pincodeError ? 'Oops! Wrong PIN' : '',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.red),
              ),
              const SizedBox(height: 50),
              Keypad(
                actionButton: const Icon(Icons.fingerprint_rounded, size: 30),
                callback: (value) {
                  setState(() {
                    if (value == '<' && codeValue.isNotEmpty) {
                      codeValue = codeValue.substring(0, codeValue.length - 1);
                      pincodeError = false;
                      stopProcessing();
                    } else if (codeValue.length < 4 && value != '.') {
                      if (value == '<') return;
                      codeValue += value;
                      if (codeValue.length == 4) {
                        startProcessing();

                        // Login user
                        apiCall(
                          'POST',
                          '/user/login',
                          {'email': widget.email, 'password': codeValue},
                        ).then((res) {
                          logger.i(res);
                          if (res['isSuccessful'] == true) {
                            userProvider.setUser(
                              User(
                                name: res['data']['user']['first_name'],
                                email: res['data']['user']['email']
                                    .replaceAll(' ', ''),
                                phoneNo: res['data']['user']['phone_number'],
                                token: res['data']['token'],
                              ),
                            );
                            context.go('/dashboard');
                          } else {
                            showToast(
                              context,
                              'Error!',
                              res['error'] ?? 'Error logging in',
                              Colors.red,
                            );
                          }
                          stopProcessing();
                        });
                      }
                    }
                  });
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Forgot your pin?',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        decoration: TextDecoration.underline,
                        color: primaryColor,
                        decorationColor: primaryColor,
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
