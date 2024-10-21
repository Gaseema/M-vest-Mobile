import 'package:invest/imports/imports.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>.value(value: UserProvider()),
        ChangeNotifierProvider<PlanProvider>.value(value: PlanProvider()),
        ChangeNotifierProvider<UserTransactionsProvider>.value(
          value: UserTransactionsProvider(),
        ),
      ],
      child: child,
    );
  }
}
