import 'package:invest/imports/imports.dart';

class ResetSuccess extends StatefulWidget {
  const ResetSuccess({super.key});

  @override
  State<ResetSuccess> createState() => _ResetSuccessState();
}

class _ResetSuccessState extends State<ResetSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backColor,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(
                  height: 240,
                ),
                Center(
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.asset('assets/images/success_reset.png'),
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                Text(
                  'Reset was successful',
                  style: displayNormalBolderDarkBlueHeading,
                ),
                const SizedBox(
                  height: 138,
                ),
                GestureDetector(
                  onTap: () {
                    // Handle the click event here
                    print('Text clicked');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const LoginScreen())));
                  },
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Login Now',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}
