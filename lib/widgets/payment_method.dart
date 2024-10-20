import 'package:invest/imports/imports.dart';

class PaymentMethodWidget extends StatefulWidget {
  final Function(dynamic) onComplete;
  const PaymentMethodWidget({super.key, required this.onComplete});

  @override
  State<PaymentMethodWidget> createState() => _PaymentMethodWidgetState();
}

class _PaymentMethodWidgetState extends State<PaymentMethodWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          'First Plan',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w100,
                color: Colors.black.withOpacity(0.5),
              ),
        ),
        const SizedBox(height: 10),
        Text(
          'KES 50,000',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 30,
                color: primaryColor,
              ),
        ),
        const SizedBox(height: 10),
        Text(
          'Pay with',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w100,
                color: Colors.black.withOpacity(0.5),
              ),
        ),
        const SizedBox(height: 50),
        const PaymentMethodTypeWidget(
          active: true,
          paymentMethod: 'M-Pesa',
        ),
        const SizedBox(height: 15),
        const Divider(),
        const SizedBox(height: 15),
        const PaymentMethodTypeWidget(
          active: false,
          paymentMethod: 'Bank',
        ),
        const SizedBox(height: 50),
        CustomButton(
          text: 'Done',
          url: null,
          method: 'POST',
          body: const {},
          onCompleted: (val) {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class PaymentMethodTypeWidget extends StatefulWidget {
  final String paymentMethod;
  final bool active;
  const PaymentMethodTypeWidget({
    super.key,
    required this.paymentMethod,
    required this.active,
  });

  @override
  State<PaymentMethodTypeWidget> createState() =>
      _PaymentMethodTypeWidgetState();
}

class _PaymentMethodTypeWidgetState extends State<PaymentMethodTypeWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.paymentMethod == 'Bank') {
          showToast(
            context,
            'Coming soon!',
            'Bank services not available',
            Colors.red,
          );
        }
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  widget.paymentMethod == 'M-Pesa'
                      ? Image.asset(
                          'assets/icons/mpesa.png',
                          width: 40,
                        )
                      : Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Image.asset(
                            'assets/icons/bank.png',
                            width: 20,
                          ),
                        ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.paymentMethod,
                        style:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(),
                      ),
                      widget.paymentMethod == 'Bank'
                          ? Text(
                              'Coming soon',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.grey[600]),
                            )
                          : Container(),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                color: widget.active == true
                    ? Colors.white
                    : Colors.black.withOpacity(0.4),
                shape: BoxShape.circle,
                border: Border.all(
                    color: widget.active == true
                        ? primaryColor
                        : Colors.transparent,
                    width: 3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
