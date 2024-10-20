import 'package:invest/imports/imports.dart';
import 'package:invest/widgets/payment_method.dart';
import 'package:invest/widgets/dialog.dart';

class Summary extends StatefulWidget {
  const Summary({super.key});

  @override
  State<Summary> createState() => SummaryState();
}

class SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    const LabeledRow(
                      label: 'Amount',
                      value: 'KES 10,000',
                    ),
                    Divider(
                      height: 1,
                      color: Colors.black.withOpacity(0.2),
                    ),
                    const LabeledRow(
                      label: 'Interest rate',
                      value: '10% per annum',
                    ),
                    Divider(
                      height: 1,
                      color: Colors.black.withOpacity(0.2),
                    ),
                    const LabeledRow(
                      label: 'Maturity Date',
                      value: 'KES 10,000',
                    ),
                    Divider(
                      height: 1,
                      color: Colors.black.withOpacity(0.2),
                    ),
                    const LabeledRow(
                      label: 'Automation',
                      value: '28th of every month',
                    ),
                    Divider(
                      height: 1,
                      color: Colors.black.withOpacity(0.2),
                    ),
                    const LabeledRow(
                      label: 'Estimated Future Amount',
                      value: 'KES 50,000',
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
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: CustomButton(
                  text: 'Choose Payment Method',
                  url: null,
                  method: 'POST',
                  body: const {},
                  onCompleted: (res) {
                    showCustomBottomSheet(
                      context,
                      PaymentMethodWidget(
                        onComplete: (res) {},
                      ),
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
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16, color: const Color.fromRGBO(95, 101, 117, 1)),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                ),
          ),
        ],
      ),
    );
  }
}
