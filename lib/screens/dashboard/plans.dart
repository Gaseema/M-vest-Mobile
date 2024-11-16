import 'package:invest/imports/imports.dart';

class Plans extends StatefulWidget {
  const Plans({super.key});

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
        fetchingUserPlans = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final planProvider = Provider.of<PlanProvider>(context);
    final userPlans = planProvider.plans;
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
              imageUrl: 'assets/goals/business.png',
              text: 'Business',
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
      backgroundColor: Colors.white,
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
                    //   child: Image.asset(
                    //     'assets/icons/more.png',
                    //     width: 25,
                    //   ),
                    // )
                  ],
                ),
              ),
              Expanded(
                child: fetchingUserPlans == false
                    ? userPlans.isNotEmpty
                        ? ListView.builder(
                            itemCount: userPlans.length,
                            itemBuilder: (BuildContext context, int index) {
                              return AllPlansCard(
                                planDetails: userPlans[index],
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
