import 'package:invest/imports/imports.dart';

class TimelinePlan extends StatefulWidget {
  final Map paymentPlan;
  const TimelinePlan({super.key, required this.paymentPlan});

  @override
  State<TimelinePlan> createState() => TimelinePlanState();
}

class TimelinePlanState extends State<TimelinePlan> {
  String planEndDate = '';
  _updateTimelinePicked(String timePicked) {
    setState(() {
      planEndDate = timePicked;
    });
    formValidationChecker();
  }

// Form Validation
  bool isFormValid = false;
  String formValidationError = 'Select plan timeline';

  formValidationChecker() {
    if (planEndDate == '') {
      setState(() {
        isFormValid = false;
        formValidationError = 'Select plan timeline';
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
    Widget timelineSetting = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          'How long do you want to save for?',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w700, color: primaryColor),
        ),
        const SizedBox(height: 40),
        SelectTimelineWidget(onTimelineSelected: _updateTimelinePicked),
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              title: 'Timeline Plan',
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
                    timelineSetting,
                    const SizedBox(height: 50),
                    // estimatedValue,
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
                    context.push('/summary', extra: {
                      'amount': widget.paymentPlan['amount'],
                      'frequency': widget.paymentPlan['frequency'],
                      'timeline': planEndDate,
                    });
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
