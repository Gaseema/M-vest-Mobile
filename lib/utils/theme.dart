import 'package:invest/imports/imports.dart';

const Color primaryColor = Color.fromRGBO(0, 82, 255, 1);
const Color darkHeaderColor = Color.fromRGBO(8, 37, 82, 1);
const Color darkBlueTextColor = Color.fromRGBO(8, 37, 82, 1);
const Color textGreyColor = Color.fromARGB(255, 81, 81, 81);

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    textTheme: TextTheme(
      //Body Small
      bodySmall: GoogleFonts.montserrat(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),

      //Body Medium
      bodyMedium: GoogleFonts.montserrat(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),

      //Body Large
      bodyLarge: GoogleFonts.aBeeZee(
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: Colors.white,
      ),
    ),
  );
}

ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    textTheme: TextTheme(
      //Body Small
      bodySmall: GoogleFonts.montserrat(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),

      //Body Medium
      bodyMedium: GoogleFonts.montserrat(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),

      //Body Large
      bodyLarge: GoogleFonts.aBeeZee(
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: Colors.white,
      ),
    ),
  );
}

class MyTheme {
  static var lightTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: 96.0,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: GoogleFonts.poppins(
      fontSize: 64.0,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: GoogleFonts.poppins(
      fontSize: 48.0,
      fontWeight: FontWeight.bold,
    ),
  );
}

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;

  const CustomText({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? Theme.of(context).textTheme.displayMedium?.copyWith(),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class CustomRichText extends StatelessWidget {
  final List<TextSpan> textSpans;

  final int? maxLines;

  const CustomRichText({
    super.key,
    required this.textSpans,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: maxLines,
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium,
        children: textSpans,
      ),
    );
  }
}

TextStyle spacedTitleTextStyle(BuildContext context) {
  return Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: Colors.grey[500],
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
      );
}

//////////////////////////////////////////////////////////////////////
/// NEW TEXT THEME
//////////////////////////////////////////////////////////////////////
// Large Size
displayLargeTextDarkBlue(context) =>
    Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontSize: 40,
          color: darkBlueTextColor,
          height: 1.2,
        );

displayLargeTextNormal(context) =>
    Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontSize: 30,
          color: Colors.black,
          height: 1.2,
        );

// Medium Size
displayMediumTextDarkBlue(context) =>
    Theme.of(context).textTheme.bodyMedium?.copyWith(color: darkHeaderColor);

displayMediumBoldTextDarkBlue(context) => Theme.of(context)
    .textTheme
    .bodyMedium
    ?.copyWith(color: darkHeaderColor, fontWeight: FontWeight.w700);

displayMediumTextNormal(context) =>
    Theme.of(context).textTheme.bodyMedium?.copyWith();

displayMediumTextPrimaryBlue(context) =>
    Theme.of(context).textTheme.bodyMedium?.copyWith(color: primaryColor);

displayMediumTextRed(context) =>
    Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red);

// Small Size

//////////////////////////////////////////////////////////////////////
/// NEW TEXT THEME
//////////////////////////////////////////////////////////////////////
TextStyle displaySmallThinWhite = GoogleFonts.poppins(
  fontSize: 12,
  fontWeight: FontWeight.w300,
  color: Colors.white,
);
TextStyle displaySmallThinBlack = GoogleFonts.poppins(
  fontSize: 12,
  fontWeight: FontWeight.w300,
  color: Colors.black,
);
TextStyle displaySmallWhite = GoogleFonts.poppins(
  fontSize: 12,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);
TextStyle displaySmallGold = GoogleFonts.poppins(
  fontSize: 12,
  fontWeight: FontWeight.w500,
  color: secondaryGoldColorDarker,
);
TextStyle displaySmallBoldWhite = GoogleFonts.poppins(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);
TextStyle displaySmallBoldLightGrey = GoogleFonts.poppins(
  fontSize: 10,
  fontWeight: FontWeight.bold,
  color: Colors.black.withOpacity(0.4),
);
TextStyle displaySmallerLightGrey = GoogleFonts.poppins(
  fontSize: 13,
  fontWeight: FontWeight.w500,
  color: Colors.black.withOpacity(0.4),
);
TextStyle displayBigBoldWhite = GoogleFonts.poppins(
  fontSize: 25,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);
TextStyle displayBigBoldBlack = GoogleFonts.poppins(
  fontSize: 25,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
TextStyle displayNormalWhite = GoogleFonts.poppins(
  fontSize: 15,
  fontWeight: FontWeight.w300,
  color: Colors.white,
);
TextStyle displayNormalWhiteBold = GoogleFonts.poppins(
  fontSize: 15,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);
TextStyle displayNormalBlack = GoogleFonts.poppins(
  fontSize: 15,
  fontWeight: FontWeight.w300,
  color: Colors.black,
);
TextStyle displayNormalGrey = GoogleFonts.poppins(
  fontSize: 12,
  fontWeight: FontWeight.w300,
  color: Colors.grey,
);
TextStyle displayNormalGrey1 = GoogleFonts.poppins(
  fontSize: 12,
  fontWeight: FontWeight.w300,
  color: Colors.grey,
);
TextStyle displayNormalBolderBlack = GoogleFonts.poppins(
  fontSize: 15,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);
TextStyle displayNormalBolderDarkBlue = GoogleFonts.poppins(
  fontSize: 15,
  fontWeight: FontWeight.w500,
  color: primaryDarkColor,
);
TextStyle displayNormalBolderDarkBlueHeading = GoogleFonts.poppins(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  color: primaryDarkColor,
);
TextStyle displayNormalBolderDarkBlueT = GoogleFonts.poppins(
  fontSize: 15,
  fontWeight: FontWeight.w500,
  color: primaryDarkColor,
);
TextStyle displayNormalBolderGreen = GoogleFonts.poppins(
  fontSize: 15,
  fontWeight: FontWeight.w500,
  color: Colors.green,
);
TextStyle displayNormalBolderRed = GoogleFonts.poppins(
  fontSize: 15,
  fontWeight: FontWeight.w500,
  color: Colors.red,
);
TextStyle displayNormalLightGrey = GoogleFonts.poppins(
  fontSize: 15,
  fontWeight: FontWeight.w500,
  color: Colors.black.withOpacity(0.3),
);
TextStyle displayNormalBoldBlack = GoogleFonts.poppins(
  fontSize: 15,
  fontWeight: FontWeight.w700,
  color: Colors.black,
);
TextStyle displayNormalSlightlyBoldBlack = GoogleFonts.poppins(
  fontSize: 15,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);
TextStyle displayNormalBiggerSlightlyBoldBlack = GoogleFonts.poppins(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);
TextStyle displayKeyPadTextBlack = GoogleFonts.poppins(
  fontSize: 25,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);
