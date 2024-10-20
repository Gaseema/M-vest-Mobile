import 'package:invest/imports/imports.dart';

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
              fontSize: 10,
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
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
