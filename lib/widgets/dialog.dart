import 'package:invest/imports/imports.dart';

class CustomBottomSheet extends StatelessWidget {
  final Widget child;

  const CustomBottomSheet({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
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

showFloatingBottomSheet(BuildContext context, Widget content) {
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
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ), // Padding inside the bottom sheet
            color: Colors.white,
            child: content,
          ),
        ),
      );
    },
  );
}

exitApp(context) {
  return showFloatingBottomSheet(
    context,
    Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Exit Mvest?',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.black,
              ),
        ),
        const SizedBox(height: 16.0),
        Text(
          "Are you sure you want to go? There’s more to explore!",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () => SystemNavigator.pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child:
                  Text('Leave', style: Theme.of(context).textTheme.bodyMedium!),
            ),
            const SizedBox(width: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
              ),
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Nevermind',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
