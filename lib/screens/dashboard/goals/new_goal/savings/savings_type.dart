import 'package:invest/imports/imports.dart';

class SavingsType extends StatefulWidget {
  const SavingsType({super.key});

  @override
  State<SavingsType> createState() => SavingsTypeState();
}

class SavingsTypeState extends State<SavingsType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              title: 'Choose Goal Type',
              actions: const [],
              leadingOnTap: () {
                context.pop();
              },
              statusBarBrightness: Brightness.light,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  children: [
                    Text(
                      'Savings account',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w100,
                          ),
                    ),
                    const SizedBox(height: 20),
                    GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 0.7,
                      children: [
                        GradientImageContainer(
                          imageUrl: 'assets/goals/emergency.png',
                          text: 'Emergency',
                          gradientOpacity: 0.7,
                          onTap: () {
                            context.push('/payment_plan', extra: 'emergency');
                          },
                        ),
                        GradientImageContainer(
                          imageUrl: 'assets/goals/vacation.png',
                          text: 'Vacation',
                          gradientOpacity: 0.7,
                          onTap: () {
                            context.push('/payment_plan', extra: 'vacation');
                          },
                        ),
                        GradientImageContainer(
                          imageUrl: 'assets/goals/medical.png',
                          text: 'Medical',
                          gradientOpacity: 0.7,
                          onTap: () {
                            context.push('/payment_plan', extra: 'medical');
                          },
                        ),
                        GradientImageContainer(
                          imageUrl: 'assets/goals/wedding.png',
                          text: 'Wedding',
                          gradientOpacity: 0.7,
                          onTap: () {
                            context.push('/payment_plan', extra: 'wedding');
                          },
                        ),
                        GradientImageContainer(
                          imageUrl: 'assets/goals/furniture.png',
                          text: 'Furniture',
                          gradientOpacity: 0.7,
                          onTap: () {
                            context.push('/payment_plan', extra: 'furniture');
                          },
                        ),
                        GradientImageContainer(
                          imageUrl: 'assets/goals/other.png',
                          text: 'Other',
                          gradientOpacity: 0.7,
                          onTap: () {
                            context.push('/payment_plan', extra: 'other');
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Investment account',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w100,
                          ),
                    ),
                    const SizedBox(height: 20),
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 0.7,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        GradientImageContainer(
                          imageUrl: 'assets/goals/business.png',
                          text: 'Bonds',
                          gradientOpacity: 0.7,
                          onTap: () {
                            showToast(
                              context,
                              'Coming soon!',
                              'Investment services not available in your country',
                              Colors.red,
                            );
                          },
                        ),
                        GradientImageContainer(
                          imageUrl: 'assets/goals/realestate.png',
                          text: 'Real Estate',
                          gradientOpacity: 0.7,
                          onTap: () {
                            showToast(
                              context,
                              'Coming soon!',
                              'Investment services not available in your country',
                              Colors.red,
                            );
                          },
                        ),
                        GradientImageContainer(
                          imageUrl: 'assets/goals/stocks.png',
                          text: 'Stocks',
                          gradientOpacity: 0.7,
                          onTap: () {
                            showToast(
                              context,
                              'Coming soon!',
                              'Investment services not available in your country',
                              Colors.red,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
