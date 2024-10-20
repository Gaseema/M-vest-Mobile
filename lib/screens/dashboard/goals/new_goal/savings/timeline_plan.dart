import 'package:invest/imports/imports.dart';

class TimelinePlan extends StatefulWidget {
  const TimelinePlan({super.key});

  @override
  State<TimelinePlan> createState() => TimelinePlanState();
}

class TimelinePlanState extends State<TimelinePlan> {
  @override
  Widget build(BuildContext context) {
    Widget timelineSetting = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          'How long do you want to save for?',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w700, color: primaryColor),
        ),
        const SizedBox(height: 40),
        Wrap(
          spacing: 10.0,
          runSpacing: 10,
          children: [
            Budge(
              active: false,
              text: '3 months',
              onTap: (data) => {},
            ),
            Budge(
              active: false,
              text: '6 months',
              onTap: (data) => {},
            ),
            Budge(
              active: false,
              text: '9 months',
              onTap: (data) => {},
            ),
            Budge(
              active: false,
              text: '1 year',
              onTap: (data) => {},
            ),
            Budge(
              active: false,
              text: 'Let me choose',
              onTap: (data) => {},
            ),
          ],
        ),
      ],
    );

    // Widget estimatedValue = Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Text(
    //       'Estimated Future Amount',
    //       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
    //             color: Colors.black.withOpacity(0.5),
    //             fontSize: 14,
    //           ),
    //     ),
    //     Text(
    //       'KES 50,000',
    //       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
    //             color: const Color.fromRGBO(68, 187, 76, 1),
    //             fontSize: 30,
    //           ),
    //     ),
    //     const SizedBox(height: 20),
    //     Text(
    //       'Interest Rate',
    //       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
    //             color: Colors.black.withOpacity(0.5),
    //             fontSize: 14,
    //           ),
    //     ),
    //     Text(
    //       '11% p.a.',
    //       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
    //             color: const Color.fromRGBO(68, 187, 76, 1),
    //             fontSize: 30,
    //           ),
    //     ),
    //     const SizedBox(height: 20),
    //     Text(
    //       'This estimate assumes you have KES 10,000 monthly, 3 times between today and your maturity date, July 04, 2024.',
    //       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
    //             color: Colors.black.withOpacity(0.5),
    //             fontSize: 14,
    //           ),
    //     )
    //   ],
    // );

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              title: 'Timeline Plan',
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
                    timelineSetting,
                    const SizedBox(height: 50),
                    // estimatedValue,
                  ],
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: CustomButton(
                  text: 'Continue',
                  url: null,
                  method: 'POST',
                  body: const {},
                  onCompleted: (res) {
                    context.push('/summary');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
