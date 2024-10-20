import 'package:invest/imports/imports.dart';

import 'dart:ui' as ui;

class BalanceCard extends StatefulWidget {
  final String balance;
  final String userName;
  const BalanceCard({super.key, required this.balance, required this.userName});

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  bool amountHidden = true;
  @override
  Widget build(BuildContext context) {
    Widget balCard = Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: Image.asset(
                  'assets/icons/Mvest_M_app_icon.png',
                  width: SizeConfig.blockSizeHorizontal * 10,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    amountHidden = !amountHidden;
                  });
                },
                child: Image.asset(
                  amountHidden == false
                      ? 'assets/icons/eye_view.png'
                      : 'assets/icons/eye_hide.png',
                  width: SizeConfig.blockSizeHorizontal * 5,
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Savings Balance',
                  style: displaySmallBoldWhite,
                ),
                const SizedBox(height: 5),
                amountHidden == true
                    ? ImageFiltered(
                        imageFilter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Text(
                          'KES. 00000',
                          style: displayBigBoldWhite,
                        ),
                      )
                    : Text(
                        CurrencyConverter().convert(
                          widget.balance,
                        ),
                        style: displayBigBoldWhite,
                      ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.userName,
                style: displayNormalWhite,
              ),
            ],
          )
        ],
      ),
    );
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
              image: AssetImage('assets/blob/blob1.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  const Color.fromARGB(255, 2, 7, 93).withOpacity(0.8),
                  const Color.fromARGB(255, 22, 6, 112).withOpacity(0.1),
                ],
              ),
            ),
            child: balCard,
          ),
        ),
        Positioned.fill(
          right: -40,
          bottom: -40,
          child: GestureDetector(
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: const NewGoal(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: const EdgeInsets.all(5.0),
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: secondaryGoldColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          right: 10,
          bottom: 10,
          child: GestureDetector(
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: const NewGoal(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  '+',
                  style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 7,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
