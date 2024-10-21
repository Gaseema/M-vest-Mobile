import 'package:invest/imports/imports.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
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
            path: 'register_user_data',
            builder: (BuildContext context, GoRouterState state) {
              return RegisterUserPage(user: state.extra as Map);
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
              return CreatePin(user: state.extra as Map);
            },
          ),
        ],
      ),
    ],
  );
}
