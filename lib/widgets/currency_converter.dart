import 'package:invest/imports/imports.dart';

class CurrencyConverter {
  String convert(String num) {
    logger.i(num); // Log the input number
    double num2 = double.parse(num); // Parse the string into a double
    String output = "";

    // Regular expression to format the number with commas
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String mathFunc(Match match) => '${match[1]},';

    // Format the number with commas and two decimal points
    output = num2.toStringAsFixed(2).replaceAllMapped(reg, mathFunc);

    // Return the formatted value with "KES" currency
    return "KES $output";
  }
}
