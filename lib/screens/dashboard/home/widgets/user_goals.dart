import 'package:invest/imports/imports.dart';

class UserGoals extends StatefulWidget {
  const UserGoals({super.key});

  @override
  State<UserGoals> createState() => _UserGoalsState();
}

class _UserGoalsState extends State<UserGoals> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'My Saving Goals',
              style: displayNormalSlightlyBoldBlack,
            ),
            GestureDetector(
              onTap: () {
                logger.i('should view all');
              },
              child: Text(
                'View all',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 14),
              ),
            ),
          ],
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
                        logger.i(membersList);
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
                        SvgPicture.asset(
                          'assets/svg/make_plan.svg',
                          width: 200,
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     PersistentNavBarNavigator.pushNewScreen(
                        //       context,
                        //       screen: const NewGoal(),
                        //       withNavBar: false,
                        //       pageTransitionAnimation:
                        //           PageTransitionAnimation.cupertino,
                        //     );
                        //   },
                        //   child: Container(
                        //     padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        //     decoration: BoxDecoration(
                        //       color: primaryColor,
                        //       borderRadius: BorderRadius.circular(7),
                        //     ),
                        //     child: Text(
                        //       'Create a goal',
                        //       style: displayNormalWhite,
                        //     ),
                        //   ),
                        // )
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
    );
  }
}
