import 'package:invest/imports/imports.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late Future<void> _loadImageFuture;
  double widthFactor = 0.9;

  @override
  void initState() {
    super.initState();
    _loadImageFuture = _loadImage();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        widthFactor = 0.7; // Shrink to 70%
      });
    });
  }

  Future<void> _loadImage() async {
    await precacheImage(
      const AssetImage('assets/illustrations/welcome.jpg'),
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
      ),
    );

    return FutureBuilder<void>(
      future: _loadImageFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _buildContent(context);
        } else {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, Object? result) async {
          return;
        },
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Image.asset(
                    'assets/illustrations/welcome.jpg',
                    fit: BoxFit.fitHeight,
                    height: double.infinity,
                  ),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withOpacity(0),
                          Colors.white.withOpacity(0),
                          Colors.white.withOpacity(0),
                          Colors.white.withOpacity(0),
                          Colors.white.withOpacity(0.1),
                          Colors.white.withOpacity(0.3),
                          Colors.white.withOpacity(0.5),
                          Colors.white.withOpacity(0.7),
                          Colors.white.withOpacity(0.8),
                          Colors.white.withOpacity(1),
                          Colors.white.withOpacity(1),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        AnimatedContainer(
                          width:
                              MediaQuery.of(context).size.width * widthFactor,
                          duration: const Duration(seconds: 4),
                          child: Image.asset(
                            'assets/icons/mvest_primary.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(7),
                  topRight: Radius.circular(7),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Put your \nmoney to work',
                    style: displayLargeTextDarkBlue(context),
                  ),
                  const SizedBox(height: 20),
                  CustomText(
                    text: 'Invest, save and grow wealth.',
                    style: displayMediumTextDarkBlue(context),
                  ),
                  const SizedBox(height: 50),
                  const SizedBox(height: 20),
                  CustomButton(
                    url: null,
                    method: '',
                    body: const {},
                    text: 'Continue with email',
                    onCompleted: (val) {
                      context.push('/email');
                    },
                  ),
                  const SizedBox(height: 50)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
