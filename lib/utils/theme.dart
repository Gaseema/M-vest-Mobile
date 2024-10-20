import 'package:invest/imports/imports.dart';

const Color primaryColor = Color.fromRGBO(0, 82, 255, 1);
const Color darkHeaderColor = Color.fromRGBO(8, 37, 82, 1);
const Color textGreyColor = Color.fromARGB(255, 81, 81, 81);

class MyTheme {
  static var lightTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: 96.0, // Largest heading
      fontWeight: FontWeight.bold,
    ),
    displayMedium: GoogleFonts.poppins(
      fontSize: 64.0, // Large heading
      fontWeight: FontWeight.bold,
    ),
    displaySmall: GoogleFonts.poppins(
      fontSize: 48.0, // Medium heading
      fontWeight: FontWeight.bold,
    ),
  );
}

TextStyle spacedTitleTextStyle(BuildContext context) {
  return Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: Colors.grey[500],
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
      );
}

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
