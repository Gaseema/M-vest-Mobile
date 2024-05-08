import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:invest/widgets/appbar.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:invest/screens/dashboard/goals/new_goal/widgets/savings_type_card.dart';

class SavingsType extends StatefulWidget {
  const SavingsType({super.key});

  @override
  State<SavingsType> createState() => SavingsTypeState();
}

class SavingsTypeState extends State<SavingsType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              title: 'Choose Goal Type',
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
                    const SizedBox(height: 20),
                    SavingsTypeCard(
                      icon: SizedBox(
                        width: 50,
                        child: Image.asset('assets/icons/target.png'),
                      ),
                      title: 'Save towards a goal',
                      text:
                          'Do you want to save towards a goal and build discipline with a locked plan?',
                      color: const Color.fromRGBO(227, 252, 255, 1),
                      onTap: (val) {
                        context.push('/payment_plan');
                      },
                    ),
                    const SizedBox(height: 20),
                    SavingsTypeCard(
                      icon: SizedBox(
                        width: 50,
                        child: Image.asset('assets/icons/emergency.png'),
                      ),
                      title: 'Save for rainy days (Emergency, short term)',
                      text:
                          'Do you want a plan where you have free access to your funds for rainy days?',
                      color: const Color.fromRGBO(244, 244, 255, 1),
                      onTap: (val) {
                        context.push('/payment_plan');
                      },
                    ),
                    const SizedBox(height: 20),
                    SavingsTypeCard(
                      icon: SizedBox(
                        width: 50,
                        child: Image.asset('assets/icons/group.png'),
                      ),
                      title: 'Save in a group (Chama)',
                      text: 'Do you want to save with friends and family?',
                      color: const Color.fromRGBO(255, 246, 238, 1),
                      onTap: (val) {
                        context.push('/payment_plan');
                      },
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
