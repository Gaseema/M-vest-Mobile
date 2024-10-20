import 'package:invest/imports/imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  welcomePageIllustration(context) {
    Timer(const Duration(seconds: 4), () async {
      await precacheImage(
        const AssetImage('assets/illustrations/welcome.jpg'),
        context,
      );
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  void initState() {
    super.initState();
    myImage = Image.asset('assets/illustrations/welcome.jpg');
    welcomePageIllustration(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(myImage!.image, context);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: primaryColor,
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(36, 77, 97, 1.0),
      body: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.all(60),
            child: Center(
              child: Image(
                image: AssetImage('assets/images/X_Logo.png'),
              ),
            ),
          ),
          Column(children: [
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/splash_image.png',
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
