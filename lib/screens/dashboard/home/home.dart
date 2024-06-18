import 'package:invest/screens/dashboard/profile.dart';
import 'dart:ui' as ui;
import 'package:invest/providers/transaction_provider.dart';
import 'package:invest/utils/functions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invest/imports/imports.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  // Plan variables
  bool fetchingUserPlans = true;
  num userTotalBalance = 0;

  // Transaction variables
  bool fetchingUserTransactions = true;

  @override
  void initState() {
    super.initState();
    fetchPlans(context).then((res) {
      setState(() {
        userPlans = res['data'];
        fetchingUserPlans = false;
      });
    });
  }

  bool amountHidden = true;
  final greeting = getGreeting();
  @override
  Widget build(BuildContext context) {
    // User Provider
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    // Transaction Provider
    final userTransactionsProvider =
        Provider.of<UserTransactionsProvider>(context);
    final userTransactions = userTransactionsProvider.userTransactions;

    Widget topAppBar = Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: Row(children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Profile()));
                  },
                  child: Image.asset(
                    'assets/icons/user.png',
                    width: SizeConfig.blockSizeHorizontal * 8,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$greeting,',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(height: 1, fontSize: 12),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${user?.name}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(height: 1),
                  ),
                ],
              )
            ]),
          ),
          GestureDetector(
            onTap: () {
              showToast(
                context,
                'Notifications',
                'No new notifications',
                const Color.fromRGBO(242, 183, 2, 1),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: Image.asset(
                'assets/icons/bell.png',
                width: SizeConfig.blockSizeHorizontal * 6,
              ),
            ),
          ),
        ],
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              topAppBar,
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    BalanceCard(
                      userName: user!.name,
                      balance: userTotalBalance.toString(),
                    ),
                    const SizedBox(height: 30),
                    const UserGoals(),
                    const SizedBox(height: 30),
                    const UserTransactions(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
