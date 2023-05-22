import 'package:math_expressions/math_expressions.dart';

class CalculatorModel {
  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  String compute(String userInput) {
    String finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    return eval.toString();
  }
}

class ConversionModel {
  double convertKmToMile(String kmString) {
    double km = double.tryParse(kmString) ?? 0.0;
    double mile = km * 0.6213712;

    return mile;
  }
}
