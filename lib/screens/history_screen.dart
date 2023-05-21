import 'package:calculator/main.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<Map<String, dynamic>>> history;

  @override
  void initState() {
    super.initState();
    history = dbHelper.getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: history,
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            final List<Map<String, dynamic>> historyData = snapshot.data!;
            return ListView.builder(
              itemCount: historyData.length,
              itemBuilder: (BuildContext context, int index) {
                final Map<String, dynamic> item = historyData[index];
                final String calculation = item['calculation'];
                final String time = item['time'];
                return ListTile(
                  title: Text(calculation),
                  subtitle: Text(time),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Text("Error occurred while loading history.");
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
