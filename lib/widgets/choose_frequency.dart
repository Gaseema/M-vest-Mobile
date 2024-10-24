import 'package:invest/imports/imports.dart';

class SelectFrequencyWidget extends StatefulWidget {
  final Function(String) onFrequencySelected;
  const SelectFrequencyWidget({super.key, required this.onFrequencySelected});

  @override
  State<SelectFrequencyWidget> createState() => _SelectFrequencyWidgetState();
}

class _SelectFrequencyWidgetState extends State<SelectFrequencyWidget> {
  int selectedPlanFrequency = -1;
  final List _planFrequency = [
    'Daily',
    'Weekly',
    'Monthly',
    'Yearly',
    'Just this once',
  ];
  @override
  Widget build(BuildContext context) {
    return Wrap(
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
              if (index == 0) {
                widget.onFrequencySelected('daily');
              } else if (index == 1) {
                widget.onFrequencySelected('weekly');
              } else if (index == 2) {
                widget.onFrequencySelected('monthly');
              } else if (index == 3) {
                widget.onFrequencySelected('yearly');
              } else if (index == 4) {
                widget.onFrequencySelected('once');
              }
            },
          );
        }),
      ],
    );
  }
}
