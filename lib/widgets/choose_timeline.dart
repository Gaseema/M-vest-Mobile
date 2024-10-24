import 'package:invest/imports/imports.dart';

class SelectTimelineWidget extends StatefulWidget {
  final Function(String) onTimelineSelected;
  const SelectTimelineWidget({super.key, required this.onTimelineSelected});

  @override
  State<SelectTimelineWidget> createState() => _SelectTimelineWidgetState();
}

class _SelectTimelineWidgetState extends State<SelectTimelineWidget> {
  int selectedTimelineFrequency = -1;
  final List _planFrequency = [
    '3 months',
    '6 months',
    '9 months',
    '1 Yearly',
    'Let me choose',
  ];

  String? _selectedDate;

  // Function to show the date picker
  Future<void> _pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(
        const Duration(days: 1),
      ), // Start from tomorrow
      firstDate: DateTime.now().add(
        const Duration(days: 1),
      ), // Tomorrow as the minimum selectable date
      lastDate: DateTime(2101), // Any future date is allowed
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            textTheme: GoogleFonts.montserratTextTheme(
              Theme.of(context).textTheme.copyWith(
                    bodyMedium: const TextStyle(fontWeight: FontWeight.w400),
                    bodyLarge: const TextStyle(fontWeight: FontWeight.w500),
                  ),
            ),
            colorScheme: const ColorScheme.light(
              primary: primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        String formattedDate = DateFormat('yyyy-MMM-dd').format(pickedDate);
        _selectedDate = formattedDate;
        widget.onTimelineSelected(_selectedDate ?? '');
      });
    }
  }

  String addMonthsToCurrentDate(int months) {
    DateTime currentDate = DateTime.now();
    DateTime newDate =
        DateTime(currentDate.year, currentDate.month + months, currentDate.day);

    // Format the new date as 'year-MMM-dd'
    String formattedDate = DateFormat('yyyy-MMM-dd').format(newDate);
    widget.onTimelineSelected(formattedDate);
    return formattedDate;
  }

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
            active: selectedTimelineFrequency == index,
            text: (index == 4)
                ? (_selectedDate != null)
                    ? '$_selectedDate   ✏️'
                    : 'Let me choose'
                : amount,
            onTap: (data) {
              setState(() {
                selectedTimelineFrequency = index;
                _selectedDate = null;
              });

              if (index == 0) {
                addMonthsToCurrentDate(3);
              } else if (index == 1) {
                addMonthsToCurrentDate(6);
              } else if (index == 2) {
                addMonthsToCurrentDate(9);
              } else if (index == 3) {
                addMonthsToCurrentDate(12);
              } else if (index == 4) {
                widget.onTimelineSelected('');

                _pickDate(context);
                logger('not opening');
              }
            },
          );
        }),
      ],
    );
  }
}
