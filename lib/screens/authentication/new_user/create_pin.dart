import 'package:invest/imports/imports.dart';

class CreatePin extends StatefulWidget {
  final Map user;
  const CreatePin({super.key, required this.user});

  @override
  State<CreatePin> createState() => CreatePinState();
}

class CreatePinState extends State<CreatePin> {
  // User Set PIN
  String firstPinValue = "";
  String secondPinValue = "";

  String codeValue = '';

  bool pincodeError = false;
  late Timer timer;
  List<bool> processingStates = List.filled(4, false);

  bool enterConfirmationPin = false;

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
  void initState() {
    super.initState();
    timer = Timer(Duration.zero, () {});
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                'Secure your account',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.black),
              ),
              Text(
                enterConfirmationPin
                    ? 'Enter PIN again to confirm'
                    : 'Enter a pin to secure your account',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                    ),
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
              const SizedBox(height: 50),
              Keypad(
                actionButton:
                    const Icon(Icons.change_circle_outlined, size: 30),
                callback: (value) {
                  setState(() {
                    if (value == '.') {
                      enterConfirmationPin = false;
                      codeValue = '';
                      pincodeError = false;
                      stopProcessing();
                    }
                    if (value == '<' && codeValue.isNotEmpty) {
                      codeValue = codeValue.substring(0, codeValue.length - 1);
                      pincodeError = false;
                      stopProcessing();
                    } else if (codeValue.length < 4 && value != '.') {
                      if (value == '<') return;
                      codeValue += value;
                      if (codeValue.length == 4) {
                        // Check if it's first step of setting pin
                        if (!enterConfirmationPin) {
                          enterConfirmationPin = true;
                          firstPinValue = codeValue; // Save the first pin value
                          codeValue = '';
                          return;
                        }
                        secondPinValue = codeValue; // Save the second pin value

                        // Check if pin match
                        if (firstPinValue != secondPinValue) {
                          pinError();
                          showToast(
                            context,
                            'Error!!!',
                            'PINs do not match',
                            Colors.red,
                          );
                          return;
                        }

                        startProcessing();
                        apiCall(
                          'POST',
                          '/user/set_pin',
                          {'user_id': widget.user['id'], 'pin': codeValue},
                        ).then((res) {
                          if (res['isSuccessful'] == true) {
                            context.go('/dashboard');
                          } else {
                            pinError();
                          }
                          stopProcessing();
                        });
                      }
                    }
                  });
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
