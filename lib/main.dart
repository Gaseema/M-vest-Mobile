import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:invest/utils/constants.dart';
import 'package:invest/providers/user_provider.dart';
import 'screens/onboarding/welcome.dart';
import 'screens/authentication/email.dart';
import 'screens/authentication/existing_user/password.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:invest/providers/transaction_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>.value(value: UserProvider()),
        ChangeNotifierProvider<UserTransactionsProvider>.value(
          value: UserTransactionsProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isFirstInstall = false;

  // GoRouter configuration
  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const WelcomePage(),
        routes: <RouteBase>[
          GoRoute(
            path: 'email',
            builder: (BuildContext context, GoRouterState state) {
              return const EmailPage();
            },
          ),
          GoRoute(
            path: 'password',
            builder: (BuildContext context, GoRouterState state) {
              return PasswordPage(user: state.extra as Map);
            },
          ),
        ],
      ),
    ],
  );

  @override
  void initState() {
    super.initState();
    checkFirstInstall();
  }

  void checkFirstInstall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstInstall = prefs.getBool('isFirstInstall') ?? true;
    setState(() {
      this.isFirstInstall = isFirstInstall;
    });
    if (isFirstInstall) {
      await prefs.setBool('isFirstInstall', false);
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return OverlaySupport.global(
      child: MaterialApp.router(
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
        title: 'M-vest',
        theme: ThemeData(
          textTheme: TextTheme(
            //Body Small
            bodySmall: GoogleFonts.montserrat(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),

            //Body Medium
            bodyMedium: GoogleFonts.montserrat(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),

            //Body Large
            bodyLarge: GoogleFonts.aBeeZee(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
