import 'package:invest/imports/imports.dart';

class EmailReset extends StatelessWidget {
  final int maxLength = 9;
  final String _textValue = '';
  const EmailReset({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 40,
              ),

              const Text(
                'Forgot Password,',
              ),

              const SizedBox(height: 8),

              const Text(
                'Choose how you want to reset your password',
              ),
              const SizedBox(height: 40),
              // Here, default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor

              ToggleSwitch(
                initialLabelIndex: 0,
                minWidth: 150,
                activeBgColor: const [(Color.fromARGB(36, 77, 97, 1))],
                totalSwitches: 2,
                labels: const [
                  'Phone',
                  'Email',
                ],
                onToggle: (index) {
                  logger('switched to: $index');
                  if (index == 0) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPassword()));
                  }
                },
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Email Address', // Set the desired label text

                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey, // Set the desired border color
                      width: 1.0, // Set the desired border width
                    ),
                    borderRadius: BorderRadius.circular(
                        8.0), // Set the desired border radius
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey
                          .shade300, // Set the desired border color for enabled state
                      width:
                          2.0, // Set the desired border width for enabled state
                    ),
                    borderRadius: BorderRadius.circular(
                        8.0), // Set the desired border radius for enabled state
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors
                          .grey, // Set the desired border color for focused state
                      width:
                          1.0, // Set the desired border width for focused state
                    ),
                    borderRadius: BorderRadius.circular(
                        8.0), // Set the desired border radius for focused state
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              // Other

              const SizedBox(
                height: 80,
              ),

              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: _textValue.isEmpty
                      ? null
                      : () {
                          // Add your elevated button logic here
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryDarkColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Continue',
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
