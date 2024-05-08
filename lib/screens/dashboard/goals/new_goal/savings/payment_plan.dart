import 'package:flutter/material.dart';
import 'package:invest/utils/theme.dart';
import 'package:invest/widgets/buttons.dart';
import 'package:invest/widgets/appbar.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class PaymentPlan extends StatefulWidget {
  const PaymentPlan({super.key});

  @override
  State<PaymentPlan> createState() => PaymentPlanState();
}

class PaymentPlanState extends State<PaymentPlan> {
  @override
  Widget build(BuildContext context) {
    Widget amount2start = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          'How much would you like to start with?',
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
              text: 'KES 5,000',
              onTap: (data) => {},
            ),
            Budge(
              text: 'KES 10,000',
              onTap: (data) => {},
            ),
            Budge(
              text: 'KES 25,000',
              onTap: (data) => {},
            ),
            Budge(
              text: 'KES 50,000',
              onTap: (data) => {},
            ),
            Budge(
              text: 'KES 100,000',
              onTap: (data) => {},
            ),
            Budge(
              text: 'Different Amount',
              onTap: (data) => {},
            ),
          ],
        ),
      ],
    );
    Widget howOften = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How often?',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w700,
                color: primaryColor,
                fontSize: 16,
              ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10.0,
          runSpacing: 10,
          children: [
            Budge(
              text: 'Daily',
              onTap: (data) => {},
            ),
            Budge(
              text: 'Weekly',
              onTap: (data) => {},
            ),
            Budge(
              text: 'Monthly',
              onTap: (data) => {},
            ),
            Budge(
              text: 'Just this once',
              onTap: (data) => {},
            ),
            Budge(
              text: 'Custom plan',
              onTap: (data) => {},
            ),
          ],
        ),
      ],
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              title: 'Payment Plan',
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
                      'Great Choice!',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w100,
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 30,
                          ),
                    ),
                    amount2start,
                    const SizedBox(height: 50),
                    howOften,
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
                    context.push('/timeline_plan');
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
