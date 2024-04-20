class CurrencyConverter {
  String convert(String num) {
    print(num);
    double num2 = double.parse(num);
    String output = "";
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc(Match match) => '${match[1]},';
    output = num2.toStringAsFixed(2).replaceAllMapped(reg, mathFunc);
    return "KES 2";
  }
}
