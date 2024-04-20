import 'package:flutter/material.dart';
import 'package:invest/screens/dashboard/plans/new_plan.dart';
import 'package:invest/screens/dashboard/profile.dart';
import 'package:invest/utils/constants.dart';
import 'package:invest/utils/theme.dart';
import 'package:invest/utils/widgets.dart';
import 'dart:ui' as ui;
import 'package:provider/provider.dart';
import 'package:invest/providers/user_provider.dart';
import 'package:invest/providers/transaction_provider.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:invest/widgets/currency_converter.dart';
import 'package:invest/utils/functions.dart';

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

  bool amountHidden = false;
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
                      width: SizeConfig.blockSizeHorizontal * 7,
                    ),
                  )),
              Text(
                '$greeting, ${user?.name}',
                style: displayNormalBlack,
              ),
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
                width: SizeConfig.blockSizeHorizontal * 5,
              ),
            ),
          ),
        ],
      ),
    );
    Widget balCard = Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: Image.asset(
                  'assets/icons/logo.png',
                  width: SizeConfig.blockSizeHorizontal * 5,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    amountHidden = !amountHidden;
                  });
                },
                child: Image.asset(
                  amountHidden == true
                      ? 'assets/icons/eye_hide.png'
                      : 'assets/icons/eye_view.png',
                  width: SizeConfig.blockSizeHorizontal * 4,
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Savings Balance',
                  style: displaySmallBoldWhite,
                ),
                const SizedBox(height: 5),
                amountHidden == true
                    ? ImageFiltered(
                        imageFilter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Text(
                          'KES. 00000',
                          style: displayBigBoldWhite,
                        ),
                      )
                    : Text(
                        CurrencyConverter().convert(
                          userTotalBalance.toString(),
                        ),
                        style: displayBigBoldWhite,
                      ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                user!.name,
                style: displayNormalWhite,
              ),
            ],
          )
        ],
      ),
    );
    Widget myPlans = Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Saving Plans',
            style: displayNormalSlightlyBoldBlack,
          ),
          const SizedBox(height: 20),
          fetchingUserPlans == false
              ? userPlans.isNotEmpty
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(userPlans.length, (index) {
                          final plan = userPlans[index];
                          final walletBalance = plan['Wallet']?['balance'] ?? 0;
                          final membersList = plan['Group']?['members'] ?? [];
                          final percentageDifference =
                              calculateCurrentAmountPercentage(
                                  walletBalance, plan['target_amount']);
                          print(membersList);
                          return PlanCard(
                            id: plan['id'],
                            type: plan['type'],
                            category: plan['category'],
                            planDescription: plan['description'],
                            plan: plan['goal_name'],
                            progress: percentageDifference,
                            planBalance: walletBalance,
                            target: plan['target_amount'],
                            createdAt: plan['createdAt'],
                            maturityDate: plan['maturity_date'],
                            locked: plan['locked'],
                            walletId: plan['Wallet']?['id'],
                            frequency: plan['frequency'],
                            membersList: membersList,
                            callback: (res) {},
                          );
                        }),
                      ),
                    )
                  : Center(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/illustrations/thoughts.png',
                            width: SizeConfig.blockSizeHorizontal * 40,
                          ),
                          GestureDetector(
                            onTap: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: const NewPlan(),
                                withNavBar: false,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              decoration: BoxDecoration(
                                color: primaryDarkColor,
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Text(
                                'Create a plan',
                                style: displayNormalWhite,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
              : Container(
                  padding: const EdgeInsets.all(20),
                  child: const SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(),
                  ),
                ),
        ],
      ),
    );
    Widget transactions = Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Text(
              'Recent Transactions',
              style: displayNormalSlightlyBoldBlack,
            ),
          ),
          userTransactions.isNotEmpty
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: userTransactions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TransactionCard(
                      type: 'deposit',
                      plan: userTransactions[index]['wallet']['plan']
                          ['goal_name'],
                      amount: userTransactions[index]['amount'],
                      time: userTransactions[index]['createdAt'],
                    );
                  },
                )
              : Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/illustrations/tansaction.png',
                        width: SizeConfig.blockSizeHorizontal * 50,
                      ),
                      Text(
                        'No transactions',
                        style: displayNormalBlack,
                      ),
                    ],
                  ),
                )
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
              Expanded(
                child: ListView(
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                              image: AssetImage('assets/blob/blob1.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [
                                  const Color.fromARGB(255, 2, 7, 93)
                                      .withOpacity(0.8),
                                  const Color.fromARGB(255, 22, 6, 112)
                                      .withOpacity(0.1),
                                ],
                              ),
                            ),
                            child: balCard,
                          ),
                        ),
                        Positioned.fill(
                          right: -40,
                          bottom: -40,
                          child: GestureDetector(
                            onTap: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: const NewPlan(),
                                withNavBar: false,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                padding: const EdgeInsets.all(5.0),
                                width: 120,
                                height: 120,
                                decoration: const BoxDecoration(
                                  color: secondaryGoldColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned.fill(
                          right: 10,
                          bottom: 10,
                          child: GestureDetector(
                            onTap: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: const NewPlan(),
                                withNavBar: false,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 7,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    myPlans,
                    transactions,
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
