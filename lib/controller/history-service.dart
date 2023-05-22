import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference get historyCollection => firestore.collection('history');

  Future<void> saveCalculation(String calculation, String time) async {
    Map<String, dynamic> record = {
      'calculation': calculation,
      'timestamp': time,
    };
    await historyCollection.add(record);
    print("History saved successfully.");
  }
}