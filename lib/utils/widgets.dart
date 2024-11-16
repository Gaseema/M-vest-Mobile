import 'package:invest/imports/imports.dart';

class TransactionCard extends StatelessWidget {
  final String? type;
  final String? amount;
  final String? plan;
  final String? time;
  final ValueSetter<dynamic>? callback;
  const TransactionCard({
    super.key,
    @required this.type,
    this.plan,
    this.amount,
    this.time,
    this.callback,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0.5,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(right: 10),
            decoration: const BoxDecoration(
              color: primaryDarkColor,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              'assets/icons/other.png',
              width: 20,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(plan!, style: displayNormalBolderBlack),
                      Text(type!, style: displaySmallerLightGrey),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '$amount',
                        style: displayNormalBolderGreen,
                      ),
                      Text(
                        formatDate(time!, false),
                        style: displaySmallerLightGrey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  final Plan plan;
  final ValueSetter<dynamic> callback;
  const PlanCard({
    super.key,
    required this.plan,
    required this.callback,
  });
  @override
  Widget build(BuildContext context) {
    final percentageDifference = calculateCurrentAmountPercentage(
      plan.balance, // balance
      plan.target, // target amount
    );
    return GestureDetector(
      onTap: () {
        context.push('/plan_details', extra: plan);
      },
      child: Container(
        width: SizeConfig.blockSizeHorizontal * 60,
        margin: const EdgeInsets.only(right: 10, bottom: 10, left: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0.5,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Image.asset(
                          'assets/icons/other3.png',
                          width: SizeConfig.blockSizeHorizontal * 4,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: Text(
                            capitalize(plan.name),
                            style: displayNormalBlack,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 234, 178, 22),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$percentageDifference%',
                    style: displaySmallWhite,
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            // Text(
            //   '$plan',
            //   style: displayNormalBoldBlack,
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  CurrencyConverter().convert(
                    plan.balance.toString(),
                  ),
                  style: displaySmallerLightGrey,
                ),
                Text(
                  CurrencyConverter().convert(plan.target.toString()),
                  style: displaySmallerLightGrey,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ProgressBar(progress: percentageDifference),
          ],
        ),
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  final double? progress;
  final ValueSetter<dynamic>? callback;
  const ProgressBar({
    super.key,
    this.progress,
    this.callback,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FractionallySizedBox(
          widthFactor: 1,
          child: Container(
            height: 10,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        FractionallySizedBox(
          widthFactor: progress! / 100,
          child: Container(
            height: 10,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}

class AllPlansCard extends StatelessWidget {
  final Plan planDetails;
  final ValueSetter<dynamic>? callback;
  const AllPlansCard({
    super.key,
    required this.planDetails,
    this.callback,
  });
  @override
  Widget build(BuildContext context) {
    final percentageDifference = calculateCurrentAmountPercentage(
        planDetails.balance, planDetails.target);
    return GestureDetector(
      onTap: () {
        context.push('/plan_details', extra: planDetails);
      },
      child: Container(
        width: SizeConfig.blockSizeHorizontal * 60,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0.5,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Image.asset(
                      'assets/icons/other2.png',
                      width: SizeConfig.blockSizeHorizontal * 4,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Text(
                      planDetails.type,
                      style: displayNormalBlack,
                    ),
                  ),
                ]),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 234, 178, 22),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$percentageDifference%',
                    style: displaySmallWhite,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              planDetails.name,
              style: displayNormalBoldBlack,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  //'${planBalance}',
                  CurrencyConverter().convert(planDetails.balance.toString()),

                  style: displaySmallerLightGrey,
                ),
                Text(
                  // '${target}',
                  CurrencyConverter().convert(planDetails.target.toString()),
                  style: displaySmallerLightGrey,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ProgressBar(progress: percentageDifference),
          ],
        ),
      ),
    );
  }
}

class WhyPeopleLoveMvest extends StatelessWidget {
  const WhyPeopleLoveMvest({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _buildSection(
            context,
            'Personalized Investment Plans',
            'Mvest takes the stress out of managing finances by offering tailored investment options based on your financial goals. Whether you’re growing wealth, saving for a purchase, or planning for retirement, Mvest provides flexible plans that fit your needs.',
          ),
          _buildSection(
            context,
            'Smart, Simple, and Safe',
            'With an intuitive interface and AI-powered insights, Mvest makes investing easy and enjoyable. Users love how Mvest simplifies complex processes, guiding them step by step, even if they’re new to investing.',
          ),
          _buildSection(
            context,
            'Real Results, Faster',
            'Mvest users are seeing real progress faster than expected. With strategies focused on growth, many reach their financial goals quicker while feeling secure about their investments.',
          ),
          _buildSection(
            context,
            'Transparency and Trust',
            'Mvest offers complete transparency. Users always know where their money is, how it’s growing, and what’s happening in real-time. Built on trust, Mvest ensures your funds are in safe hands.',
          ),
          _buildSection(
            context,
            'Financial Empowerment',
            'Beyond investing, Mvest empowers users with tools and insights for informed financial decisions. The educational content, tips, and analytics help users grow not only their wealth but also their financial knowledge.',
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: displayMediumBoldTextDarkBlue(context),
        ),
        const SizedBox(height: 8),
        Text(content, style: displayMediumTextDarkBlue(context)),
        const SizedBox(height: 16),
      ],
    );
  }
}
