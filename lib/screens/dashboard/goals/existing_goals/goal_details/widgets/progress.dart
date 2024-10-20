import 'package:invest/imports/imports.dart';

class Progress extends StatelessWidget {
  final num planBalance;
  final num? target;
  final double progress;
  const Progress({
    super.key,
    required this.progress,
    required this.planBalance,
    this.target,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 3, right: 3),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [customBoxShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progress',
                style: spacedTitleTextStyle(context),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$progress%',
                  style: displaySmallWhite,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ProgressBar(progress: progress),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                CurrencyConverter().convert(planBalance.toString()),
                style: spacedTitleTextStyle(context),
              ),
              Text(
                ' ${CurrencyConverter().convert(target.toString())}',
                style: spacedTitleTextStyle(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
