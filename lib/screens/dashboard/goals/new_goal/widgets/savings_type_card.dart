import 'package:flutter/material.dart';
import 'package:invest/utils/theme.dart';

class SavingsTypeCard extends StatelessWidget {
  final Widget icon;
  final String title;
  final String text;
  final Color color;
  final Function(dynamic) onTap;

  const SavingsTypeCard({
    super.key,
    required this.title,
    required this.icon,
    required this.text,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(true);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: color,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icon,
            const SizedBox(height: 10),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(1, 24, 78, 1),
                  ),
            ),
            const SizedBox(height: 15),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'LETS GO',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: primaryColor),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: primaryColor,
                  size: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
