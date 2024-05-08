// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:invest/screens/dashboard/goals/new_goal/new_goal.dart';
import 'package:invest/utils/constants.dart';
import 'package:invest/utils/theme.dart';
import 'package:invest/utils/widgets.dart';
import 'package:invest/utils/functions.dart';
import 'package:provider/provider.dart';
import 'package:invest/providers/user_provider.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Plans extends StatefulWidget {
  const Plans({Key? key}) : super(key: key);

  @override
  PlansState createState() => PlansState();
}

class PlansState extends State<Plans> {
  // Plan variables
  bool fetchingUserPlans = true;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: 30),
                    Text(
                      'Plans',
                      style: displayNormalBiggerSlightlyBoldBlack,
                    ),
                    GestureDetector(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: const NewGoal(),
                          withNavBar: false,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      child: Image.asset(
                        'assets/icons/more.png',
                        width: 25,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: fetchingUserPlans == false
                    ? userPlans.isNotEmpty
                        ? ListView.builder(
                            itemCount: userPlans.length,
                            itemBuilder: (BuildContext context, int index) {
                              final plan = userPlans[index];
                              final walletBalance =
                                  plan['Wallet']?['balance'] ?? 0;
                              // final walletBalance =
                              //     plan['Wallet']?['balance'] ?? 0;
                              final percentageDifference =
                                  calculateCurrentAmountPercentage(
                                      walletBalance, plan['target_amount']);

                              return AllPlansCard(
                                id: plan['id'],
                                type: plan['type'],
                                category: plan['category'],
                                planDescription: plan['description'],
                                plan: plan['goal_name'],
                                planBalance: walletBalance,
                                progress: percentageDifference,
                                target: plan['target_amount'],
                                createdAt: plan['createdAt'],
                                maturityDate: plan['maturity_date'],
                                locked: plan['locked'],
                                walletId: plan['Wallet']?['id'],
                                frequency: plan['frequency'],
                                callback: (res) {},
                              );
                            },
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
                                      screen: const NewGoal(),
                                      withNavBar: false,
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.cupertino,
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 10, 20, 10),
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
                    : const Center(
                        // padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
