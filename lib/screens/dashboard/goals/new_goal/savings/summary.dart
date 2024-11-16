import 'package:invest/imports/imports.dart';

class Summary extends StatefulWidget {
  final Map goalDetails;
  const Summary({super.key, required this.goalDetails});

  @override
  State<Summary> createState() => SummaryState();
}

class SummaryState extends State<Summary> {
  String? estimatedFutureAmount;
  calculateFinalValue(
    num amount,
    num minInterestRate,
    num maxInterestRate,
    String endDate,
  ) {
    DateTime parsedEndDate = DateFormat('yyyy-MMM-dd').parse(endDate);
    DateTime now = DateTime.now();

    // Calculate the number of months between the current date and the end date
    int months =
        ((parsedEndDate.year - now.year) * 12 + parsedEndDate.month - now.month)
            .toInt();

    // Convert annual interest rate to monthly
    double minMonthlyRate = minInterestRate / 12 / 100;
    double maxMonthlyRate = maxInterestRate / 12 / 100;

    // Calculate the final values
    double finalValueMin = amount * (1 + minMonthlyRate * months);
    double finalValueMax = amount * (1 + maxMonthlyRate * months);

    return ("KES ${formatNumberWithCommas(finalValueMin)} - ${formatNumberWithCommas(finalValueMax)}");
  }

  @override
  void initState() {
    super.initState();
    // Calculate the estimated future amount when the widget initializes
    estimatedFutureAmount = calculateFinalValue(
      widget.goalDetails['amount'],
      13,
      15,
      widget.goalDetails['timeline'],
    );
  }

  @override
  Widget build(BuildContext context) {
    // User Provider
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              title: 'Summary',
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
                      'Summary',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w100,
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 30,
                          ),
                    ),
                    const SizedBox(height: 40),
                    LabeledRow(
                      label: 'Plan Name',
                      value: capitalize(widget.goalDetails['planName']),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.black.withOpacity(0.2),
                    ),
                    LabeledRow(
                      label: 'Amount',
                      value: CurrencyConverter()
                          .convert(widget.goalDetails['amount'].toString()),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.black.withOpacity(0.2),
                    ),
                    const LabeledRow(
                      label: 'Interest rate',
                      value: '13 - 15% per annum',
                    ),
                    Divider(
                      height: 1,
                      color: Colors.black.withOpacity(0.2),
                    ),
                    LabeledRow(
                      label: 'Maturity Date',
                      value: widget.goalDetails['timeline'],
                    ),
                    Divider(
                      height: 1,
                      color: Colors.black.withOpacity(0.2),
                    ),
                    LabeledRow(
                      label: 'Estimated Future Amount',
                      value: estimatedFutureAmount ?? '',
                    ),
                    Divider(
                      height: 1,
                      color: Colors.black.withOpacity(0.2),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
            // Center(
            //   child: SizedBox(
            //     width: MediaQuery.of(context).size.width * 0.9,
            //     child: CustomButton(
            //       text: 'Choose Payment Method',
            //       url: null,
            //       method: 'POST',
            //       body: const {},
            //       onCompleted: (res) {
            //         showCustomBottomSheet(
            //           context,
            //           PaymentMethodWidget(
            //             onComplete: (res) {},
            //           ),
            //         );
            //       },
            //     ),
            //   ),
            // ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                text: 'Complete',
                url: '/plan/create',
                method: 'POST',
                body: {
                  'plan_name': widget.goalDetails['planName'],
                  'type': 'SAVINGS',
                  'description': 'savings',
                  'target_amount': widget.goalDetails['amount'],
                  'user_id': user!.id,
                  'maturity_date': widget.goalDetails['timeline'],
                },
                onCompleted: (res) {
                  try {
                    if (res['isSuccessful'] == true) {
                      context.push('/dashboard');
                    } else {
                      return showToast(
                        context,
                        'Error!',
                        res['error'],
                        Colors.red,
                      );
                    }
                  } catch (e) {
                    return showToast(
                      context,
                      'Error!',
                      'Error creating plan',
                      Colors.red,
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class LabeledRow extends StatelessWidget {
  final String label;
  final String value;

  const LabeledRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 12, color: const Color.fromRGBO(95, 101, 117, 1)),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
                  ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
