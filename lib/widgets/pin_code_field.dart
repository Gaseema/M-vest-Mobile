import 'package:invest/imports/imports.dart';

class PinCodeField extends StatelessWidget {
  final bool filled;
  final bool hasError;
  final bool processing;

  const PinCodeField({
    super.key,
    required this.filled,
    required this.hasError,
    required this.processing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: filled ? 2 : 1,
          color: (hasError
              ? Colors.red
              : filled
                  ? primaryColor
                  : primaryColor.withOpacity(0.6)),
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: processing
            ? [
                const BoxShadow(
                  color: primaryColor,
                  spreadRadius: 1,
                  blurRadius: 8,
                )
              ]
            : [],
      ),
      child: Center(
        child: filled
            ? SvgPicture.asset(
                'assets/svg/asterisk.svg',
                width: 20,
                colorFilter: ColorFilter.mode(
                  hasError ? Colors.red : primaryColor,
                  BlendMode.srcIn,
                ),
              )
            : Container(),
      ),
    );
  }
}
