import 'package:invest/imports/imports.dart';

class PaymentPlan extends StatefulWidget {
  const PaymentPlan({super.key});

  @override
  State<PaymentPlan> createState() => PaymentPlanState();
}

class PaymentPlanState extends State<PaymentPlan> {
  int selectedAmount = -1;
  String selectedFrequency = '';

  void _onAmountSelected(int amount) {
    setState(() {
      selectedAmount = amount;
    });
    formValidationChecker();
  }

  void _onFrequencySelected(String frequency) {
    setState(() {
      selectedFrequency = frequency;
    });
    formValidationChecker();
  }

  // Form Validation
  bool isFormValid = false;
  String formValidationError = 'Enter an amount greater than KES 100';

  formValidationChecker() {
    logger('selectedAmount: $selectedAmount');
    logger('selectedFrequency: $selectedFrequency');
    if (selectedAmount < 100) {
      setState(() {
        isFormValid = false;
        formValidationError = 'Enter an amount greater than KES 100';
      });
    } else if (selectedFrequency.isEmpty) {
      setState(() {
        isFormValid = false;
        formValidationError = 'Choose how often you want to save for';
      });
    } else {
      setState(() {
        isFormValid = true;
        formValidationError = '';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    formValidationChecker();
  }

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
        const SizedBox(height: 30),
        SelectAmountWidget(onAmountSelected: _onAmountSelected),
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
        SelectFrequencyWidget(onFrequencySelected: _onFrequencySelected),
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
                  formValid: isFormValid,
                  validationMessage: formValidationError,
                  text: 'Continue',
                  url: null,
                  method: 'POST',
                  body: const {},
                  onCompleted: (res) {
                    context.push(
                      '/timeline_plan',
                      extra: {
                        'amount': selectedAmount,
                        'frequency': selectedFrequency,
                      },
                    );
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
