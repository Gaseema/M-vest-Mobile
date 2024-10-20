import 'package:invest/imports/imports.dart';

import 'package:invest/widgets/dialog.dart';

class PaymentPlan extends StatefulWidget {
  const PaymentPlan({super.key});

  @override
  State<PaymentPlan> createState() => PaymentPlanState();
}

class PaymentPlanState extends State<PaymentPlan> {
  int selectedStartingAmount = -1;
  int selectedPlanFrequency = -1;
  final List _startingAmount = [
    'KES 5,000',
    'KES 10,000',
    'KES 25,000',
    'KES 50,000',
    'KES 100,000',
    'Different Amount',
  ];
  final List _planFrequency = [
    'Daily',
    'Weekly',
    'Monthly',
    'Just this once',
    'Custom plan',
  ];
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
            ..._startingAmount.asMap().entries.map((entry) {
              int index = entry.key;
              String amount = entry.value;
              return Budge(
                active: selectedStartingAmount == index,
                text: amount,
                onTap: (data) {
                  if (_startingAmount[index] == 'Different Amount') {
                    showCustomBottomSheet(
                      context,
                      const EnterAmountBottomWidget(),
                    );
                  }
                },
              );
            }),
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
            ..._planFrequency.asMap().entries.map((entry) {
              int index = entry.key;
              String amount = entry.value;
              return Budge(
                active: selectedPlanFrequency == index,
                text: amount,
                onTap: (data) {
                  setState(() {
                    selectedPlanFrequency = index;
                  });
                },
              );
            }),
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

class EnterAmountBottomWidget extends StatefulWidget {
  const EnterAmountBottomWidget({super.key});

  @override
  State<EnterAmountBottomWidget> createState() =>
      _EnterAmountBottomWidgetState();
}

class _EnterAmountBottomWidgetState extends State<EnterAmountBottomWidget> {
  String amount = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter Amount',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: primaryColor.withOpacity(.2),
              width: 2,
            ),
          ),
          child: Text(
            amount.isEmpty ? 'Enter amount' : amount,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Keypad(
          actionButton: null,
          callback: (value) {
            if (amount == '' && value == '0') {
              return;
            }
            if (value == '<') {
              if (amount == '') {
                return;
              }
              return setState(() {
                amount = amount.substring(0, amount.length - 1);
              });
            }
            setState(() {
              amount = amount + value;
            });
          },
        ),
      ],
    );
  }
}
