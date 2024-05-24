import 'package:flutter/material.dart';
import 'package:invest/screens/dashboard/dashboard.dart';
import 'package:invest/screens/onboarding/welcome.dart';
import 'package:invest/screens/authentication/new_user/register.dart';
import 'package:invest/screens/authentication/new_user/verify_email.dart';
import 'package:invest/utils/constants.dart';
import 'package:invest/screens/dashboard/goals/new_goal/savings/savings_type.dart';
import 'package:invest/screens/dashboard/goals/new_goal/savings/payment_plan.dart';
import 'package:invest/screens/dashboard/goals/new_goal/savings/timeline_plan.dart';
import 'package:invest/screens/dashboard/goals/new_goal/savings/summary.dart';
import 'package:invest/providers/user_provider.dart';
import 'screens/authentication/existing_user/pin_code.dart';
import 'screens/authentication/new_user/create_pin.dart';
import 'package:invest/widgets/splash_screen.dart';
import 'screens/authentication/email.dart';
import 'screens/authentication/existing_user/password.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:invest/providers/transaction_provider.dart';
import 'package:invest/providers/plan_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>.value(value: UserProvider()),
        ChangeNotifierProvider<PlanProvider>.value(value: PlanProvider()),
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
  // GoRouter configuration
  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const AnimatedTextWidget(),
        routes: <RouteBase>[
          GoRoute(
            path: 'welcome',
            builder: (BuildContext context, GoRouterState state) {
              return const WelcomePage();
            },
          ),
          GoRoute(
            path: 'email',
            builder: (BuildContext context, GoRouterState state) {
              return const EmailPage();
            },
          ),
          GoRoute(
            path: 'verify_user_pin',
            builder: (BuildContext context, GoRouterState state) {
              return PinCodePage(email: state.extra as String);
            },
          ),
          GoRoute(
            path: 'password',
            builder: (BuildContext context, GoRouterState state) {
              return PasswordPage(user: state.extra as Map);
            },
          ),
          GoRoute(
            path: 'dashboard',
            builder: (BuildContext context, GoRouterState state) {
              return const Dashboard();
            },
          ),
          GoRoute(
            path: 'choose_savings_type',
            builder: (BuildContext context, GoRouterState state) {
              return const SavingsType();
            },
          ),
          GoRoute(
            path: 'payment_plan',
            builder: (BuildContext context, GoRouterState state) {
              return const PaymentPlan();
            },
          ),
          GoRoute(
            path: 'timeline_plan',
            builder: (BuildContext context, GoRouterState state) {
              return const TimelinePlan();
            },
          ),
          GoRoute(
            path: 'summary',
            builder: (BuildContext context, GoRouterState state) {
              return const Summary();
            },
          ),
          GoRoute(
            path: 'register',
            builder: (BuildContext context, GoRouterState state) {
              return RegisterUserPage(email: state.extra as String);
            },
          ),
          GoRoute(
            path: 'otp_verification',
            builder: (BuildContext context, GoRouterState state) {
              return VerifyEmail(email: state.extra as String);
            },
          ),
          GoRoute(
            path: 'create_pin',
            builder: (BuildContext context, GoRouterState state) {
              return CreatePin(email: state.extra as String);
            },
          ),
        ],
      ),
    ],
  );

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
              fontSize: 14,
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
