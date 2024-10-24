import 'package:invest/imports/imports.dart';

class SelectAmountWidget extends StatefulWidget {
  final Function(int) onAmountSelected;
  const SelectAmountWidget({super.key, required this.onAmountSelected});

  @override
  State<SelectAmountWidget> createState() => _SelectAmountWidgetState();
}

class _SelectAmountWidgetState extends State<SelectAmountWidget> {
  int selectedStartingAmount = -1;
  String customAmount = '';
  final List _startingAmount = [
    'KES 5,000',
    'KES 10,000',
    'KES 25,000',
    'KES 50,000',
    'KES 100,000',
    '',
  ];
  _updateCustomAmount(String value) {
    setState(() {
      customAmount = value;
    });
    widget.onAmountSelected(int.parse(customAmount));
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.0,
      runSpacing: 10,
      children: [
        ..._startingAmount.asMap().entries.map((entry) {
          int index = entry.key;
          String amount = entry.value;
          return Budge(
            active: selectedStartingAmount == index,
            text: (index == 5)
                ? (customAmount == '')
                    ? 'Different Amount'
                    : '${CurrencyConverter().convert(customAmount)}   ✏️'
                : amount,
            onTap: (data) {
              setState(() {
                selectedStartingAmount = index;
              });
              if (index == 5) {
                widget.onAmountSelected(0);
                showCustomBottomSheet(
                  context,
                  EnterAmountBottomWidget(onValueChanged: _updateCustomAmount),
                );
              } else {
                setState(() {
                  customAmount = '';
                });
              }
              if (index == 0) {
                widget.onAmountSelected(5000);
              } else if (index == 1) {
                widget.onAmountSelected(10000);
              } else if (index == 2) {
                widget.onAmountSelected(25000);
              } else if (index == 3) {
                widget.onAmountSelected(50000);
              } else if (index == 4) {
                widget.onAmountSelected(100000);
              }
            },
          );
        }),
      ],
    );
  }
}

class EnterAmountBottomWidget extends StatefulWidget {
  final Function(String) onValueChanged;
  const EnterAmountBottomWidget({super.key, required this.onValueChanged});

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
            widget.onValueChanged(amount);
          },
        ),
      ],
    );
  }
}
