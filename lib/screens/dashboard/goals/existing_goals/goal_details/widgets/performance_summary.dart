import 'package:invest/imports/imports.dart';

class GoalPerformance extends StatelessWidget {
  final Plan planDetails;
  const GoalPerformance({
    super.key,
    required this.planDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Goal Performance',
          style: spacedTitleTextStyle(context),
        ),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.only(left: 3, right: 3),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [customBoxShadow],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PerformanceRow(
                leftText: 'Plan created on',
                rightText: formatDate(planDetails.createdAt, true),
              ),
              Divider(color: Colors.grey[300], thickness: 0.5),
              const PerformanceRow(
                leftText: 'Expected annual return',
                rightText: '0.00%',
              ),
              Divider(color: Colors.grey[300], thickness: 0.5),
              PerformanceRow(
                leftText: 'Total deposit',
                rightText: CurrencyConverter().convert(
                  planDetails.balance.toString(),
                ),
              ),
              Divider(color: Colors.grey[300], thickness: 0.5),
              const PerformanceRow(
                leftText: 'Total interest',
                rightText: 'KES 0.00',
              ),
              Divider(color: Colors.grey[300], thickness: 0.5),
              const PerformanceRow(
                leftText: 'Total withdrawals',
                rightText: 'KES 0.00',
              ),
            ],
          ),
        )
      ],
    );
  }
}

class PerformanceRow extends StatelessWidget {
  final String leftText;
  final String rightText;

  const PerformanceRow({
    super.key,
    required this.leftText,
    required this.rightText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leftText,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.black,
                  fontSize: 12,
                ),
          ),
          Text(
            rightText,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.black,
                  fontSize: 12,
                ),
          ),
        ],
      ),
    );
  }
}
