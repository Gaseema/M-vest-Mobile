import 'package:invest/imports/imports.dart';

class PaymentPlan extends StatefulWidget {
  final String planType;
  const PaymentPlan({super.key, required this.planType});

  @override
  State<PaymentPlan> createState() => PaymentPlanState();
}

class PaymentPlanState extends State<PaymentPlan> {
  String planName = '';
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
    if (widget.planType == 'other' && planName.isEmpty) {
      setState(() {
        isFormValid = false;
        formValidationError = 'Enter plan name';
      });
    } else if (selectedAmount < 100) {
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
    setState(() {
      planName = widget.planType == 'other' ? '' : widget.planType;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget planNameWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.planType == 'other'
            ? Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name your plan',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                            color: primaryColor,
                            fontSize: 16,
                          ),
                    ),
                    const SizedBox(height: 20),
                    InputWidget(
                      hintText: 'Example: House Furniture',
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        setState(() {
                          planName = value;
                        });
                        formValidationChecker();
                      },
                    ),
                  ],
                ),
              )
            : Container(),
      ],
    );
    Widget amount2start = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          'How much would you like to save?',
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
                    planNameWidget,
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
                        'planName': planName,
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
