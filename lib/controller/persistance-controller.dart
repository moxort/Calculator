import 'package:calculator/controller/history-service.dart';
import 'package:calculator/model/calculator-model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class PersistenceController {
  final CalculatorModel _calculatorModel = CalculatorModel();
  final HistoryService _historyService = HistoryService();

  bool isOperator(String x) {
    return _calculatorModel.isOperator(x);
  }

  String compute(String userInput) {
    return _calculatorModel.compute(userInput);
  }

  Future<void> computeAndSave(String userInput) async {
    String finaluserinput = userInput.replaceAll('x', '*');
    String answer = _calculatorModel.compute(finaluserinput);
    String calculation = "$userInput = $answer";
    String time = DateFormat("yyyy-MM-dd HH:mm").format(DateTime.now());
    await _historyService.saveCalculation(calculation, time);
  }

}

// Controller for the converter
class ConverterController {
  final ConversionModel _conversionModel = ConversionModel();

  double convertKmToMile(String kmString) {
    return _conversionModel.convertKmToMile(kmString);
  }
}




