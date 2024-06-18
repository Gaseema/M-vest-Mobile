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
import 'package:flutter_svg/flutter_svg.dart';

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
    Widget featuredGoals = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Featured goals",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
        ),
        const SizedBox(height: 20),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.7,
          children: const [
            GradientImageContainer(
              imageUrl: 'assets/goals/emergency.avif',
              text: 'Emergency',
              gradientOpacity: 0.7,
            ),
            GradientImageContainer(
              imageUrl: 'assets/goals/business.png',
              text: 'Business',
              gradientOpacity: 0.7,
            ),
            GradientImageContainer(
              imageUrl: 'assets/goals/land.avif',
              text: 'Travel',
              gradientOpacity: 0.7,
            ),
            GradientImageContainer(
              imageUrl: 'assets/goals/insurance.png',
              text: 'Chama',
              gradientOpacity: 0.7,
            ),
            GradientImageContainer(
              imageUrl: 'assets/goals/other.png',
              text: 'Other',
              gradientOpacity: 0.7,
            ),
          ],
        ),
      ],
    );

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
                    Text(
                      'Goals',
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
                        : Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'Unlock your dreams by saving today—watch your money grow with our unbeatable interest rates!',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              featuredGoals,
                            ],
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

class GradientImageContainer extends StatelessWidget {
  final String imageUrl;
  final String text;
  final double gradientOpacity;

  const GradientImageContainer({
    Key? key,
    required this.imageUrl,
    required this.text,
    this.gradientOpacity = 0.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image
        SizedBox(
          height: 300, // Set the desired height here
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 300,
            ),
          ),
        ),

        // Gradient overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent, // Transparent at the top
                  Colors.black.withOpacity(
                      gradientOpacity), // Black with opacity at the bottom
                ],
              ),
            ),
          ),
        ),

        // Text
        Positioned(
          bottom: 10,
          left: 20,
          right: 20,
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                  fontSize: 10,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
