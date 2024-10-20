import 'package:invest/imports/imports.dart';

import 'package:flutter/material.dart';
import 'package:invest/utils/theme.dart';

class GoalTypeCard extends StatelessWidget {
  final Widget icon;
  final String goalType;
  final Function(dynamic) onTap;

  const GoalTypeCard(
      {super.key,
      required this.icon,
      required this.goalType,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(true);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 2, // Spread radius
              blurRadius: 5, // Blur radius
              offset: const Offset(0, 3), // Offset
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  icon,
                  const SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      goalType == 'Savings'
                          ? 'Grow my savings'
                          : 'Invest my money',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: primaryColor,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}
