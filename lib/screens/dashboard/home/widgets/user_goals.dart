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
      final planProvider = Provider.of<PlanProvider>(context, listen: false);
      List<Plan> plans = (res['data'] as List).map((planData) {
        return Plan(
          name: planData['plan_name'],
          type: planData['type'],
          maturityDate: planData['maturity_date'],
          lock: planData['lock'],
          balance: planData['wallet']['balance'],
          target: planData['target_amount'],
          createdAt: planData['createdAt'],
        );
      }).toList();
      planProvider.setPlans(plans);
      setState(() {
        fetchingUserPlans = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final planProvider = Provider.of<PlanProvider>(context);
    final userPlans = planProvider.plans;
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
                logger('should view all');
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
                        return PlanCard(
                          plan: userPlans[index],
                          callback: (res) {},
                        );
                      }),
                    ),
                  )
                // ? SingleChildScrollView(
                //     scrollDirection: Axis.horizontal,
                //     child: Row(
                //       children: List.generate(userPlans.length, (index) {
                //         return PlanCard(
                //           plan: userPlans[index],
                //           callback: (res) {},
                //         );
                //       }),
                //     ),
                //   )
                : Center(
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/make_plan.svg',
                          width: 200,
                        ),
                        GestureDetector(
                          onTap: () {
                            context.go('/create_new_goal');
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Text(
                              'Create a goal',
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
    );
  }
}
