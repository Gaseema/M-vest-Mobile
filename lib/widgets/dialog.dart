import 'package:flutter/material.dart';
import 'package:invest/utils/theme.dart';

class CustomBottomSheet extends StatelessWidget {
  final Widget child;

  const CustomBottomSheet({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(255, 253, 252, 1),
            Color.fromRGBO(235, 235, 235, 1),
          ],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            height: 5,
            width: MediaQuery.of(context).size.width * 0.2,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(228, 226, 235, 1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

void showCustomBottomSheet(BuildContext context, Widget content) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return CustomBottomSheet(child: content);
    },
  );
}

showFloatingBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 50,
        ), // Padding around the bottom sheet
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: primaryColor,
            child: Padding(
              padding:
                  const EdgeInsets.all(16.0), // Padding inside the bottom sheet
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Remember your password',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "Remember your password. If you if you forget your password you'll have reset your password",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Close'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
